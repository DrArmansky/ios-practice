//
//  Menu.swift
//  menuAnimation
//
//  Created by Kira on 09.01.2020.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class Menu {
    
    //MARK: - Properties
    
    private let menuWidthMultiplicator = 0.7
    public static var controllersList:[UIViewController] = []
    let viewController: UIViewController
    var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    var timer: Timer?
    
    //MARK: - View items
    
    private let menu = { () -> UIView in
         let menu = UIView()
         menu.layer.shadowColor = UIColor.black.cgColor
         menu.layer.shadowOpacity = 0.4
         menu.layer.shadowOffset = .zero
         menu.layer.shadowRadius = 10
         menu.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
         
         menu.translatesAutoresizingMaskIntoConstraints = false
         
         return menu
     }()
    
    private let closeMenuButton = { () -> UIButton in
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.red, for: .normal)
        button.setTitle("close", for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        
        return button
    }()
    
    private let openMenuButton = { () -> UIButton in
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Menu", for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.setTitleColor(.gray, for: .disabled)
        
        return button
    }()
    
    private let menuList = { () -> UIStackView in
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 2
        
        return stack
    }()
    
    //MARK: - Init
    
    init(withViewController viewController: UIViewController) {
        self.viewController = viewController
        
        backgroundTask = UIApplication.shared.beginBackgroundTask { [ weak self ] in
            if self?.openMenuButton.isEnabled == false, let openedMenu = self?.menu {
                PositionAnumations.hideSpringAnimation(view: openedMenu)
                self?.openMenuButton.isEnabled = true
            }
            self?.endBackgorundTask()
        }
    }
    
    //MARK: - Setup's
    
    public func setup() {
        setupMenuOpenButton()
        setupMenuPosition()
        setupMenuCloseButton()
        setupMenuList()
    }
    
    private func setupMenuPosition() {
        let menuWidth = viewController.view.frame.width * CGFloat(menuWidthMultiplicator)
        
        viewController.view.addSubview(menu)
        NSLayoutConstraint.activate([
            menu.topAnchor.constraint(equalTo: viewController.view.topAnchor, constant: .zero),
            menu.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor, constant: .zero),
            menu.trailingAnchor.constraint(equalTo: viewController.view.leadingAnchor,constant: .zero),
            menu.widthAnchor.constraint(equalToConstant: menuWidth),
        ])
    }
    
    //TODO: close menu by timing
    
    private func setupMenuList() {
        
        for menuItemId in MenuList.allCases {
            let menuItem = UIButton()
            menuItem.translatesAutoresizingMaskIntoConstraints = false
            menuItem.setTitle(menuItemId.rawValue, for: .normal)
            menuItem.setTitleColor(.black, for: .normal)
            
            menuList.addArrangedSubview(menuItem)
            menuItem.addTarget(self, action: #selector(selectMenuItem), for: .touchUpInside)
        }
        
        menu.addSubview(menuList)
        
        NSLayoutConstraint.activate([
            menuList.leadingAnchor.constraint(equalTo: menu.leadingAnchor, constant: .zero),
            menuList.centerYAnchor.constraint(equalTo: menu.centerYAnchor),
            menuList.widthAnchor.constraint(equalTo: menu.widthAnchor, multiplier: 1)
        ])
    }
    
    @objc func selectMenuItem(_ sender: UIButton) {
        if let menuItemId = sender.titleLabel?.text, let controllerId = MenuList(rawValue: menuItemId) {
            self.changeRootViewController(byId: "\(controllerId)")
        }
    }
    
    private func setupMenuOpenButton() {
        viewController.view.addSubview(openMenuButton)
        
        NSLayoutConstraint.activate([
            openMenuButton.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
            openMenuButton.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor)
        ])
        
        openMenuButton.addTarget(self, action: #selector(openMenu), for: .touchUpInside)
    }
    
    private func setupMenuCloseButton() {
        menu.addSubview(closeMenuButton)
        
        NSLayoutConstraint.activate([
            closeMenuButton.topAnchor.constraint(equalTo: menu.topAnchor, constant: 50),
            closeMenuButton.trailingAnchor.constraint(equalTo: menu.trailingAnchor,constant: -20),
            closeMenuButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 50)
        ])
        
        closeMenuButton.addTarget(self, action: #selector(hideMenu), for: .touchUpInside)
    }
    
    private func changeRootViewController(byId identifier: String) {
        guard let window = UIApplication.shared.windows.first else { return }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let viewController = storyboard.instantiateViewController(withIdentifier: identifier)

        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
    func endBackgorundTask() {
        UIApplication.shared.endBackgroundTask(backgroundTask)
        backgroundTask = .invalid
    }
    
    //MARK: - Handlers
    
    @objc func hideMenu() {
        timer?.invalidate()
        PositionAnumations.hideSpringAnimation(view: menu)
        self.openMenuButton.isEnabled = true
    }
    
    @objc func openMenu(_ sender: UIButton) {
        timer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(hideMenu), userInfo: nil, repeats: false)
        sender.isEnabled = false
        PositionAnumations.showSpringAnumation(view: menu)
    }
}
