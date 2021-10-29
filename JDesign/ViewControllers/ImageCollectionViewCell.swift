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
    
    //weak var delegate: CurrentCellTypeDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? .black : .clear
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "jdSetMainImage"), object: nil, userInfo: ["text": self.tag])
        }
    }
}
