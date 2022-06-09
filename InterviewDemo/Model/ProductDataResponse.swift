//
//  ProductDataResponse.swift
//  InterviewDemo
//
//  Created by AkshCom on 18/05/22.
//

import Foundation

// MARK: - Welcome
struct ProductDataResponse: Codable {
    let id: String
    let name: [String]
    let price: Int
    let itemTaxes: [Int]
    var specifications: [SpecificationModel]
    
    var selectedModifier: ListModel?
    var itemQuantity: Int
    var totalPrice: Int

    var cart: [cartModel]
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, price
        case itemTaxes = "item_taxes"
        case specifications, selectedModifier, itemQuantity, totalPrice, cart
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        price = try values.decodeIfPresent(Int.self, forKey: .price) ?? DocumentDefaultValues.Empty.int
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? DocumentDefaultValues.Empty.string
        name = try values.decodeIfPresent([String].self, forKey: .name) ?? []
        itemTaxes = try values.decodeIfPresent([Int].self, forKey: .itemTaxes) ?? []
        specifications = try values.decodeIfPresent([SpecificationModel].self, forKey: .specifications) ?? []
        selectedModifier = try values.decodeIfPresent(ListModel.self, forKey: .selectedModifier) ?? nil
        
        itemQuantity = try values.decodeIfPresent(Int.self, forKey: .itemQuantity) ?? 0
        totalPrice = try values.decodeIfPresent(Int.self, forKey: .totalPrice) ?? 0
        
        cart = try values.decodeIfPresent([cartModel].self, forKey: .cart) ?? []
    }
    
    init() {
        price = DocumentDefaultValues.Empty.int
        id = DocumentDefaultValues.Empty.string
        name = []
        itemTaxes = []
        specifications = []
        selectedModifier = nil
        
        itemQuantity = 0
        totalPrice = 0
        
        cart = []
    }
}

// MARK: - Specification
struct SpecificationModel: Codable {
    let id: String
    let name: [String]
    let sequenceNumber, uniqueID: Int
    var list: [ListModel]
    let maxRange, range, type: Int
    let isRequired: Bool
    let isParentAssociate: Bool
    var modifierID: String
    let modifierGroupID: String
    let modifierGroupName: String
    let modifierName: String
    let isAssociated, userCanAddSpecificationQuantity: Bool

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case sequenceNumber = "sequence_number"
        case uniqueID = "unique_id"
        case list
        case maxRange = "max_range"
        case range, type
        case isRequired = "is_required"
        case isParentAssociate
        case modifierID = "modifierId"
        case modifierGroupID = "modifierGroupId"
        case modifierGroupName, modifierName, isAssociated
        case userCanAddSpecificationQuantity = "user_can_add_specification_quantity"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        sequenceNumber = try values.decodeIfPresent(Int.self, forKey: .sequenceNumber) ?? DocumentDefaultValues.Empty.int
        uniqueID = try values.decodeIfPresent(Int.self, forKey: .uniqueID) ?? DocumentDefaultValues.Empty.int
        maxRange = try values.decodeIfPresent(Int.self, forKey: .maxRange) ?? DocumentDefaultValues.Empty.int
        range = try values.decodeIfPresent(Int.self, forKey: .range) ?? DocumentDefaultValues.Empty.int
        type = try values.decodeIfPresent(Int.self, forKey: .type) ?? DocumentDefaultValues.Empty.int
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? DocumentDefaultValues.Empty.string
        name = try values.decodeIfPresent([String].self, forKey: .name) ?? []
        isRequired = try values.decodeIfPresent(Bool.self, forKey: .isRequired) ?? DocumentDefaultValues.Empty.bool
        isParentAssociate = try values.decodeIfPresent(Bool.self, forKey: .isParentAssociate) ?? DocumentDefaultValues.Empty.bool
        isAssociated = try values.decodeIfPresent(Bool.self, forKey: .isAssociated) ?? DocumentDefaultValues.Empty.bool
        userCanAddSpecificationQuantity = try values.decodeIfPresent(Bool.self, forKey: .userCanAddSpecificationQuantity) ?? DocumentDefaultValues.Empty.bool
        list = try values.decodeIfPresent([ListModel].self, forKey: .list) ?? []
        
        modifierID = try values.decodeIfPresent(String.self, forKey: .modifierID) ?? DocumentDefaultValues.Empty.string
        modifierGroupID = try values.decodeIfPresent(String.self, forKey: .modifierGroupID) ?? DocumentDefaultValues.Empty.string
        modifierGroupName = try values.decodeIfPresent(String.self, forKey: .modifierGroupName) ?? DocumentDefaultValues.Empty.string
        modifierName = try values.decodeIfPresent(String.self, forKey: .modifierName) ?? DocumentDefaultValues.Empty.string
    }
    
    init() {
        sequenceNumber = DocumentDefaultValues.Empty.int
        uniqueID = DocumentDefaultValues.Empty.int
        maxRange = DocumentDefaultValues.Empty.int
        range = DocumentDefaultValues.Empty.int
        type = DocumentDefaultValues.Empty.int
        id = DocumentDefaultValues.Empty.string
        name = []
        isRequired = DocumentDefaultValues.Empty.bool
        isParentAssociate = DocumentDefaultValues.Empty.bool
        isAssociated = DocumentDefaultValues.Empty.bool
        userCanAddSpecificationQuantity = DocumentDefaultValues.Empty.bool
        list = []
        
        modifierID = DocumentDefaultValues.Empty.string
        modifierGroupID = DocumentDefaultValues.Empty.string
        modifierGroupName = DocumentDefaultValues.Empty.string
        modifierName = DocumentDefaultValues.Empty.string
    }
}

// MARK: - List
struct ListModel: Codable {
    let id: String
    let name: [String]
    let price, sequenceNumber: Int
    var isDefaultSelected: Bool
    let specificationGroupID: String
    let uniqueID: Int
    
    var quantity: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, price
        case sequenceNumber = "sequence_number"
        case isDefaultSelected = "is_default_selected"
        case specificationGroupID = "specification_group_id"
        case uniqueID = "unique_id"
        case quantity
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        sequenceNumber = try values.decodeIfPresent(Int.self, forKey: .sequenceNumber) ?? DocumentDefaultValues.Empty.int
        uniqueID = try values.decodeIfPresent(Int.self, forKey: .uniqueID) ?? DocumentDefaultValues.Empty.int
        price = try values.decodeIfPresent(Int.self, forKey: .price) ?? DocumentDefaultValues.Empty.int
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? DocumentDefaultValues.Empty.string
        name = try values.decodeIfPresent([String].self, forKey: .name) ?? []
        isDefaultSelected = try values.decodeIfPresent(Bool.self, forKey: .isDefaultSelected) ?? DocumentDefaultValues.Empty.bool
        specificationGroupID = try values.decodeIfPresent(String.self, forKey: .specificationGroupID) ?? DocumentDefaultValues.Empty.string
        quantity = try values.decodeIfPresent(Int.self, forKey: .quantity) ?? DocumentDefaultValues.Empty.int
    }
    
    init() {
        sequenceNumber = DocumentDefaultValues.Empty.int
        uniqueID = DocumentDefaultValues.Empty.int
        price = DocumentDefaultValues.Empty.int
        id = DocumentDefaultValues.Empty.string
        name = []
        isDefaultSelected = DocumentDefaultValues.Empty.bool
        specificationGroupID = DocumentDefaultValues.Empty.string
        quantity = DocumentDefaultValues.Empty.int
    }
}

struct cartModel: Codable {
    var selectedModifier: ListModel?
    var itemQuantity: Int
    var totalPrice: Int
    
    enum CodingKeys: String, CodingKey {
        case selectedModifier, itemQuantity, totalPrice
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        selectedModifier = try values.decodeIfPresent(ListModel.self, forKey: .selectedModifier) ?? nil
        itemQuantity = try values.decodeIfPresent(Int.self, forKey: .itemQuantity) ?? 0
        totalPrice = try values.decodeIfPresent(Int.self, forKey: .totalPrice) ?? 0
    }
    
    init() {
        selectedModifier = nil
        itemQuantity = 0
        totalPrice = 0
    }
}
