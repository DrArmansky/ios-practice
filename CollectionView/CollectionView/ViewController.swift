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
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    
    let cellID = "ImageCell"
    let imagesPath =  "/Images"
    var itemsPerRow = 2
    let sectionNumbers = 2
    var imageURLs: [URL]?
    
    var innerInsets: UIEdgeInsets?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        
        collectionView.register(UINib(nibName: cellID, bundle: nil), forCellWithReuseIdentifier: cellID)
        innerInsets = UIEdgeInsets(top: 0, left: 10, bottom: 50, right: 10)
        
        prepareImageURLs()
    }
    
    // Берем адреса картинок список из дериктории
    private func prepareImageURLs() {
        guard let path = Bundle.main.resourcePath else { return }
        
        let imagePath = path + imagesPath
        let url = NSURL(fileURLWithPath: imagePath)
        let fileManager = FileManager.default

        let properties = [URLResourceKey.localizedNameKey,
                          URLResourceKey.creationDateKey, URLResourceKey.localizedTypeDescriptionKey]

        do {
            imageURLs = try fileManager.contentsOfDirectory(at: url as URL, includingPropertiesForKeys: properties, options:FileManager.DirectoryEnumerationOptions.skipsHiddenFiles)

        } catch let error1 as NSError {
            print(error1.description)
        }
    }
    
    private func prepareItemSizeForVertical(collectionView: UICollectionView) -> CGSize {
        let itemSpace = (innerInsets?.left ?? 0 + (innerInsets?.right ?? 0)) * 1.5
        let width: CGFloat = collectionView.frame.width as CGFloat / CGFloat(itemsPerRow) - itemSpace
        return CGSize(width: width, height: width)
    }
    
    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            layout.scrollDirection = .vertical
        } else {
            layout.scrollDirection = .horizontal
        }
    }

    @IBAction func changeNumberOfColums(_ sender: UIStepper) {
        itemsPerRow = Int(sender.value)
        collectionView.reloadData()
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (imageURLs?.count ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let URLs = self.imageURLs, let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
            as? ImageCell else { return UICollectionViewCell() }
        let index = indexPath.item % URLs.count
        let url = URLs[index]
        cell.setup(path: url)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionNumbers
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemSpace = (innerInsets?.left ?? 0 + (innerInsets?.right ?? 0)) * 1.5
        let width: CGFloat = collectionView.frame.width as CGFloat / CGFloat(itemsPerRow) - itemSpace
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        guard let insets = innerInsets else { return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) }
        return insets
    }
}



