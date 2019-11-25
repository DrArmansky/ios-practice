//
//  NoteView.swift
//  TODOListStackView
//
//  Created by Kira on 24.11.2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class NoteView: UIStackView {
    
    var message: String?

    init(message: String) {
        super.init(frame: .zero)
        
        self.message = message
        setup()
     }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setup() {
        
        
        let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
        let icon = UIImage(systemName: "stop", withConfiguration: boldConfig)
        
        let label = UILabel()
        label.numberOfLines = 0
        label.text = self.message
        
        let button = UIButton()
        button.setImage(icon, for: .normal)
        
        addArrangedSubview(label)
        addArrangedSubview(button)
    }
}
