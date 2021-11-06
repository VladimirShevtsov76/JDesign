//
//  MyExstensions.swift
//  JDesign
//
//  Created by Vladimir Shevtsov on 05.11.2021.
//

//import Foundation
import UIKit

extension String {
    func firstLetterUppercased() -> String {
        guard let first = first, first.isLowercase else { return self }
        return first.uppercased() + dropFirst()
        //return String(first) + dropFirst()
    }
}

//extension UIImageView {
//    func enableZoom() {
//        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(startZooming(_:)))
//        isUserInteractionEnabled = true
//        addGestureRecognizer(pinchGesture)
//    }
//    
//    @objc
//    private func startZooming(_ sender: UIPinchGestureRecognizer) {
//        let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)
//        guard let scale = scaleResult, scale.a > 1, scale.d > 1 else { return }
//        sender.view?.transform = scale
//        sender.scale = 1
//    }
//}
