//
//  UITableViewCell+Extension.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/02.
//

import UIKit

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension UITableViewCell: ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
