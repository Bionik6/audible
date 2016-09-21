//
//  ViewController+Handler.swift
//  BrianAudible
//
//  Created by Ibrahima Ciss on 14/09/2016.
//  Copyright © 2016 Ibrahima Ciss. All rights reserved.
//

import UIKit

extension ViewController {
    
    func handleTapGesture() {
        guard let window = UIApplication.shared.keyWindow else { return }
        blackView.backgroundColor = UIColor(white: 0, alpha: 0.8)
        blackView.frame = window.frame
        window.addSubview(blackView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDismiss))
        tapGesture.numberOfTapsRequired = 1
        blackView.addGestureRecognizer(tapGesture)
        
        blackView.alpha = 0
        UIView.animate(withDuration: 0.5) { self.blackView.alpha = 1 }
    }
    
    func handleDismiss() {
        UIView.animate(withDuration: 0.5) { self.blackView.alpha = 0 }
    }
}

