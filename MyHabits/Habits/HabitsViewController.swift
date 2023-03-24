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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadList(notification:)), name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    @objc func loadList(notification: NSNotification) {
        habitsView.habitsCollectionView.reloadData()
    }
    
    @objc private func addAction () {
        let habbitVC = HabitViewController()
        let habbitController = UINavigationController(rootViewController: habbitVC)
        habbitController.modalPresentationStyle = .fullScreen
        self.navigationController?.present(habbitController, animated: true)
    }

}

