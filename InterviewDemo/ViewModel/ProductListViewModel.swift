//
//  ProductListViewModel.swift
//  InterviewDemo
//
//  Created by AkshCom on 18/05/22.
//

import Foundation

protocol CommentListDelegate {
    var ProdctResponse: Box<ProductDataResponse> { get set }
    var success: Box<Bool> { get set }
    func getServiceList()
}

struct ProductListViewModel {
    var ProdctResponse: Box<ProductDataResponse> = Box(ProductDataResponse())
    var success: Box<Bool> = Box(Bool())
    
    func getServiceList() {
        if let filePath = Bundle.main.path(forResource: "item_data", ofType: "json"), let data = NSData(contentsOfFile: filePath) {
            do {
                if let json : [String : Any] = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String : Any] {
                    
                    let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])
                    do {
                        let message = try JSONDecoder().decode(ProductDataResponse.self, from: jsonData!)
                        self.success.value = true
                        self.ProdctResponse.value = message
                    }
                    catch let err {
                        print("Err", err)
                    }
                }
            }
            catch {
                //Handle error
            }
        }
    }
}

