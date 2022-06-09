//
//  CartTVC.swift
//  InterviewDemo
//
//  Created by AkshCom on 24/05/22.
//

import UIKit

class CartTVC: UITableViewCell {

    var addQuantityBtn : ((_ aCell: CartTVC) -> Void)?
    var minusQuantityBtn : ((_ aCell: CartTVC) -> Void)?
    var cancelCartBtn : ((_ aCell: CartTVC) -> Void)?
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
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
    
    @IBAction func clickToCancel(_ sender: UIButton)
    {
        if ((self.cancelCartBtn) != nil)
        {
            self.cancelCartBtn!(self)
        }
    }
    
}
