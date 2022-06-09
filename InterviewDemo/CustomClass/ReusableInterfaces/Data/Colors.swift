//
//  ViewController.swift
//  InterviewDemo
//
//  Created by AkshCom on 17/05/22.
//

import UIKit

var ClearColor : UIColor = UIColor.clear //0
var WhiteColor : UIColor = UIColor.white //1
var BlackColor : UIColor = UIColor.blue //2

var AppColor : UIColor = UIColor.init(named: "App")! //4

enum ColorType : Int32 {
    case Clear = 0
    case White = 1
    case Black = 2
    
    case App = 4
}

extension ColorType {
    var value: UIColor {
        get {
            switch self {
                case .Clear: //0
                    return ClearColor
                case .White: //1
                    return WhiteColor
                case .Black: //2
                    return BlackColor
                
                case .App: //4
                    return AppColor
            }
        }
    }
}

