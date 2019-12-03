//
//  NoteView.swift
//  TODOListStackView
//
//  Created by Kira on 24.11.2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class NoteView: UIStackView {
    
    let iconName = "trash"
    let cornerRadius = CGFloat(6)
    let borderWidth = CGFloat(2)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    private func setup() {
        
        distribution = UIStackView.Distribution.fill
        alignment = UIStackView.Alignment.leading
    }
    
    func fillNoteBy(text: String) {
        
        prepareLabel(noteText: text)
        prepareDeleteButton()
    }

    
    private func prepareDeleteButton() {
        
        let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
        let icon = UIImage(systemName: iconName, withConfiguration: boldConfig)
        
        let button = UIButton(frame: .zero)
        button.setImage(icon, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.layer.masksToBounds = true
        button.layer.cornerRadius = cornerRadius
        button.layer.borderWidth = borderWidth
        button.layer.borderColor = UIColor.red.cgColor
        
        button.addTarget(self, action: #selector(deleteNote), for: .touchUpInside)
        
        addArrangedSubview(button)
    }
    
    @objc func deleteNote(sender:UIButton) {
        self.removeFromSuperview()
    }
    
    private func prepareLabel(noteText: String) {
        
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.layer.masksToBounds = true
        label.layer.cornerRadius = cornerRadius
        label.layer.borderWidth = borderWidth
        label.layer.borderColor = UIColor.black.cgColor
        
        label.text = noteText
        
        label.numberOfLines = .zero
        addArrangedSubview(label)
    }
}
