//
//  ViewController.swift
//  JDesign
//
//  Created by Vladimir Shevtsov on 16.10.2021.
//
import Foundation
import UIKit

let myNoteKey = "com.vladimirshevtsov.specialNotificationKey"

class ViewController: UIViewController  {
    
    var imageNumber = 1
    var imageColor  = 1
    
    var jdColor = jdColors[0][1]
    var jdType  = jdTypes[0][1]
    var jdGem   = jdGems[0][1]
    
    var imagesType  = [UIImage]()
    var imagesKit   = [UIImage]()
    var imagesColor = [UIImage]()
    
    var filteredJdImages = jdImages
    
    @IBOutlet var       mainView:        UIView!
    @IBOutlet weak var  mainImage:       UIImageView!
    
    @IBOutlet weak var  kitView:         UICollectionView!
    @IBOutlet weak var  typeView:        UICollectionView!
    
    @IBOutlet weak var  selectCostType:  UICollectionView!
    @IBOutlet weak var  selectColor:     UICollectionView!
    @IBOutlet weak var  selectGem:       UICollectionView!
    
    @IBOutlet weak var  currentArticul:  UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setGestures()
        
        typeView.dataSource       = self
        typeView.delegate         = self
        
        kitView.dataSource        = self
        kitView.delegate          = self
        
        selectCostType.dataSource = self
        selectCostType.delegate   = self
        selectColor.dataSource    = self
        selectColor.delegate      = self
        selectGem.dataSource      = self
        selectGem.delegate        = self
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.processingMessage(_:)), name:  NSNotification.Name(rawValue: myNoteKey), object: nil)
        
        //load color select images for buttons
        for index in jdColors.indices {
            let image = UIImage(named: "\(jdColors[index][1].firstLetterUppercased())")!
            imagesColor.append(image)
        }
        
        // Load typeView dataSource
        refreshTypeView()
        
    }
    
    
    //Main refres func of typeView
    func refreshTypeView() {
        filteredJdImages = arrayFiltererd(jdColor: jdColor, jdType: jdType, jdGem: jdGem) as! [[String]]
        imagesType.removeAll()
        
        for index in filteredJdImages.indices {
            let image = UIImage(named: "\(filteredJdImages[index][0])")!
            imagesType.append(image)
        }
        
        typeView.reloadData()
    }
    
    //Processing of all notifications
    @objc func processingMessage(_ notification: Notification) {
        
        if var text = notification.userInfo?["setMainImage"] as? Int {
            if (text-1) >= imagesType.count || text == 0 {
                text = 1
            }
            mainImage.image     = imagesType[text-1]
            currentArticul.text = filteredJdImages[text-1][1]
            
        } else if let text = notification.userInfo?["setCostType"] as? String {
            jdType = text
            refreshTypeView()
            
        } else if let text = notification.userInfo?["setColor"] as? Int {
            jdColor = jdColors[text][1]
            refreshTypeView()
            
        } else if let text = notification.userInfo?["setGem"] as? String {
            jdGem = text
            refreshTypeView()
            
        }
    }
    
    @IBAction func pinchAction(_ sender: UIPinchGestureRecognizer) {
        
        if sender.state == .ended {
            mainImage.transform = CGAffineTransform.identity
            return
        }
        
        mainImage.transform = CGAffineTransform.init(scaleX: sender.scale, y: sender.scale)
    }
    
    //************************************
    fileprivate func setGestures() {
        let swipeRightGesture       = UISwipeGestureRecognizer(target: self, action: #selector(handleGestureR(gesture:)))
        let swipeLeftGesture        = UISwipeGestureRecognizer(target: self, action: #selector(handleGestureL(gesture:)))
        let swipeUpGesture          = UISwipeGestureRecognizer(target: self, action: #selector(handleGestureUp(gesture:)))
        let swipeDownGesture        = UISwipeGestureRecognizer(target: self, action: #selector(handleGestureDown(gesture:)))
        swipeRightGesture.direction = UISwipeGestureRecognizer.Direction.right
        swipeLeftGesture.direction  = UISwipeGestureRecognizer.Direction.left
        swipeUpGesture.direction    = UISwipeGestureRecognizer.Direction.up
        swipeDownGesture.direction  = UISwipeGestureRecognizer.Direction.down
        //        mainImage.addGestureRecognizer(swipeRightGesture)
        //        mainImage.addGestureRecognizer(swipeLeftGesture)
        //        mainImage.addGestureRecognizer(swipeUpGesture)
        //        mainImage.addGestureRecognizer(swipeDownGesture)
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
    
    
}

//typeView extensions
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == typeView {
            return imagesType.count
            
        } else if collectionView == kitView {
            return imagesType.count
            
        } else if collectionView == selectCostType {
            return jdTypes.count
        } else if collectionView == selectColor {
            return jdColors.count
        } else if collectionView == selectGem {
            return jdGems.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == typeView {
            let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "cellImage", for: indexPath) as! ImageCollectionViewCell
            let image = imagesType[indexPath.item]
            cell.tag  = indexPath.item + 1 //name of image file
            cell.photoView.image = image
            return cell
            
        } else if collectionView == kitView {
            let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "cellImage", for: indexPath) as! ImageCollectionViewCell
            let image = imagesType[indexPath.item]
            cell.tag  = indexPath.item + 1 //name of image file
            cell.photoView.image = image
            return cell
            
        } else if collectionView == selectCostType {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellCostType", for: indexPath) as! ImageCollectionViewCell
            if cell.contentView.subviews.count >= 1 {
                cell.contentView.subviews[0].removeFromSuperview()
            }
            let title = UILabel(frame: CGRect(x: 0, y: 0, width: cell.bounds.size.width, height: cell.bounds.size.height))
            title.textColor     = UIColor.white
            title.font          = UIFont.systemFont(ofSize: 14)
            title.text          = jdTypes[indexPath.item][1]
            title.textAlignment = .center
            title.adjustsFontSizeToFitWidth = true
            title.numberOfLines = 2
            title.backgroundColor = .lightGray
            cell.contentView.addSubview(title)
            return cell
            
        } else if collectionView == selectColor {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellColor", for: indexPath) as! ImageCollectionViewCell
            let image = imagesColor[indexPath.item]
            cell.tag  = indexPath.item //number of jdColors
            cell.colorView.image = image

//            if cell.contentView.subviews.count >= 1 {
//                cell.contentView.subviews[0].removeFromSuperview()
//            }
//            let title = UILabel(frame: CGRect(x: 0, y: 0, width: cell.bounds.size.width, height: cell.bounds.size.height))
//            title.textColor     = UIColor.white
//            title.font          = UIFont.systemFont(ofSize: 14)
//            title.text          = jdColors[indexPath.item][1]
//            title.textAlignment = .center
//            title.adjustsFontSizeToFitWidth = true
//            title.numberOfLines = 2
//            title.backgroundColor = .lightGray
//            cell.contentView.addSubview(title)
            return cell
            
        }  else if collectionView == selectGem {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellGem", for: indexPath) as! ImageCollectionViewCell
            if cell.contentView.subviews.count >= 1 {
                cell.contentView.subviews[0].removeFromSuperview()
            }
            let title = UILabel(frame: CGRect(x: 0, y: 0, width: cell.bounds.size.width, height: cell.bounds.size.height))
            title.textColor     = UIColor.white
            title.font          = UIFont.systemFont(ofSize: 14)
            title.text          = jdGems[indexPath.item][1]
            title.textAlignment = .center
            title.adjustsFontSizeToFitWidth = true
            title.numberOfLines = 2
            title.backgroundColor = .lightGray
            cell.contentView.addSubview(title)
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellImage", for: indexPath) as! ImageCollectionViewCell
        return cell
    }
}

