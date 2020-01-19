//
//  Animations.swift
//  menuAnimation
//
//  Created by Kira on 09.01.2020.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

struct PositionAnumations {
    
    //MARK: - Properties
    
    static var defaultDuration = 0.6
    static var accelerationlDuration = 0.2
    static var offset = 40
    
    //MARK: - Animation types
    
    static func hideSpringAnimation(view: UIView) {
        UIView.animate(
            withDuration: defaultDuration,
            delay: 0,
            options: [.curveEaseOut],
            animations: {
                view.layer.position = CGPoint(
                    x: view.layer.position.x + CGFloat(self.offset),
                    y: view.layer.position.y
                )
            },
            completion: { isComplited in
                guard isComplited else { return }
                
                UIView.animate(
                    withDuration: self.accelerationlDuration,
                    delay: 0,
                    options: [.curveEaseOut],
                    animations: {
                        view.layer.position = CGPoint(
                            x: view.layer.position.x - view.frame.width,
                            y: view.layer.position.y
                        )
                    }
                )
            }
        )
    }
    
    static func showSpringAnumation(view: UIView) {
        UIView.animate(
            withDuration: defaultDuration,
            delay: 0,
            options: [.curveEaseOut],
            animations: {
                view.layer.position = CGPoint(
                    x: view.layer.position.x + view.frame.width,
                    y: view.layer.position.y
                )
            },
            completion: { isComplited in
                guard isComplited else { return }
                
                UIView.animate(
                    withDuration: self.accelerationlDuration,
                    delay: 0,
                    options: [.curveEaseOut],
                    animations: {
                        view.layer.position = CGPoint(
                            x: view.layer.position.x - CGFloat(self.offset),
                            y: view.layer.position.y
                        )
                    }
                )
            }
        )
    }
}


