//
//  CartVC.swift
//  InterviewDemo
//
//  Created by AkshCom on 24/05/22.
//

import UIKit

class CartVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    
    var ProductListVM: ProductListViewModel = ProductListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    func configUI() {
        registerTableViewCell()
    }
    
    //MARK: - Button Click
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - TableView DataSource and Delegate Methods
extension CartVC : UITableViewDelegate, UITableViewDataSource {
    func registerTableViewCell() {
        tblView.register(UINib(nibName: TABLE_VIEW_CELL.CartTVC.rawValue, bundle: nil), forCellReuseIdentifier: TABLE_VIEW_CELL.CartTVC.rawValue)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProductListVM.ProdctResponse.value.cart.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tblView.dequeueReusableCell(withIdentifier: TABLE_VIEW_CELL.CartTVC.rawValue, for: indexPath) as? CartTVC
            else {
            return UITableViewCell()
        }
        
        cell.countLbl.text = "\(ProductListVM.ProdctResponse.value.cart[indexPath.row].itemQuantity)"
        cell.priceLbl.text = getDoubleValue(Double(ProductListVM.ProdctResponse.value.cart[indexPath.row].totalPrice * ProductListVM.ProdctResponse.value.cart[indexPath.row].itemQuantity))
        cell.titleLbl.text = ProductListVM.ProdctResponse.value.cart[indexPath.row].selectedModifier?.name.first
        
        cell.addQuantityBtn = {(_ aCell: CartTVC) -> Void in
            self.ProductListVM.ProdctResponse.value.cart[indexPath.row].itemQuantity = self.ProductListVM.ProdctResponse.value.cart[indexPath.row].itemQuantity + 1
            self.tblView.reloadData()
        }
        
        cell.minusQuantityBtn = {(_ aCell: CartTVC) -> Void in
            self.ProductListVM.ProdctResponse.value.cart[indexPath.row].itemQuantity = self.ProductListVM.ProdctResponse.value.cart[indexPath.row].itemQuantity - 1
            if self.ProductListVM.ProdctResponse.value.cart[indexPath.row].itemQuantity == 0 {
                self.ProductListVM.ProdctResponse.value.cart.remove(at: indexPath.row)
                self.navigationController?.popViewController(animated: true)
            }
            self.tblView.reloadData()
        }
        
        cell.cancelCartBtn = {(_ aCell: CartTVC) -> Void in
            self.ProductListVM.ProdctResponse.value.cart.remove(at: indexPath.row)
            self.navigationController?.popViewController(animated: true)
        }
        
        return cell
    }
    
}
