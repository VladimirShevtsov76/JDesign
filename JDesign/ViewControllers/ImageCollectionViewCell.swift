//
//  ImageCollectionViewCell.swift
//  JDesign
//
//  Created by Vladimir Shevtsov on 23.10.2021.
//
import Foundation
import UIKit

//protocol CurrentCellTypeDelegate: AnyObject {
//    
//    func setMainImage(number: Int)
//}

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var colorView: UIImageView!
     
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override var isSelected: Bool {
        didSet {
            if self.reuseIdentifier == "cellImage" {
                backgroundColor = isSelected ? .black : .clear
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: myNoteKey ), object: nil, userInfo: ["setMainImage": self.tag])
                
            } else if self.reuseIdentifier == "cellCostType" {
                backgroundColor = isSelected ? .orange : .clear
                let labels = self.contentView.subviews.compactMap { $0 as? UILabel }
                
                var labelText = ""
                for label in labels {
                    labelText = label.text!
                }
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: myNoteKey ), object: nil, userInfo: ["setCostType": labelText])
                
            } else if self.reuseIdentifier == "cellColor" {
                backgroundColor = isSelected ? .orange : .clear
//                let labels = self.contentView.subviews.compactMap { $0 as? UILabel }
//
//                var labelText = ""
//                for label in labels {
//                    labelText = label.text!
//                }

                NotificationCenter.default.post(name: NSNotification.Name(rawValue: myNoteKey ), object: nil, userInfo: ["setColor": self.tag])
                
            } else if self.reuseIdentifier == "cellGem" {
                backgroundColor = isSelected ? .orange : .clear
                let labels = self.contentView.subviews.compactMap { $0 as? UILabel }
                
                var labelText = ""
                for label in labels {
                    labelText = label.text!
                    label.backgroundColor = .darkGray
            }
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: myNoteKey ), object: nil, userInfo: ["setGem": labelText])
            }
        }
    }
}
