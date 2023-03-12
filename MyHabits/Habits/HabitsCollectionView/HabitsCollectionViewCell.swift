//
//  HabitsCollectionViewCell.swift
//  MyHabits
//
//  Created by Roman Romanov on 12.03.2023.
//

import UIKit

final class HabitsCollectionViewCell: UICollectionViewCell {
    
    private var todayProgress = HabitsStore.shared.todayProgress
    
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
    
    func setupCell(habbit: Habit) {
        generalSettings()
//        layout()
    }
    
    func generalSettings() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    
    func setupProgressCell() {
        generalSettings()
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
            progressValueLabel.leadingAnchor.constraint(equalTo: progressLabel.trailingAnchor, constant: Metric.progresslabelInset),
            progressValueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metric.progressSideInset),
            
            progressView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metric.progressSideInset),
            progressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metric.progressSideInset),
            progressView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Metric.progressBarBottomAnchorInset),
        ])
    }
    
//    func layout() {
//        contentView.addSubview(cellImageView)
//
//        NSLayoutConstraint.activate([
//            cellImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            cellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            cellImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            cellImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//        ])
//    }
}
