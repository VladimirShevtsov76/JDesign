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
    }
    
    func subStr(begin: Int, end: Int) -> Substring{
        let subString = self[self.index(self.startIndex, offsetBy: begin)...self.index(self.startIndex, offsetBy: end)]
        return subString
    }
    
}

