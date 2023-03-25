//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Roman Romanov on 25.03.2023.
//

import UIKit

final class HabitDetailsViewController: UIViewController {
    
    init(habit: Habit) {
        super.init(nibName: nil, bundle: nil)
        view = HabitDetailsView(habit: habit)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        makeBarItem()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func makeBarItem() {
        navigationItem.title = "Сделать зарядку"
        self.navigationController?.navigationBar.isHidden = false
        
        let rigthBarItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(changelAction))
        navigationItem.rightBarButtonItem = rigthBarItem
    }
    
    @objc private func changelAction() {
        print("change habit")
//        guard let habitName = habitView.nameTextField.text, habitName != "" else { print("save failed"); return }
//
//        let newHabit = Habit(name: habitName,
//                             date: habitView.datePicker.date,
//                             color: habitView.colorWell.selectedColor ?? AppCoolors.orange)
//        let store = HabitsStore.shared
//        store.habits.append(newHabit)
//
//        // MARK: - reload data
//        NotificationCenter.default.post(name: NSNotification.Name("load"), object: nil)
        
        self.navigationController?.popViewController(animated: true)
    }

}
