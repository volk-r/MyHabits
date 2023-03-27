//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Roman Romanov on 25.03.2023.
//

import UIKit

final class HabitDetailsViewController: UIViewController {
    
    private let habit: Habit!
    
    init(habit: Habit) {
        self.habit = habit
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
        self.navigationController?.navigationBar.isHidden = false
        makeBarItem()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func makeBarItem() {
        navigationItem.title = habit.name
        
        let rigthBarItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(changeHabit(_:)))
        navigationItem.rightBarButtonItem = rigthBarItem
        
        let backButton = UIBarButtonItem()
        backButton.title = "Сегодня"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    @objc private func changeHabit(_ sender: UIBarButtonItem) {
        print("change habit")
        let habitVC = HabitViewController()
        habitVC.habitState = .edit
        habitVC.setupHabitData(habit: habit)
        self.navigationController?.pushViewController(habitVC, animated: true)
    }

}
