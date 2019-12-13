//
//  ViewController.swift
//  CollectionView
//
//  Created by Kira on 10.12.2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let cellID = "ImageCell"
    let columnsNumber = 2
    let sectionNumbers = 2
    
    var innerInsets: UIEdgeInsets?
    
    let data = [
         UIColor.green,
         UIColor.yellow,
         UIColor.brown
    ]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setup()
        
        /*let paths = Bundle.main.paths(forResourcesOfType: "jpg", inDirectory: "Assets/Images")
        print()*/
    }
    
    func setup() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: cellID, bundle: nil), forCellWithReuseIdentifier: cellID)
        innerInsets = UIEdgeInsets(top: 0, left: 10, bottom: 50, right: 10)
    }

}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count * 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
            as? ImageCell else { return UICollectionViewCell() }
        let index = indexPath.item % data.count
        let color = data[index]
        cell.setup(color: color)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionNumbers
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemSpace = (innerInsets?.left ?? 0 + (innerInsets?.right ?? 0)) * 1.5
        let width: CGFloat = collectionView.frame.width as CGFloat / CGFloat(columnsNumber) - itemSpace
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        guard let insets = innerInsets else { return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) }
        return insets
    }
}



