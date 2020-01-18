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
    
    //TODO: add buttons observers
    //TODO: close menu by timing
    
    //MARK: - PROBLEM
    
    /**
        Здесь прям затыка серезная произошла.
        Хотел попробовать сделать все интерактивно, но как обычно уперся в констрейнты.
        Сколько бы не высталял, не отображается список.
        Пробовал в сториборде накидать - все ок, но через код не выходит.
        Ошибок констрейнтов при сборке нет.
     */
    
    private func setupMenuList() {
        
        for menuItemId in MenuList.allCases {
            let menuItem = UIButton()
            menuItem.translatesAutoresizingMaskIntoConstraints = false
            menuItem.setTitle("\(menuItemId)", for: .normal)
            
            menuList.addArrangedSubview(menuItem)
        }
        
        menu.addSubview(menuList)
        
        NSLayoutConstraint.activate([
            menuList.leadingAnchor.constraint(equalTo: menu.leadingAnchor, constant: .zero),
            menuList.centerYAnchor.constraint(equalTo: menu.centerYAnchor),
            menuList.widthAnchor.constraint(equalTo: menu.widthAnchor, multiplier: 1)
        ])
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
    
    //MARK: - Handlers
    
    @objc func hideMenu() {
        PositionAnumations.hideSpringAnimation(view: menu)
    }
    
    @objc func openMenu() {
        PositionAnumations.showSpringAnumation(view: menu)
    }
}
