//
//  UIView+Extension.swift
//  BrianAudible
//
//  Created by Ibrahima Ciss on 9/22/16.
//  Copyright © 2016 Ibrahima Ciss. All rights reserved.
//

import UIKit


extension UIView {
    func addAnchor(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil) {
        self.addAnchor(top: top, left: left, bottom: bottom, right: right, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
    }
    
    func addAnchor(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let top = top { self.topAnchor.constraint(equalTo: top, constant: topConstant).isActive = true }
        if let left = left { self.leftAnchor.constraint(equalTo: left, constant: leftConstant).isActive = true }
        if let bottom = bottom { self.bottomAnchor.constraint(equalTo: bottom, constant: bottomConstant).isActive = true }
        if let right = right { self.rightAnchor.constraint(equalTo: right, constant: -rightConstant).isActive = true }
    }
    
    static func generateButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(UIColor(red:1, green:0.591, blue:0, alpha:1), for: .normal)
        return button
    }
}
