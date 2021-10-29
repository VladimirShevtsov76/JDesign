//
//  ViewController.swift
//  JDesign
//
//  Created by Vladimir Shevtsov on 16.10.2021.
//
import Foundation
import UIKit

let myNoteKey = "com.andrewcbancroft.specialNotificationKey"

class ViewController: UIViewController  {
    
    public var imageNumber = 1
    public var imageColor  = 1
    var imagesType = [UIImage]()
    
    @IBOutlet var       mainView:   UIView!
    @IBOutlet weak var  mainImage:  UIImageView!
    
    @IBOutlet weak var  kitView:    UICollectionView!
    @IBOutlet weak var  typeView:   UICollectionView!
    
    @IBOutlet weak var  picker:     UIPickerView!
    
    var pickerData = [jdColors, jdGems]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setGestures()
        
        typeView.dataSource = self
        typeView.delegate   = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.jdSetMainImage(_:)), name:  NSNotification.Name(rawValue: "jdSetMainImage"), object: nil)
        
        // Load typeView dataSource
        for i in 0...22 {
            let image = UIImage(named: "\(i+1)")!
            imagesType.append(image)
        }
        
        // Load pickerDatasource
        self.picker.delegate = self
        self.picker.dataSource = self
                
    }
    
    @objc func jdSetMainImage(_ notification: Notification) {
        if let text = notification.userInfo?["text"] as? Int {
            mainImage.image = imagesType[text-1]            // do something with your text
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
        mainImage.addGestureRecognizer(swipeRightGesture)
        mainImage.addGestureRecognizer(swipeLeftGesture)
        mainImage.addGestureRecognizer(swipeUpGesture)
        mainImage.addGestureRecognizer(swipeDownGesture)
    }
    
    // GestureRecognizer
    @objc func handleGestureR(gesture: UISwipeGestureRecognizer) -> Void {
        imageColor = imageColor - 1
        let image = "img_\(imageNumber)_\(imageColor)"
        mainImage.image = UIImage(named: image)
    }
    
    // GestureRecognizer
    @objc func handleGestureL(gesture: UISwipeGestureRecognizer) -> Void {
        imageColor = imageColor + 1
        let image = "img_\(imageNumber)_\(imageColor)"
        mainImage.image = UIImage(named: image)
    }
    
    // GestureRecognizer
    @objc func handleGestureUp(gesture: UISwipeGestureRecognizer) -> Void {
        imageNumber = imageNumber + 1
        let image = "img_\(imageNumber)_\(imageColor)"
        mainImage.image = UIImage(named: image)
    }
    
    // GestureRecognizer
    @objc func handleGestureDown(gesture: UISwipeGestureRecognizer) -> Void {
        imageNumber = imageNumber - 1
        let image = "img_\(imageNumber)_\(imageColor)"
        mainImage.image = UIImage(named: image)
    }
    
    @IBAction func jdSetTypes(_ sender: Any, type: String) {
        
    }
}

//typeView extensions
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesType.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellImage", for: indexPath) as! ImageCollectionViewCell
        let image = imagesType[indexPath.item]
        cell.tag  = indexPath.item + 1 //name of image file
        cell.photoView.image = image
        return cell
    }
}

//picker extensions
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[component][row][1]
    }
}
