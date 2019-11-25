//
//  NoteListView.swift
//  TODOListStackView
//
//  Created by Kira on 24.11.2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class NoteListView: UIStackView {
    
    func addNotes(notes: Notes) {
        
        guard notes.list.count > 0 else { return }
        
        notes.list.forEach { item in
            
            let label = UILabel()
            label.text = item.message
            
            self.addArrangedSubview(label)
        }
        
        self.addArrangedSubview(NoteView(message: "TEST FILEDS LET SEE TEST FILEDS LET SEE TEST FILEDS LET SEE TEST FILEDS LET SEE TEST FILEDS LET SEE TEST FILEDS LET SEE TEST FILEDS LET SEE"))
        
        for _ in 0...100 {
            let label = UILabel()
            label.numberOfLines = 0
            label.text = "TEST FILEDS LET SEE TEST FILEDS LET SEE TEST FILEDS LET SEE TEST FILEDS LET SEE TEST FILEDS LET SEE TEST FILEDS LET SEE TEST FILEDS LET SEE"
           
           self.addArrangedSubview(label)
        }
    }
}
