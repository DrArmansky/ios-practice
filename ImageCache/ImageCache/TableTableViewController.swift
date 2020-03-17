//
//  TableTableViewController.swift
//  ImageCache
//
//  Created by Kira on 17.03.2020.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class TableTableViewController: UITableViewController {
    
    let imageManager = ImageManager()
    let imageCellId = "imageCell"
    var images: [UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageManager.getList { [weak self] images in
            guard let imageList = images else { return }
            self?.images = imageList
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return images.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: imageCellId, for: indexPath)
        cell.imageView?.image = images[indexPath.row]

        return cell
    }
}
