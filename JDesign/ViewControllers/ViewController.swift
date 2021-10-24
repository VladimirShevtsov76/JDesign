//
//  ViewController.swift
//  JDesign
//
//  Created by Vladimir Shevtsov on 16.10.2021.
//

import UIKit

class ViewController: UIViewController {
    
    public var imageNumber = 1
    public var imageColor  = 1
    var imagesType = [UIImage]()
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var kitView: UICollectionView!
    @IBOutlet weak var typeView: UICollectionView!
    @IBOutlet weak var colorView: UICollectionView!
        
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setGestures()
        
        typeView.dataSource = self
        typeView.delegate   = self
        kitView.dataSource = self
        kitView.delegate   = self
        
        let fullArray = getSourceStringArray()
        
        for i in 0...22 {
            let image = UIImage(named: "\(i+1)")!
            imagesType.append(image)
        }
        
    }
    
    fileprivate func setGestures() {
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleGestureR(gesture:)))
        let swipeLeftGesture  = UISwipeGestureRecognizer(target: self, action: #selector(handleGestureL(gesture:)))
        let swipeUpGesture    = UISwipeGestureRecognizer(target: self, action: #selector(handleGestureUp(gesture:)))
        let swipeDownGesture  = UISwipeGestureRecognizer(target: self, action: #selector(handleGestureDown(gesture:)))
        swipeRightGesture.direction = UISwipeGestureRecognizer.Direction.right
        swipeLeftGesture.direction  = UISwipeGestureRecognizer.Direction.left
        swipeUpGesture.direction    = UISwipeGestureRecognizer.Direction.up
        swipeDownGesture.direction  = UISwipeGestureRecognizer.Direction.down
        img.addGestureRecognizer(swipeRightGesture)
        img.addGestureRecognizer(swipeLeftGesture)
        img.addGestureRecognizer(swipeUpGesture)
        img.addGestureRecognizer(swipeDownGesture)
    }
    
    // GestureRecognizer
    @objc func handleGestureR(gesture: UISwipeGestureRecognizer) -> Void {
        imageColor = imageColor - 1
        let image = "img_\(imageNumber)_\(imageColor)"
        img.image = UIImage(named: image)
    }
    
    // GestureRecognizer
    @objc func handleGestureL(gesture: UISwipeGestureRecognizer) -> Void {
        imageColor = imageColor + 1
        let image = "img_\(imageNumber)_\(imageColor)"
        img.image = UIImage(named: image)
    }
    
    // GestureRecognizer
    @objc func handleGestureUp(gesture: UISwipeGestureRecognizer) -> Void {
        imageNumber = imageNumber + 1
        let image = "img_\(imageNumber)_\(imageColor)"
        img.image = UIImage(named: image)
    }
    
    // GestureRecognizer
    @objc func handleGestureDown(gesture: UISwipeGestureRecognizer) -> Void {
        imageNumber = imageNumber - 1
        let image = "img_\(imageNumber)_\(imageColor)"
        img.image = UIImage(named: image)
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesType.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellImage", for: indexPath) as! ImageCollectionViewCell
        let image = imagesType[indexPath.item]
        cell.photoView.image = image
        return cell
    }
}
