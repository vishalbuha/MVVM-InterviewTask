//
//  ViewController.swift
//  InterviewDemo
//
//  Created by AkshCom on 17/05/22.
//


import UIKit

class GradientLayer: CAGradientLayer {

    override func layoutSublayers() {
        super.layoutSublayers()
        
        frame = super.bounds
    }
}
