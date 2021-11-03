//
//  CastTableViewCell.swift
//  TrendMediaProject
//
//  Created by sungyeon kim on 2021/10/31.
//

import UIKit

class CastTableViewCell: UITableViewCell {
    
    static let identifier = "CastTableViewCell"

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
