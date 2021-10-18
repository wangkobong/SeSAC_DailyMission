//
//  CastmatesTableViewCell.swift
//  TrendMediaProject
//
//  Created by sungyeon kim on 2021/10/17.
//

import UIKit

class CastmatesTableViewCell: UITableViewCell {
    @IBOutlet var actorImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var roleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
