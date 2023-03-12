//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Roman Romanov on 04.03.2023.
//

import UIKit

final class InfoViewController: UIViewController {
    
    private let infoView = InfoView()
    
    override func loadView() {
        super.loadView()
        view = infoView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Информация"
    }

}
