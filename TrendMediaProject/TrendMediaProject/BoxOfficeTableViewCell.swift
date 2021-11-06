//
//  BoxOfficeTableViewCell.swift
//  TrendMediaProject
//
//  Created by sungyeon kim on 2021/10/26.
//

import UIKit

class BoxOfficeTableViewCell: UITableViewCell {

    static let identifier = "BoxOfficeTableViewCell"
    
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var orderLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
