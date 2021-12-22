//
//  PosterCollectionViewCell.swift
//  SearchTVShows
//
//  Created by sungyeon kim on 2021/12/21.
//

import UIKit

class PosterCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PosterCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: PosterCollectionViewCell.identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .link
    }

}
