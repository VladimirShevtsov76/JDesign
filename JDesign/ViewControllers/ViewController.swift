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
    
    var imageColor   = 1
    
    var jdColor      = jdColors[0][1]
    var jdType       = jdTypes[0][1]
    var jdGem        = jdGems[0][1]
    
    var imagesType   = [UIImage]()
    var imagesKit    = [UIImage]()
    var imagesColor  = [UIImage]()
    var imagesBasket = [UIImage]()
    
    var filteredJdImages                = jdImages
    var filteredJdImagesKit             = jdImages
    var basketJdImages: Array<[String]> = Array()
    
    var currentArtikul     = jdImages[0][1]
    var currentImageNumber = Int(jdImages[0][0]) ?? 0
    
    @IBOutlet weak var  kadrView:        UIView!
    @IBOutlet var       mainView:        UIView!
    @IBOutlet weak var  mainImageView:   UIView!
    
    @IBOutlet weak var  mainImage:       UIImageView!
    @IBOutlet weak var  kadrImage:       UIImageView!
    
    @IBOutlet weak var  kitView:         UICollectionView!
    @IBOutlet weak var  typeView:        UICollectionView!
    @IBOutlet weak var  basketView:      UICollectionView!
    
    @IBOutlet weak var  selectCostType:  UICollectionView!
    @IBOutlet weak var  selectColor:     UICollectionView!
    @IBOutlet weak var  selectGem:       UICollectionView!
    
    @IBOutlet weak var  currentArticulLabel:  UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setGestures()
        
        typeView.dataSource       = self
        typeView.delegate         = self
        
        kitView.dataSource        = self
        kitView.delegate          = self
        
        basketView.dataSource     = self
        basketView.delegate       = self
        
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
        refreshKitView()
        currentArticulLabel.text = currentArtikul
    }
    
    
    //Main refresh func of typeView
    func refreshTypeView() {
        filteredJdImages = arrayFiltererd(jdColor: jdColor, jdType: jdType, jdGem: jdGem)
        imagesType.removeAll()
        
        for index in filteredJdImages.indices {
            let image = UIImage(named: "\(filteredJdImages[index][0])")!
            imagesType.append(image)
        }
        
        typeView.reloadData()
    }
    
    //refresh func of Kit view
    func refreshKitView() {
        filteredJdImagesKit = getCurrentKitArray(crntArtikul: currentArtikul)
        imagesKit.removeAll()
        
        for index in filteredJdImagesKit.indices {
            let image = UIImage(named: "\(filteredJdImagesKit[index][0])")!
            imagesKit.append(image)
        }
        
        kitView.reloadData()
    }
    
    //refresh func of basketView
    func refreshBasketView() {
        imagesBasket.removeAll()
        
        for index in basketJdImages.indices {
            let image = UIImage(named: "\(basketJdImages[index][0])")!
            imagesBasket.append(image)
        }
        
        basketView.reloadData()
    }
    
    //Processing of all notifications
    @objc func processingMessage(_ notification: Notification) {
        
        if let txt = notification.userInfo?["setMainImage"] as? Int {
            var text = txt
            if (text-1) >= imagesType.count || text == 0 {
                text = 1
            }
            
            let duration = 0.1
            UIView.transition(with: kadrView, duration: duration, options: .transitionCrossDissolve, animations: {
                self.kadrImage.image          = self.imagesType[text-1]
                
            }, completion: nil)
            UIView.transition(with: mainImageView, duration: duration, options: .transitionCrossDissolve, animations: {
                self.mainImage.image          = self.imagesType[text-1]
                
            }, completion: nil)
            
            currentArtikul           = filteredJdImages[text-1][1]
            currentImageNumber       = Int(filteredJdImages[text-1][0]) ?? 0
            currentArticulLabel.text = currentArtikul
            refreshKitView()
            
        } else if let txt = notification.userInfo?["setMainImageKit"] as? Int {
            var text = txt
            if (text-1) >= imagesKit.count || text == 0 {
                text = 1
            }
            mainImage.image          = imagesKit[text-1]
            currentArtikul           = filteredJdImagesKit[text-1][1]
            currentImageNumber       = Int(filteredJdImages[text-1][0]) ?? 0
            currentArticulLabel.text = currentArtikul
             
        } else if let text = notification.userInfo?["setCostType"] as? String {
            jdType = text
            refreshTypeView()
            
        } else if let text = notification.userInfo?["setColor"] as? Int {
            jdColor = jdColors[text][1]
            refreshTypeView()
            
        } else if let text = notification.userInfo?["setGem"] as? String {
            jdGem = text
            refreshTypeView()
        
        } else if let text = notification.userInfo?["delBasketGem"] as? Int {
            basketJdImages.remove(at: text)
            refreshBasketView()
            
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
        let swipeDownGesture        = UISwipeGestureRecognizer(target: self, action: #selector(handleGestureDown(gesture:)))
        swipeDownGesture.direction  = UISwipeGestureRecognizer.Direction.down
        mainImageView.addGestureRecognizer(swipeDownGesture)
    }
    
    // GestureRecognizer
    @objc func handleGestureDown(gesture: UISwipeGestureRecognizer) -> Void {
        basketJdImages.append([String(currentImageNumber), currentArtikul])
        refreshBasketView()
    }
        
}

//typeView extensions
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
     
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == typeView {
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: myNoteKey ), object: nil, userInfo: ["setMainImage": indexPath.item + 1])
            
            
        } else if collectionView == kitView {

            NotificationCenter.default.post(name: NSNotification.Name(rawValue: myNoteKey ), object: nil, userInfo: ["setMainImageKit": indexPath.item + 1])
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == typeView {
            return imagesType.count
            
        } else if collectionView == kitView {
            return imagesKit.count
            
        } else if collectionView == basketView {
            return imagesBasket.count
            
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
            let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "cellImageKit", for: indexPath) as! ImageCollectionViewCell
            let image = imagesKit[indexPath.item]
            cell.tag  = indexPath.item + 1 //name of image file
            cell.kitPhotoView.image = image
            return cell
            
        } else if collectionView == basketView {
            let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "cellImageBasket", for: indexPath) as! ImageCollectionViewCell
            let image = imagesBasket[indexPath.item]
            cell.tag  = indexPath.item //number of array in basket
            cell.BasketPhotoView.image = image
            return cell
            
        } else if collectionView == selectCostType {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellCostType", for: indexPath) as! ImageCollectionViewCell
            if cell.contentView.subviews.count >= 1 {
                cell.contentView.subviews[0].removeFromSuperview()
            }
            let title = UILabel(frame: CGRect(x: 2, y: 2, width: cell.bounds.size.width-2, height: cell.bounds.size.height-2))
            title.textColor     = UIColor.black
            title.font          = UIFont.systemFont(ofSize: 14)
            title.text          = jdTypes[indexPath.item][1]
            title.textAlignment = .center
            title.adjustsFontSizeToFitWidth = true
            title.numberOfLines = 2
            //title.backgroundColor = .lightGray
            cell.contentView.addSubview(title)
            return cell
            
        } else if collectionView == selectColor {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellColor", for: indexPath) as! ImageCollectionViewCell
            let image = imagesColor[indexPath.item]
            cell.tag  = indexPath.item //number of jdColors
            cell.colorView.image = image

            return cell
            
        }  else if collectionView == selectGem {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellGem", for: indexPath) as! ImageCollectionViewCell
            if cell.contentView.subviews.count >= 1 {
                cell.contentView.subviews[0].removeFromSuperview()
            }
            let title = UILabel(frame: CGRect(x: 2, y: 2, width: cell.bounds.size.width-2, height: cell.bounds.size.height-2))
            title.textColor     = UIColor.black
            title.font          = UIFont.systemFont(ofSize: 14)
            title.text          = jdGems[indexPath.item][1]
            title.textAlignment = .center
            title.adjustsFontSizeToFitWidth = true
            title.numberOfLines = 2
            //title.backgroundColor = .lightGray
            cell.contentView.addSubview(title)
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellImage", for: indexPath) as! ImageCollectionViewCell
        return cell
    }
}

