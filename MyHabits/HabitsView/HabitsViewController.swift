//
//  ViewController.swift
//  MyHabits
//
//  Created by Roman Romanov on 04.03.2023.
//

import UIKit

class HabitsViewController: UIViewController {
    
    private let habitsView = HabitsView()
    
    override func loadView() {
        super.loadView()
        view = habitsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

