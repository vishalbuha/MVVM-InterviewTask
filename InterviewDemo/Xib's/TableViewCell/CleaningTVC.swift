//
//  CleaningTVC.swift
//  InterviewDemo
//
//  Created by AkshCom on 18/05/22.
//

import UIKit

class CleaningTVC: UITableViewCell {
    
    var addQuantityBtn : ((_ aCell: CleaningTVC) -> Void)?
    var minusQuantityBtn : ((_ aCell: CleaningTVC) -> Void)?

    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var serviceLbl: UILabel!
    @IBOutlet weak var addQuantityBackView: View!
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func clickToAddQuantity(_ sender: UIButton)
    {
        if ((self.addQuantityBtn) != nil)
        {
            self.addQuantityBtn!(self)
        }
    }
    
    @IBAction func clickToMinusQuantity(_ sender: UIButton)
    {
        if ((self.minusQuantityBtn) != nil)
        {
            self.minusQuantityBtn!(self)
        }
    }
    
    
}
