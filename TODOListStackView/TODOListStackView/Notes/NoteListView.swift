//
//  NoteListView.swift
//  TODOListStackView
//
//  Created by Kira on 24.11.2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class NoteListView: UIStackView {
    
    override init(frame: CGRect) {
         super.init(frame: frame)
         
         setup()
     }
     
     required init(coder: NSCoder) {
         super.init(coder: coder)
         
         setup()
     }
    
    private func setup() {
        
        distribution = UIStackView.Distribution.fillProportionally
        alignment = UIStackView.Alignment.fill
    }
    
    func addNotes(notes: Notes) {
        
        guard notes.list.count > 0 else { return }
        
        notes.list.forEach { item in
            
            self.addNoteWith(message: item.message)
        }
    }
    
    func addNoteWith(message: String) {
        
        let note = NoteView()
        note.fillNoteBy(text: message)
         
        self.addArrangedSubview(note)
    }
}
