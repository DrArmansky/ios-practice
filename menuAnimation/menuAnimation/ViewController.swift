//
//  ViewController.swift
//  menuAnimation
//
//  Created by Kira on 15.12.2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let menuWidthMultiplicator = 0.7
    private let menuleftInnerConstraint = 40
    
    private let menu = { () -> UIView in
        let menu = UIView()
        menu.layer.shadowColor = UIColor.black.cgColor
        menu.layer.shadowOpacity = 0.4
        menu.layer.shadowOffset = .zero
        menu.layer.shadowRadius = 10
        menu.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        return menu
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        setupMenu()
    }
    
    private func setupMenu() {
        let menuWidth = self.view.frame.width * CGFloat(menuWidthMultiplicator)
        let menuHeight = self.view.frame.height
        
        menu.frame = CGRect(x: -menuWidth, y: .zero, width: menuWidth, height: menuHeight)
        self.view.addSubview(menu)
    }
    
    private func showMenuAnumation() {
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: [.curveEaseOut],
            animations: {
                self.menu.layer.position = CGPoint(
                    x: self.menu.layer.position.x + self.menu.frame.width,
                    y: self.menu.layer.position.y
                )
            },
            completion: { isComplited in
                guard isComplited else { return }
                
                UIView.animate(
                    withDuration: 0.3,
                    delay: 0,
                    options: [.curveEaseOut],
                    animations: {
                        self.menu.layer.position = CGPoint(
                            x: self.menu.layer.position.x - CGFloat(self.menuleftInnerConstraint),
                            y: self.menu.layer.position.y
                        )
                    }
                )
            }
        )
    }
    
    @IBAction func openMenu(_ sender: Any) {
        showMenuAnumation()
    }
}

