//
//  ViewController.swift
//  MyHabits
//
//  Created by Roman Romanov on 04.03.2023.
//

import UIKit

final class HabitsViewController: UIViewController {
    
    private let habitsView = HabitsView()
    
    override func loadView() {
        super.loadView()
        view = habitsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        habitsView.addButton.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        
        habitsView.habitsViewDelegzte = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        habitsView.habitsCollectionView.reloadData()
    }
    
    @objc private func addAction () {
        let habbitVC = HabitViewController()
        let habbitController = UINavigationController(rootViewController: habbitVC)
        habbitController.modalPresentationStyle = .fullScreen
        self.navigationController?.present(habbitController, animated: true)
    }
    
}

extension HabitsViewController: HabitsViewDelegzte {
    func openHabitDetailsFromController(indexPath: IndexPath) {
        let habit = HabitsStore.shared.habits[indexPath.row - 1]
        let habitDetailsVC = HabitDetailsViewController(habit: habit)
        self.navigationController?.pushViewController(habitDetailsVC, animated: true)
    }
    
}
