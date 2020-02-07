//
//  ViewController.swift
//  Network
//
//  Created by Kira on 26.01.2020.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let cellId = "PostTableViewCell"
    var postList: [PostResponse]?
    let testPostData = PostRequest(id: nil, userId: 3, title: "Test title", body: "Test body text")
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        NetworkManager().getPots { (posts, error) in
            if let error = error {
                print(error)
                return
            }
            
            self.postList = posts
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    
    }
    
    private func setup() {
        
        tableView.dataSource = self
        /*tableView.estimatedRowHeight = 100*/
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
    }

    
    @IBAction func addTestPost() {
        NetworkManager().addPost(body: testPostData) { (post, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let post = post else { return }
            
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Новый пост добавлен", message: "Новому посту присвоен идентификатор \(post.id)", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self.present(alert, animated: true)
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PostTableViewCell
        
        cell.label?.text = postList?[indexPath.row].body
        cell.textView?.text = postList?[indexPath.row].body
        
        return cell
    }
    
}

