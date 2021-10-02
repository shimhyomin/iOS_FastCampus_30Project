//
//  CreditCardTableViewCell.swift
//  CreditCardList
//
//  Created by shm on 2021/09/27.
//

import UIKit

class CreditCardTableViewCell: UITableViewCell {

    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var prmotionLabel: UILabel!
    @IBOutlet weak var creditLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
