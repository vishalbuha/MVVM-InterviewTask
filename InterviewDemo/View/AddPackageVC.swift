//
//  AddPackageVC.swift
//  InterviewDemo
//
//  Created by AkshCom on 18/05/22.
//

import UIKit

protocol updateCustomCartDelegate {
    func updateCustomCartData(totalPrice: Int)
}

class AddPackageVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var itemCountLbl: UILabel!
    @IBOutlet weak var addOrderBtn: Button!
    
    var AllData: ProductListViewModel = ProductListViewModel()
    private var ProductListVM: ProductListViewModel = ProductListViewModel()
    var delegate: updateCustomCartDelegate?
    var sizePrice: Int = Int()
    var totalPrice: Int = Int()
    var isRepeat: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    func configUI() {
        registerTableViewCell()
        
        ProductListVM.getServiceList()
        ProductListVM.ProdctResponse.bind { [weak self](_) in
            guard let `self` = self else { return }
            if self.ProductListVM.success.value {
                self.ProductListVM.success.value = false
                self.ProductListVM.ProdctResponse.value.itemQuantity = 1
                self.refreshDataWithSize()
            }
            DispatchQueue.main.async {
                self.tblView.reloadData()
            }
        }
    }
    
    func refreshDataWithSize() {
        let apartmentData = ProductListVM.ProdctResponse.value.specifications.filter({$0.type == 1})
        let listData = apartmentData.first!.list.filter({$0.isDefaultSelected}).map({$0.id})
        
        sizePrice = apartmentData.first!.list.filter({$0.isDefaultSelected}).map({$0.price}).first!
        
        self.ProductListVM.ProdctResponse.value.specifications = ProductListVM.ProdctResponse.value.specifications.filter({$0.type == 1})
        self.ProductListVM.ProdctResponse.value.specifications.append(contentsOf: self.AllData.ProdctResponse.value.specifications.filter({$0.type != 1}).filter({$0.modifierID == listData.first}))
        
        for i in 0...self.ProductListVM.ProdctResponse.value.specifications.count - 1 {
            if self.ProductListVM.ProdctResponse.value.specifications[i].type != 1 {
                self.ProductListVM.ProdctResponse.value.specifications[i].list = self.ProductListVM.ProdctResponse.value.specifications[i].list.sorted(by: { $0.sequenceNumber < $1.sequenceNumber })
            }
        }
        totalPriceCount()
        self.tblView.reloadData()
    }
    
    func totalPriceCount() {
        totalPrice = sizePrice
        for item in self.ProductListVM.ProdctResponse.value.specifications {
            for list in item.list {
                if list.price != 0 {
                    totalPrice = totalPrice + (list.price * list.quantity)
                }
            }
        }
        totalPrice = totalPrice * self.ProductListVM.ProdctResponse.value.itemQuantity
        addOrderBtn.setTitle("Add to order - \(getDoubleValue(Double(totalPrice)))", for: .normal)
    }
    
    //MARK: - Button Click
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToMinusItem(_ sender: Any) {
        if self.ProductListVM.ProdctResponse.value.itemQuantity > 1 {
            self.ProductListVM.ProdctResponse.value.itemQuantity = self.ProductListVM.ProdctResponse.value.itemQuantity - 1
            itemCountLbl.text = "\(self.ProductListVM.ProdctResponse.value.itemQuantity)"
            totalPriceCount()
            self.tblView.reloadData()
        }
    }
    
    @IBAction func clickToPlusQuantityItem(_ sender: Any) {
        self.ProductListVM.ProdctResponse.value.itemQuantity = self.ProductListVM.ProdctResponse.value.itemQuantity + 1
        itemCountLbl.text = "\(self.ProductListVM.ProdctResponse.value.itemQuantity)"
        totalPriceCount()
        self.tblView.reloadData()
    }
    
    @IBAction func clickToAddToOrder(_ sender: Any) {
        AllData.ProdctResponse.value.itemQuantity = AllData.ProdctResponse.value.itemQuantity + self.ProductListVM.ProdctResponse.value.itemQuantity
        delegate?.updateCustomCartData(totalPrice: totalPrice)
        
        let apartmentData = ProductListVM.ProdctResponse.value.specifications.filter({$0.type == 1})
        AllData.ProdctResponse.value.selectedModifier = apartmentData.first!.list.filter({$0.isDefaultSelected}).first
        AllData.ProdctResponse.value.totalPrice = (totalPrice / AllData.ProdctResponse.value.itemQuantity)
        
        var cartData : cartModel = cartModel()
        cartData.itemQuantity = self.ProductListVM.ProdctResponse.value.itemQuantity
        cartData.selectedModifier = apartmentData.first!.list.filter({$0.isDefaultSelected}).first
        cartData.totalPrice = (totalPrice / self.ProductListVM.ProdctResponse.value.itemQuantity)
        AllData.ProdctResponse.value.cart.append(cartData)
        
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - Tableview delegat and datasource
extension AddPackageVC: UITableViewDelegate, UITableViewDataSource {
    func registerTableViewCell() {
        tblView.register(UINib(nibName: TABLE_VIEW_CELL.HeaderTVC.rawValue, bundle: nil), forCellReuseIdentifier: TABLE_VIEW_CELL.HeaderTVC.rawValue)
        tblView.register(UINib(nibName: TABLE_VIEW_CELL.SelectSizeTVC.rawValue, bundle: nil), forCellReuseIdentifier: TABLE_VIEW_CELL.SelectSizeTVC.rawValue)
        tblView.register(UINib(nibName: TABLE_VIEW_CELL.CleaningTVC.rawValue, bundle: nil), forCellReuseIdentifier: TABLE_VIEW_CELL.CleaningTVC.rawValue)
    }
    
    //numberOfSections
    func numberOfSections(in tableView: UITableView) -> Int {
        return ProductListVM.ProdctResponse.value.specifications.count
    }
    
    // numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProductListVM.ProdctResponse.value.specifications[section].list.count
    }
    
    // estimatedHeightForRowAt
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tblView.dequeueReusableCell(withIdentifier: TABLE_VIEW_CELL.HeaderTVC.rawValue) as! HeaderTVC
        header.titleLbl.text = ProductListVM.ProdctResponse.value.specifications[section].name.first
        
        return header.contentView
    }
    
    // heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if ProductListVM.ProdctResponse.value.specifications[indexPath.section].type == 1 {
            guard let cell = tblView.dequeueReusableCell(withIdentifier: TABLE_VIEW_CELL.SelectSizeTVC.rawValue, for: indexPath) as? SelectSizeTVC else { return UITableViewCell() }
            
            cell.sizeLbl.text = ProductListVM.ProdctResponse.value.specifications[indexPath.section].list[indexPath.row].name.first
            
            if ProductListVM.ProdctResponse.value.specifications[indexPath.section].list[indexPath.row].price == 0 {
                cell.priceLbl.text = ""
            }
            else{
                cell.priceLbl.text = getDoubleValue(Double(ProductListVM.ProdctResponse.value.specifications[indexPath.section].list[indexPath.row].price))
            }
            
            cell.radioBtn.isSelected = ProductListVM.ProdctResponse.value.specifications[indexPath.section].list[indexPath.row].isDefaultSelected
            
            return cell
        }
        else{
            guard let cell = tblView.dequeueReusableCell(withIdentifier: TABLE_VIEW_CELL.CleaningTVC.rawValue, for: indexPath) as? CleaningTVC else { return UITableViewCell() }
            
            cell.serviceLbl.text = ProductListVM.ProdctResponse.value.specifications[indexPath.section].list[indexPath.row].name.first
            if ProductListVM.ProdctResponse.value.specifications[indexPath.section].list[indexPath.row].price == 0 {
                cell.priceLbl.text = ""
            }
            else{
                cell.priceLbl.text = getDoubleValue(Double(ProductListVM.ProdctResponse.value.specifications[indexPath.section].list[indexPath.row].price))
            }
            
            cell.selectBtn.isSelected = ProductListVM.ProdctResponse.value.specifications[indexPath.section].list[indexPath.row].isDefaultSelected
            cell.addQuantityBackView.isHidden = !ProductListVM.ProdctResponse.value.specifications[indexPath.section].list[indexPath.row].isDefaultSelected
            
            cell.countLbl.text = "\(ProductListVM.ProdctResponse.value.specifications[indexPath.section].list[indexPath.row].quantity)"
            
            cell.addQuantityBtn = {(_ aCell: CleaningTVC) -> Void in
                self.ProductListVM.ProdctResponse.value.specifications[indexPath.section].list[indexPath.row].quantity = self.ProductListVM.ProdctResponse.value.specifications[indexPath.section].list[indexPath.row].quantity + 1
                self.totalPrice = 0
                self.totalPriceCount()
                self.tblView.reloadData()
            }
            
            cell.minusQuantityBtn = {(_ aCell: CleaningTVC) -> Void in
                if self.ProductListVM.ProdctResponse.value.specifications[indexPath.section].list[indexPath.row].quantity > 1 {
                    self.ProductListVM.ProdctResponse.value.specifications[indexPath.section].list[indexPath.row].quantity = self.ProductListVM.ProdctResponse.value.specifications[indexPath.section].list[indexPath.row].quantity - 1
                    self.totalPrice = 0
                    self.totalPriceCount()
                    self.tblView.reloadData()
                }
            }
            
            return cell
        }
    }
    
    //didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if ProductListVM.ProdctResponse.value.specifications[indexPath.section].type == 1 {
            let index = ProductListVM.ProdctResponse.value.specifications[indexPath.section].list.firstIndex { (data) -> Bool in
                data.isDefaultSelected
            }
            if index != nil {
                ProductListVM.ProdctResponse.value.specifications[indexPath.section].list[index!].isDefaultSelected = false
                ProductListVM.ProdctResponse.value.specifications[indexPath.section].list[indexPath.row].isDefaultSelected = true
                ProductListVM.ProdctResponse.value.selectedModifier = ProductListVM.ProdctResponse.value.specifications[indexPath.section].list[indexPath.row]
            }
            refreshDataWithSize()
        }
        else {
            let index = ProductListVM.ProdctResponse.value.specifications[indexPath.section].list.firstIndex { (data) -> Bool in
                data.isDefaultSelected
            }
            if index != nil {
                if ProductListVM.ProdctResponse.value.specifications[indexPath.section].list[indexPath.row].id == ProductListVM.ProdctResponse.value.specifications[indexPath.section].list[index!].id {
                    ProductListVM.ProdctResponse.value.specifications[indexPath.section].list[index!].isDefaultSelected = false
                    ProductListVM.ProdctResponse.value.specifications[indexPath.section].list[index!].quantity = 0
                }
            }
            else{
                ProductListVM.ProdctResponse.value.specifications[indexPath.section].list[indexPath.row].isDefaultSelected = true
                ProductListVM.ProdctResponse.value.specifications[indexPath.section].list[indexPath.row].quantity = 1
            }
            totalPrice = 0
            totalPriceCount()
            tblView.reloadData()
        }
    }
}
