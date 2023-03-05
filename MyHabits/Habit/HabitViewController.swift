//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Roman Romanov on 05.03.2023.
//

import UIKit

class HabitViewController: UIViewController {

    private let habitView = HabitView()
    
    override func loadView() {
        super.loadView()
        view = habitView
        
        makeBarItem()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        habitView.nameTextField.addTarget(self, action: #selector(textChanged), for: .editingDidEnd)
//        habitView.datePicker?.addTarget(self, action: #selector(handleDateSelection), for: .valueChanged)
    }
    
    @objc func textChanged(_ textField: UITextField) {
        print("\(String(describing: textField.placeholder)):", textField.text!)
    }
    
    @objc func colorWellChanged(_ sender: Any) {
        print("button clicked")
//        habitView.colorWell.backgroundColor = habitView.colorWell.selectedColor
//        view.backgroundColor = habitView.colorButton.selectedColor
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
        // TODO: -
//        let newHabit = Habit(name: "Выпить стакан воды перед завтраком",
//                             date: Date(),
//                             color: .systemRed)
//        let store = HabitsStore.shared
//        store.habits.append(newHabit)
        
        dismiss(animated: true)
    }
    
    @objc private func cancelAction() {
        print("Отмена")
        dismiss(animated: true)
    }

}
