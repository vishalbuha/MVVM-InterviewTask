//
//  AppEnum.swift
//  InterviewDemo
//
//  Created by AkshCom on 18/05/22.
//

import Foundation

//MARK: - TABLE_VIEW_CELL
enum TABLE_VIEW_CELL: String {
    case HeaderTVC, SelectSizeTVC, CleaningTVC, CartTVC
}


//MARK:- DocumentDefaultValues
struct DocumentDefaultValues{
    struct Empty{
        static let string =  ""
        static let int =  0
        static let bool = false
        static let double = 0.0
    }
}
