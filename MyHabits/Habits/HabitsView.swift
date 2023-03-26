//
//  HabitsView.swift
//  MyHabits
//
//  Created by Roman Romanov on 04.03.2023.
//

import UIKit

protocol HabitsViewDelegzte: AnyObject {
    func openHabitDetailsFromController(indexPath: IndexPath)
}

final class HabitsView: UIView {
    
    weak var habitsViewDelegzte: HabitsViewDelegzte?
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "plus")
        button.setBackgroundImage(image, for: .normal)
        button.tintColor = AppCoolors.purple
        
        return button
    }()
    
    lazy var habitsCollectionView: UICollectionView = {
        let collectionView = makeCollectionView(scrolllDirection: .vertical)
        
        collectionView.register(HabitsCollectionViewCell.self, forCellWithReuseIdentifier: HabitsCollectionViewCell.identifier)
        
        collectionView.register(HabitsCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HabitsCollectionViewHeader.identifier)
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout // casting is required because UICollectionViewLayout doesn't offer header pin. Its feature of UICollectionViewFlowLayout
        layout?.sectionHeadersPinToVisibleBounds = true
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = AppCoolors.backgroundHabitsViewColor
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(addButton)
        addSubview(habitsCollectionView)
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Metric.addButtonTopAnchorInset),
            addButton.widthAnchor.constraint(equalToConstant: Metric.addButtonSize),
            addButton.heightAnchor.constraint(equalToConstant: Metric.addButtonSize),
            addButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: Metric.addButtonTrailingAnchorInset),
            
            habitsCollectionView.topAnchor.constraint(equalTo: addButton.bottomAnchor),
            habitsCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            habitsCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            habitsCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }

}

extension HabitsView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        HabitsStore.shared.habits.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HabitsCollectionViewHeader.identifier, for: indexPath)
            
            return header

        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.item == 0) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HabitsCollectionViewCell.identifier, for: indexPath) as! HabitsCollectionViewCell
            cell.setupProgressCell(with: HabitsStore.shared.todayProgress)

            return cell
        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HabitsCollectionViewCell.identifier, for: indexPath) as! HabitsCollectionViewCell
        cell.setupCell(habit: HabitsStore.shared.habits[indexPath.item - 1])
        cell.setIndexPath(indexPath)
        cell.habitsCollectionViewCellDelegate = self

        return cell
    }
    
}

extension HabitsView: UICollectionViewDelegateFlowLayout {
    private var sideInset: CGFloat { return Metric.habbitsCellectionViewLeadingAnchorInset + Metric.habbitsCellectionViewTrailingAnchorInset }
    private var elementCount: CGFloat { return CGFloat(HabitsStore.shared.habits.count + 1) }
    private var insetCount: CGFloat { return elementCount + 1 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var heigth: CGFloat = 130

        if (indexPath.item == 0) {
            heigth = 60
        }

        let width = collectionView.bounds.width - sideInset
        return CGSize(width: width, height: heigth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(
            top: Metric.habbitsCellectionViewTopAnchorInset,
            left: Metric.habbitsCellectionViewLeadingAnchorInset,
            bottom: Metric.habbitsCellectionViewBottomAnchorInset,
            right: Metric.habbitsCellectionViewTrailingAnchorInset
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width - sideInset, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Metric.habbitsCellectionViewMinimumInteritemSpacingForSection
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Metric.habbitsCellectionViewMinimumInteritemSpacingForSection
    }
}

extension HabitsView: HabitsCollectionViewCellDelegate {
    func habitsCollectionViewReloadData() {
        habitsCollectionView.reloadData()
    }
    
    func openHabitDetails(indexPath: IndexPath) {
        habitsViewDelegzte?.openHabitDetailsFromController(indexPath: indexPath)
    }
    
}
