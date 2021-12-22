//
//  HeaderCollectionReusableView.swift
//  SearchTVShows
//
//  Created by sungyeon kim on 2021/12/21.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "HeaderCollectionReusableView"
    
    let label: UILabel = {
       let label = UILabel()
        label.text = "header"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    func configure() {
        backgroundColor = .systemBlue
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
}
