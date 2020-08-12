//
//  HomeViewController.swift
//  think2
//
//  Created by Rajwinder Kaur on 2020-08-06.
//  Copyright © 2020 Udhay. All rights reserved.
//

import UIKit
import FirebaseStorage

struct Item {
    var imageName: String
}

class HomeViewController: UIViewController{
    
    var collectioViewFlowLayout: UICollectionViewFlowLayout!
    
    var items: [Item] = [Item(imageName: "dragon"),Item(imageName: "shark"),Item(imageName: "snake"),Item(imageName: "wolf")]
    
    let cellIdentifier = "collectionViewCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    
//    var passText: String?
//    @IBOutlet weak var dragon: UIButton!
//
//    @IBOutlet weak var shark: UIButton!
//
//    @IBOutlet weak var snake: UIButton!
//
//    @IBOutlet weak var wolf: UIButton!
//
    override func viewDidLoad() {
           super.viewDidLoad()
        setupCollectionView()

       }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupCollectionViewItemSize()
    }
    
    private func setupCollectionViewItemSize() {
        if collectioViewFlowLayout == nil {
            let numberOfItemPerRow: CGFloat = 2
            let lineSpacing: CGFloat = 0.02
            let interItemSpacing: CGFloat = 0.02
            
            let width = (collectionView.frame.size.width) - (numberOfItemPerRow) * interItemSpacing / numberOfItemPerRow
            let height = width
            
            collectioViewFlowLayout = UICollectionViewFlowLayout()
            collectioViewFlowLayout.itemSize = CGSize(width: width, height: height)
            collectioViewFlowLayout.sectionInset = UIEdgeInsets.zero
            collectioViewFlowLayout.minimumLineSpacing = lineSpacing
            collectioViewFlowLayout.minimumInteritemSpacing = interItemSpacing
            collectionView.setCollectionViewLayout(collectioViewFlowLayout, animated: true)
        }
    }
//    @IBAction func dragonclicked(_ sender: Any) {
//        let viewController = storyboard?.instantiateViewController(identifier: "ViewController"   ) as? ViewController
//        view.window?.rootViewController = viewController
//                       view.window?.makeKeyAndVisible()
//
//        viewController?.passText = "dragon";
//        present(viewController!, animated: true, completion: nil)
//    }
//    @IBAction func dolphinclicked(_ sender: Any) {
//        let viewController = storyboard?.instantiateViewController(identifier: "ViewController"   ) as? ViewController
//               view.window?.rootViewController = viewController
//                              view.window?.makeKeyAndVisible()
//
//               viewController?.passText = "shark";
//        present(viewController!, animated: true, completion: nil)
//    }
//
//
//    @IBAction func snakeclicked(_ sender: Any) {
//        let viewController = storyboard?.instantiateViewController(identifier: "ViewController"   ) as? ViewController
//               view.window?.rootViewController = viewController
//                              view.window?.makeKeyAndVisible()
//
//               viewController?.passText = "snake";
//        present(viewController!, animated: true, completion: nil)
//    }
//
//    @IBAction func wolfclicked(_ sender: Any) {
//        let viewController = storyboard?.instantiateViewController(identifier: "ViewController"   ) as? ViewController
//               view.window?.rootViewController = viewController
//                              view.window?.makeKeyAndVisible()
//
//               viewController?.passText = "wolf";
//        present(viewController!, animated: true, completion: nil)
//
//    }
    
}
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CollectionViewCell
        
        cell.imageView.image = UIImage(named: items[indexPath.item].imageName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = storyboard?.instantiateViewController(identifier: "ViewController"   ) as? ViewController
                       view.window?.rootViewController = viewController
                                      view.window?.makeKeyAndVisible()
        
                       viewController?.passText = items[indexPath.item].imageName
                present(viewController!, animated: true, completion: nil)
        
        
        
    }
    
    
}



