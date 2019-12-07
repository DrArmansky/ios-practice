//
//  TableViewControllerCustom.swift
//  TableView
//
//  Created by Kira on 05.12.2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class CustomTableViewController: UITableViewController {
    
    private var data = DataProvider.data
    private let cellID = "CustomCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(data)
        setup()
    }
    
    private func setup() {
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
        configurePullToRefresh()
        
        tableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
    }
    
    private func configurePullToRefresh() {
        refreshControl = UIRefreshControl()
        guard refreshControl != nil else { return }
        
        refreshControl?.tintColor = .green
        refreshControl?.attributedTitle = NSAttributedString(string: "Refreshing...")
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = self.refreshControl
        } else {
            // развернул с ! так как ни на какие манипуляции с guard и if компилятор не реагировал
            tableView.addSubview(self.refreshControl!)
        }
        
        refreshControl?.addTarget(self, action: #selector(shuffle), for: .valueChanged)
    }
    
    @objc func shuffle() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.data = self.data.shuffled()
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        return
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let isChacked = data[indexPath.row].isChecked
        let title = isChacked ? "Uncheck" : "Check"
        let action = UIContextualAction(style: .normal, title: title) { (_, _, completion) in
            self.data[indexPath.row].isChecked = !self.data[indexPath.row].isChecked
            self.tableView.reloadRows(at: [ indexPath ], with: .automatic)
            completion(true)
        }
        action.backgroundColor = isChacked ? .orange : .blue

        return UISwipeActionsConfiguration(actions: [ action ])
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CustomCell
        
        cell.label?.text = data[indexPath.row].text
        if data[indexPath.row].isChecked {
            cell.accessoryType = .checkmark
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete else { return }
        
        tableView.beginUpdates()
        tableView.deleteRows(at: [ indexPath ], with: .automatic)
        data.remove(at: indexPath.row)
        tableView.endUpdates()
    }
    
}
