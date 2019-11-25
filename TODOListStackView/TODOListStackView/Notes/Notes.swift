//
//  Notes.swift
//  TODOListStackView
//
//  Created by Kira on 24.11.2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import Foundation

class Notes {

    var list: [NoteModel] = []
    
    init(messages: [String]?) {
        
        if let exampleMessages = messages {
            exampleMessages.forEach { item in
                list.append(NoteModel(message: item))
            }
        } else {
            // получить данные из места хранения записей
        }
    }
    
    deinit {
        // сохранить данные
    }
}
