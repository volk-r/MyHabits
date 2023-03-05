//
//  HabitView.swift
//  MyHabits
//
//  Created by Roman Romanov on 05.03.2023.
//

import UIKit

class HabitView: UIView {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        return contentView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "НАЗВАНИЕ"
        
        return label
    }()
    
    lazy var nameTextField: UITextField = {
        let nameTextField = UITextField()
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        
        nameTextField.layer.backgroundColor = UIColor.systemGray6.cgColor
        nameTextField.textColor = AppCoolors.blue
        nameTextField.font = .systemFont(ofSize: 16, weight: .bold)
        nameTextField.autocapitalizationType = .none
        
        nameTextField.delegate = self
        
        return nameTextField
    }()
    
    private let colorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "ЦВЕТ"
        
        return label
    }()

    
    lazy var colorWell: UIColorWell = {
        let colorWell = UIColorWell()
        colorWell.translatesAutoresizingMaskIntoConstraints = false
        colorWell.title = "Выберите цвет"
        colorWell.selectedColor = AppCoolors.orange
        
        return colorWell
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "ВРЕМЯ"
        
        return label
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.date = .now
        datePicker.timeZone = NSTimeZone.local
        
        return datePicker
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
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(nameTextField)
        contentView.addSubview(colorLabel)
        contentView.addSubview(colorWell)
        contentView.addSubview(timeLabel)
//        contentView.addSubview(datePicker)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: Metric.habitInset),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metric.mainInset),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metric.mainInset),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Metric.habitInset),
            nameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metric.mainInset),
            nameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metric.mainInset),
            
            colorLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: Metric.habitInset),
            colorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metric.mainInset),
            colorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metric.mainInset),
            
            colorWell.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: Metric.habitInset),
            colorWell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metric.mainInset),
            colorWell.heightAnchor.constraint(equalToConstant: 40),
            colorWell.widthAnchor.constraint(equalToConstant: 40),
            
            timeLabel.topAnchor.constraint(equalTo: colorWell.bottomAnchor, constant: Metric.habitInset),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metric.mainInset),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metric.mainInset),
            
//            datePicker.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: Metric.habitInset),
//            datePicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metric.mainInset),
//            datePicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metric.mainInset),
//            datePicker.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Metric.mainInset),
            timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Metric.mainInset),
        ])
    }
    
}

extension HabitView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        
        return true
    }
}
