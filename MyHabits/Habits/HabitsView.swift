//
//  HabitsView.swift
//  MyHabits
//
//  Created by Roman Romanov on 04.03.2023.
//

import UIKit

class HabitsView: UIView {
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "plus")
        button.setBackgroundImage(image, for: .normal)
        button.tintColor = AppCoolors.purple
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = AppCoolors.white
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(addButton)
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Metric.addButtonTopAnchorInset),
            addButton.widthAnchor.constraint(equalToConstant: Metric.addButtonSize),
            addButton.heightAnchor.constraint(equalToConstant: Metric.addButtonSize),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Metric.addButtonTrailingAnchorInset),
        ])
    }

}
