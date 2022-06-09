//
//  ViewController.swift
//  InterviewDemo
//
//  Created by AkshCom on 17/05/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cartBtn: Button!
    @IBOutlet weak var priceLbl: UILabel!
    
    @IBOutlet weak var customizeBtn: Button!
    @IBOutlet weak var quantityBackView: View!
    @IBOutlet weak var quantityLbl: UILabel!
    @IBOutlet var repeatBackView: UIView!
    @IBOutlet weak var customizeLbl: UILabel!
    
    private var ProductListVM: ProductListViewModel = ProductListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    
    func configUI() {
        repeatBackView.isHidden = true
        quantityBackView.isHidden = true
        ProductListVM.getServiceList()
        
        ProductListVM.ProdctResponse.bind { [weak self](_) in
            guard let `self` = self else { return }
            if self.ProductListVM.success.value {
                if self.ProductListVM.ProdctResponse.value.cart.count != 0 {
                    self.quantityBackView.isHidden = false
                    self.customizeBtn.isHidden = true
                    self.quantityLbl.text = "\(self.ProductListVM.ProdctResponse.value.cart.map({$0.itemQuantity}).reduce(0, +))"
                    self.cartBtn.setTitle("\(self.ProductListVM.ProdctResponse.value.cart.count)", for: .normal)
                }
                else {
                    self.quantityBackView.isHidden = true
                    self.customizeBtn.isHidden = false
                    self.quantityLbl.text = "0"
                    self.cartBtn.setTitle("0", for: .normal)
                }
            }
        }
    }

    //MARK: - Button Click
    @IBAction func clickToCustomize(_ sender: Any) {
        repeatBackView.isHidden = true
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddPackageVC") as! AddPackageVC
        vc.AllData = ProductListVM
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickToRepeatList(_ sender: Any) {
        repeatBackView.isHidden = true
        ProductListVM.ProdctResponse.value.cart[ProductListVM.ProdctResponse.value.cart.count - 1].itemQuantity = ProductListVM.ProdctResponse.value.cart[ProductListVM.ProdctResponse.value.cart.count - 1].itemQuantity + 1
    }
    
    @IBAction func clickToAddQuantity(_ sender: Any) {
        if ProductListVM.ProdctResponse.value.cart.count == 0 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddPackageVC") as! AddPackageVC
            vc.AllData = ProductListVM
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            repeatBackView.isHidden = false
            customizeLbl.text = "Customizations: \(ProductListVM.ProdctResponse.value.cart.last?.selectedModifier?.name.first ?? "")"
            displaySubViewtoParentView(self.view, subview: repeatBackView)
        }
    }
    
    @IBAction func clickToMinusQuantity(_ sender: Any) {
        if ProductListVM.ProdctResponse.value.cart.last?.itemQuantity == 1 {
            quantityBackView.isHidden = true
            customizeBtn.isHidden = false
            cartBtn.setTitle("0", for: .normal)
        }
        else{
            ProductListVM.ProdctResponse.value.cart[ProductListVM.ProdctResponse.value.cart.count - 1].itemQuantity = ProductListVM.ProdctResponse.value.cart[ProductListVM.ProdctResponse.value.cart.count - 1].itemQuantity - 1
            quantityLbl.text = "\(ProductListVM.ProdctResponse.value.cart.last?.itemQuantity)"
            cartBtn.setTitle("\(ProductListVM.ProdctResponse.value.cart.last?.itemQuantity)", for: .normal)
        }
    }
    
    @IBAction func clickToCart(_ sender: Any) {
        if ProductListVM.ProdctResponse.value.cart.count != 0 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CartVC") as! CartVC
            vc.ProductListVM = ProductListVM
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ViewController: updateCustomCartDelegate {
    func updateCustomCartData(totalPrice: Int) {
        quantityBackView.isHidden = false
        customizeBtn.isHidden = true
        quantityLbl.text = "\(ProductListVM.ProdctResponse.value.cart.map({$0.itemQuantity}).reduce(0, +))"
        cartBtn.setTitle("\(ProductListVM.ProdctResponse.value.cart.count)", for: .normal)
        
        if ProductListVM.ProdctResponse.value.cart.last?.selectedModifier != nil {
            customizeLbl.text = ProductListVM.ProdctResponse.value.cart.last?.selectedModifier!.name.first
        }
    }
}
