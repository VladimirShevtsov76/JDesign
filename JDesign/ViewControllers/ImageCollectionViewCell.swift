//
//  ImageCollectionViewCell.swift
//  JDesign
//
//  Created by Vladimir Shevtsov on 23.10.2021.
//
import Foundation
import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var kitPhotoView: UIImageView!
    @IBOutlet weak var BasketPhotoView: UIImageView!
    @IBOutlet weak var colorView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setGestures()
    }
    
    override var isHighlighted: Bool {
        didSet {
            if self.reuseIdentifier == "cellImage" {
                //backgroundColor = isSelected ? .black : .clear
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: myNoteKey ), object: nil, userInfo: ["setMainImage": self.tag])
                
            }
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if self.reuseIdentifier == "cellImage" {
                //backgroundColor = isSelected ? .black : .clear
                //NotificationCenter.default.post(name: NSNotification.Name(rawValue: myNoteKey ), object: nil, userInfo: ["setMainImage": self.tag])
                
            }
            else if self.reuseIdentifier == "cellImageKit" {
                    backgroundColor = isSelected ? .black : .clear
                    //NotificationCenter.default.post(name: NSNotification.Name(rawValue: myNoteKey ), object: nil, userInfo: ["setMainImageKit": self.tag])

            }
            else if self.reuseIdentifier == "cellCostType" {
                backgroundColor = isSelected ?  #colorLiteral(red: 1, green: 0.5005856752, blue: 0.6636529565, alpha: 1): .clear
                let labels = self.contentView.subviews.compactMap { $0 as? UILabel }
                
                var labelText = ""
                for label in labels {
                    labelText = label.text!
                }
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: myNoteKey ), object: nil, userInfo: ["setCostType": labelText])
                
            } else if self.reuseIdentifier == "cellColor" {
                backgroundColor = isSelected ? #colorLiteral(red: 1, green: 0.5005856752, blue: 0.6636529565, alpha: 1) : .clear
//                let labels = self.contentView.subviews.compactMap { $0 as? UILabel }
//
//                var labelText = ""
//                for label in labels {
//                    labelText = label.text!
//                }

                NotificationCenter.default.post(name: NSNotification.Name(rawValue: myNoteKey ), object: nil, userInfo: ["setColor": self.tag])
                
            } else if self.reuseIdentifier == "cellGem" {
                backgroundColor = isSelected ? #colorLiteral(red: 1, green: 0.5005856752, blue: 0.6636529565, alpha: 1) : .clear
                let labels = self.contentView.subviews.compactMap { $0 as? UILabel }
                
                var labelText = ""
                for label in labels {
                    labelText = label.text!
                    //label.backgroundColor = .darkGray
            }
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: myNoteKey ), object: nil, userInfo: ["setGem": labelText])
            }
        }
    }
    
    //************************************
    fileprivate func setGestures() {
        if BasketPhotoView == nil {
            return
        }
        
        let swipeUpGesture          = UISwipeGestureRecognizer(target: self, action: #selector(handleGestureUp(gesture:)))
        swipeUpGesture.direction    = UISwipeGestureRecognizer.Direction.up
        BasketPhotoView.addGestureRecognizer(swipeUpGesture)
    }
    
    // GestureRecognizer
    @objc func handleGestureUp(gesture: UISwipeGestureRecognizer) -> Void {
        var labelText = 0
        labelText = BasketPhotoView.superview?.superview?.tag ?? 0
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: myNoteKey ), object: nil, userInfo: ["delBasketGem": labelText])
    }
    
}
