//
//  HabitsCollectionViewCell.swift
//  MyHabits
//
//  Created by Roman Romanov on 12.03.2023.
//

import UIKit

final class HabitsCollectionViewCell: UICollectionViewCell {
    
    private var todayProgress = HabitsStore.shared.todayProgress

    private var habit = Habit(name: "",
                              date: UIDatePicker().date,
                              color: AppCoolors.orange)
    
    private var progressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AppFontSettings.footnoteStatus
        label.textColor = AppFontSettings.footnoteStatusColor
        label.text = "Все получится!"
        
        return label
    }()
    
    private lazy var progressValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AppFontSettings.footnoteStatus
        label.textColor = AppFontSettings.footnoteStatusColor

        let todayProgress = self.todayProgress * 100
        label.text = "\(todayProgress)%"
        
        return label
    }()
    
    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progressTintColor = AppCoolors.purple
        progressView.trackTintColor = AppCoolors.gray2
        progressView.progress = self.todayProgress
        
        return progressView
    }()
    
    private var habitNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AppFontSettings.headline
        label.textColor = AppFontSettings.headlineColor
        label.text = "Unknown"
        
        return label
    }()
    
    private var habitTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AppFontSettings.caption
        label.textColor = AppFontSettings.captionColor
        label.text = "Каждый день в ..."
        
        return label
    }()
    
    private var habitCounterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AppFontSettings.footnote
        label.textColor = AppFontSettings.footnoteColor
        label.text = "Счетчик: n\\a"
        
        return label
    }()
    
    private var checkBoxButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage(systemName: "checkmark"), for: .selected)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 3
        button.layer.cornerRadius = Metric.checkBoxButtonSize / 2
        button.isUserInteractionEnabled = true
        
        return button
    }()
    
    @objc func toggleCheckboxSelection() {
        guard habit.isAlreadyTakenToday == false else { return }
        
        checkBoxButton.isSelected = !checkBoxButton.isSelected
        
        if (checkBoxButton.isSelected == true) {
            checkBoxButton.layer.backgroundColor = checkBoxButton.layer.borderColor
            checkBoxButton.tintColor = AppCoolors.backgroundColor
            
            HabitsStore.shared.track(habit)
            // MARK: - reload data
            NotificationCenter.default.post(name: NSNotification.Name("load"), object: nil)
        } else {
            checkBoxButton.layer.backgroundColor = AppCoolors.backgroundColor.cgColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        generalSettings()
        
        checkBoxButton.addTarget(self, action: #selector(toggleCheckboxSelection), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        checkBoxButton.tintColor = AppCoolors.backgroundColor
        checkBoxButton.layer.backgroundColor = AppCoolors.backgroundColor.cgColor
        
        for subview in contentView.subviews {
             subview.removeFromSuperview()
        }
    }
    
    func setupCell(habit: Habit) {
        self.habit = habit
        habitNameLabel.textColor = habit.color
        habitNameLabel.text = habit.name
        habitTimeLabel.text = habit.dateString
        habitCounterLabel.text = "Счетчик: \(habit.trackDates.count)"
        
        checkBoxButton.isSelected = habit.isAlreadyTakenToday
        checkBoxButton.layer.borderColor = habit.color.cgColor
        
        if (checkBoxButton.isSelected == true) {
            checkBoxButton.layer.backgroundColor = habit.color.cgColor
            checkBoxButton.tintColor = AppCoolors.backgroundColor
        }
        
        layout()
    }
    
    func generalSettings() {
        backgroundColor = AppCoolors.backgroundColor
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    
    func setupProgressCell() {
        layoutProgress()
    }
    
    func layoutProgress() {
        contentView.addSubview(progressLabel)
        contentView.addSubview(progressValueLabel)
        contentView.addSubview(progressView)
        
        NSLayoutConstraint.activate([
            progressLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Metric.progressTopAnchorInset),
            progressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metric.progressSideInset),
            
            progressValueLabel.topAnchor.constraint(equalTo: progressLabel.topAnchor),
            progressValueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metric.progressSideInset),
            
            progressView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metric.progressSideInset),
            progressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metric.progressSideInset),
            progressView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Metric.progressBarBottomAnchorInset),
        ])
    }
    
    func layout() {
        contentView.addSubview(habitNameLabel)
        contentView.addSubview(habitTimeLabel)
        contentView.addSubview(habitCounterLabel)
        contentView.addSubview(checkBoxButton)

        NSLayoutConstraint.activate([
            habitNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Metric.habbitsCellectionViewCellInset),
            habitNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metric.habbitsCellectionViewCellInset),
//            habitNameLabel.widthAnchor.constraint(equalToConstant: Metric.habbitsCellectionViewCellHeaderWidth),
//            habitNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            habitNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            habitTimeLabel.topAnchor.constraint(equalTo: habitNameLabel.bottomAnchor, constant: Metric.habbitsCellectionViewInnerHeaderInset),
            habitTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metric.habbitsCellectionViewCellInset),
            
            
            checkBoxButton.heightAnchor.constraint(equalToConstant: Metric.checkBoxButtonSize),
            checkBoxButton.widthAnchor.constraint(equalToConstant: Metric.checkBoxButtonSize),
            checkBoxButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metric.checkBoxButtonTrailingAnchorInset),
            checkBoxButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            habitCounterLabel.topAnchor.constraint(equalTo: habitTimeLabel.bottomAnchor, constant: Metric.habbitsCellectionViewInnerInset),
            habitCounterLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metric.habbitsCellectionViewCellInset),
            habitCounterLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Metric.habbitsCellectionViewCellInset),
        ])
    }
}
