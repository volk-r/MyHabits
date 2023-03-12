//
//  HabitsCollectionViewHeader.swift
//  MyHabits
//
//  Created by Roman Romanov on 12.03.2023.
//

import UIKit

class HabitsCollectionViewHeader: UICollectionReusableView {
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 34, weight: .bold)
        label.text = "Сегодня"
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame) 
        backgroundColor = AppCoolors.backgroundHabitsViewColor
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(headerLabel)
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metric.habbitsCellectionViewHeaderLabelInset),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metric.habbitsCellectionViewHeaderLabelInset),
            headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Metric.habbitsCellectionViewHeaderLabelInset),
        ])
    }
}
