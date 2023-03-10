//
//  InfoView.swift
//  MyHabits
//
//  Created by Roman Romanov on 04.03.2023.
//

import UIKit

final class InfoView: UIView {

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        return contentView
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AppFontSettings.title3
        label.textColor = AppFontSettings.title3Color
        label.text = "Привычка за 21 день"
        
        return label
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AppFontSettings.body
        label.textColor = AppFontSettings.bodyColor
        label.text = habitText
        label.numberOfLines = 0
        label.textAlignment = .justified
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = AppCoolors.backgroundColor
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(headerLabel)
        contentView.addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            headerLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Metric.infoHeaderTopInset),
            headerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metric.mainInset),
            headerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metric.mainInset),
            headerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            textLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: Metric.mainInset * 1.5),
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metric.mainInset),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metric.mainInset),
            textLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -Metric.mainInset),
        ])
    }

}
