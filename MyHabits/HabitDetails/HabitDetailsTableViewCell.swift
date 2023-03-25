//
//  HabitDetailsViewCell.swift
//  MyHabits
//
//  Created by Roman Romanov on 25.03.2023.
//

import UIKit

final class HabitDetailsTableViewCell: UITableViewCell {
    
    private let contentCellView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var dateLabel: UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AppFontSettings.body
        label.textColor = AppFontSettings.bodyColor
        label.numberOfLines = 0
        
        return label
    }
    
    private var imageTracked: UIImageView {
        let image = UIImage(systemName: "checkmark")
        let imageView = UIImageView(image: image!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = AppCoolors.purple
        imageView.isHidden = true
        return imageView
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dateLabel.text = ""
        imageTracked.isHidden = true
    }
    
    func setupCell(date: String, isTrackedIn: Bool) {
        // TODO: -
        print(date, isTrackedIn)
        dateLabel.text = date
        imageTracked.isHidden = isTrackedIn
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        [
            contentCellView,
            // TODO: - trace
//            dateLabel,
//            imageTracked,
        ].forEach{ contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            contentCellView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            contentCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentCellView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
            
//            dateLabel.topAnchor.constraint(equalTo: contentCellView.topAnchor),
//            dateLabel.leadingAnchor.constraint(equalTo: contentCellView.leadingAnchor),
//            dateLabel.trailingAnchor.constraint(equalTo: contentCellView.trailingAnchor),
//            dateLabel.bottomAnchor.constraint(equalTo: contentCellView.bottomAnchor),
            
//            imageTracked.topAnchor.constraint(equalTo: contentCellView.topAnchor),
//            imageTracked.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
//            imageTracked.trailingAnchor.constraint(equalTo: contentCellView.trailingAnchor),
//            imageTracked.bottomAnchor.constraint(equalTo: contentCellView.bottomAnchor),
        ])
    }

}
