//
//  UIView+Extension.swift
//  MyHabits
//
//  Created by Roman Romanov on 12.03.2023.
//

import UIKit

extension UIView {
    static var identifier: String {
        String(describing: self)
    }
    
    func makeCollectionView(scrolllDirection: UICollectionView.ScrollDirection) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = scrolllDirection
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = AppCoolors.backgroundColor
        
        return collectionView
    }
}
