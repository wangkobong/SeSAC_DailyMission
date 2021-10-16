//
//  MediaTableViewCell.swift
//  TrendMediaProject
//
//  Created by sungyeon kim on 2021/10/16.
//

import UIKit

class MediaTableViewCell: UITableViewCell {

    @IBOutlet var genreTextLabel: UILabel!
    @IBOutlet var titleTextLabel: UILabel!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
