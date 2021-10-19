//
//  BookCollectionViewCell.swift
//  TrendMediaProject
//
//  Created by sungyeon kim on 2021/10/20.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BookCollectionViewCell"
    
    @IBOutlet var bookTitleLabel: UILabel!
    @IBOutlet var bookRateLabel: UILabel!
    @IBOutlet var bookImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
