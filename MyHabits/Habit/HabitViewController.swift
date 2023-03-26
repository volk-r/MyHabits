//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Roman Romanov on 05.03.2023.
//

import UIKit

enum HabitVCState {
    case create, edit
}

final class HabitViewController: UIViewController {
    
    var habitState: HabitVCState = .create

    private let habitView = HabitView()
    private var habit: Habit?
    
    override func loadView() {
        super.loadView()
        view = habitView
        
        makeBarItem()
        setTimeToLabel()
        
        if habitState == .edit {
            habitView.deleteButton.isHidden = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        habitView.nameTextField.addTarget(self, action: #selector(textChanged), for: .editingDidEnd)
        habitView.datePicker.addTarget(self, action: #selector(handler), for: .valueChanged)
        
        habitView.deleteButton.addTarget(self, action: #selector(deleteHabitAction), for: .touchUpInside)
    }
    
    @objc func deleteHabitAction() {
        print("deleteHabitAction")
        let vc = UIAlertController(title: "Удалит привычку", message: "Вы хотите удалить привычку \"\(habitView.nameTextField.text!)\"", preferredStyle: .alert)
        vc.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        vc.addAction(UIAlertAction(title: "Удалить", style: .destructive){ _ in
            HabitsStore.shared.habits.removeAll{ $0 == self.habit }
            let vcs = self.navigationController!.viewControllers
            self.navigationController?.popToViewController(vcs[vcs.count - 2], animated: true)
        })
        
        self.present(vc, animated: true)
    }
    
    @objc func textChanged(_ textField: UITextField) {
        print("\(String(describing: textField.placeholder)):", textField.text!)
    }
    
    @objc func colorWellChanged(_ sender: Any) {
        print("color selected")
        habitView.colorWell.backgroundColor = habitView.colorWell.selectedColor
    }
    
    @objc func handler() {
        setTimeToLabel()
    }
    
    private func setTimeToLabel() {
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = DateFormatter.Style.short
        let strDate = timeFormatter.string(from: habitView.datePicker.date)
        habitView.timeDescriptionValueLabel.text = strDate
    }
    
    func setupHabitData(habit: Habit) {
        self.habit = habit
        habitView.nameTextField.text = habit.name
        habitView.colorWell.selectedColor = habit.color
        habitView.timeDescriptionValueLabel.text = habit.dateString
        habitView.datePicker.date = habit.date
    }
    
    private func makeBarItem() {
        navigationItem.title = self.habitState == .create ? "Создать" : "Править"
        
        let rigthBarItem = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(saveAction))
        navigationItem.rightBarButtonItem = rigthBarItem
        navigationItem.rightBarButtonItem?.tintColor = AppCoolors.purple

        let leftBarItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancelAction))
        navigationItem.leftBarButtonItem = leftBarItem
        navigationItem.leftBarButtonItem?.tintColor = AppCoolors.purple
    }
    
    @objc private func saveAction() {
        print("save new habit")
        
        if habitState == .create {
            guard let habitName = habitView.nameTextField.text, habitName != "" else { print("save failed"); return }
            
            let newHabit = Habit(name: habitName,
                                 date: habitView.datePicker.date,
                                 color: habitView.colorWell.selectedColor ?? AppCoolors.orange)
            HabitsStore.shared.habits.append(newHabit)
            
            dismiss(animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
            let habitChanged = HabitsStore.shared.habits.first { $0 == habit }
            
            if let habitChanged {
                habitChanged.name = habitView.nameTextField.text!
                habitChanged.color = habitView.colorWell.selectedColor ?? AppCoolors.orange // habitChanged.color
                habitChanged.date = habitView.datePicker.date
            }
            let vcs = self.navigationController!.viewControllers
            self.navigationController?.popToViewController(vcs[vcs.count - 2], animated: true)
        }
    }
    
    @objc private func cancelAction() {
        print("Отмена")
        
        switch habitState {
        case .create:
            dismiss(animated: true)
        case .edit:
            self.navigationController?.popViewController(animated: true)
        }
    }

}
