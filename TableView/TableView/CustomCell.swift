//
//  TableViewCell.swift
//  TableView
//
//  Created by Kira on 06.12.2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    // подготавливаем ячейку для переиспользования
    override func prepareForReuse() {
        super.prepareForReuse()

        accessoryType = .none
    }

}
