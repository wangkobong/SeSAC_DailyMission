//
//  SummaryCollectionViewCell.swift
//  TrendMediaProject
//
//  Created by sungyeon kim on 2021/10/19.
//

import UIKit

class SummaryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SummaryCollectionViewCell"
    
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var summaryLabel: UITextView!
    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
