//
//  UICollectionViewCell+Extension.swift
//  SearchTVShows
//
//  Created by sungyeon kim on 2021/12/21.
//

import UIKit

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension UICollectionViewCell: ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
