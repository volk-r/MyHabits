//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Roman Romanov on 05.03.2023.
//

import UIKit

final class HabitViewController: UIViewController {

    private let habitView = HabitView()
    
    override func loadView() {
        super.loadView()
        view = habitView
        
        makeBarItem()
        setTimeToLabel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        habitView.nameTextField.addTarget(self, action: #selector(textChanged), for: .editingDidEnd)
        habitView.datePicker.addTarget(self, action: #selector(handler), for: .valueChanged)
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
    
    private func makeBarItem() {
        navigationItem.title = "Создать"
        
        let rigthBarItem = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(saveAction))
        rigthBarItem.tintColor = AppCoolors.purple
        navigationItem.rightBarButtonItem = rigthBarItem

        let leftBarItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancelAction))
        leftBarItem.tintColor = AppCoolors.purple
        navigationItem.leftBarButtonItem = leftBarItem
    }
    
    @objc private func saveAction() {
        print("save new habit")
        guard let habitName = habitView.nameTextField.text, habitName != "" else { print("save failed"); return }
        
        let newHabit = Habit(name: habitName,
                             date: habitView.datePicker.date,
                             color: habitView.colorWell.selectedColor ?? AppCoolors.orange)
        let store = HabitsStore.shared
        store.habits.append(newHabit)
        
        // MARK: - reload data
        NotificationCenter.default.post(name: NSNotification.Name("load"), object: nil)
        
        dismiss(animated: true)
    }
    
    @objc private func cancelAction() {
        print("Отмена")
        dismiss(animated: true)
    }

}
