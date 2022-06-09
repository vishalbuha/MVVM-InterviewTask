//
//  SelectSizeTVC.swift
//  InterviewDemo
//
//  Created by AkshCom on 18/05/22.
//

import UIKit

class SelectSizeTVC: UITableViewCell {

    @IBOutlet weak var radioBtn: UIButton!
    @IBOutlet weak var sizeLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
