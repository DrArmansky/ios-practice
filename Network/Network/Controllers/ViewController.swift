//
//  ViewController.swift
//  Network
//
//  Created by Kira on 26.01.2020.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    let cellId = "PostTableViewCell"
    let testPostData = PostRequest(id: nil, userId: 3, title: "Test title", body: "Test body text")
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataProvider = PostsDataProvider(persistentContainer: PostsCoreDataStack.shared.persistentContainer, networkManager: NetworkManager())
    
    lazy var fetchedResultsController: NSFetchedResultsController<PostManagedObject> = {
        let fetchRequest = NSFetchRequest<PostManagedObject>(entityName: PostsDataProvider.entityName)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending:true)]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                    managedObjectContext: dataProvider.viewContext,
                                                    sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        
        do {
            try controller.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        super.viewDidLoad()
        dataProvider.fetchPosts { (success, error) in
            if let error = error {
                print(error)
                return
            }
            
            if (!success) {
                print("Fetch is not success, without error.")
            }
        }
    }
    
    private func setup() {
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
    }

    
    @IBAction func addTestPost() {
        dataProvider.sendNewPost(postData: testPostData) { (id, error) in
            if let error = error {
                print(error)
                return
            }
            
            let alert = UIAlertController(title: "Новый пост добавлен", message: "Новому посту присвоен идентификатор \(String(describing: id))", preferredStyle: .alert)
             
             alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
             self.present(alert, animated: true)
        }
    }
}

extension ViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PostTableViewCell
        let post = fetchedResultsController.object(at: indexPath)
        
        cell.label?.text = post.title
        cell.textView?.text = post.body
        
        return cell
    }
    
}

