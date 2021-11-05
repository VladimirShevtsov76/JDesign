//
//  MyExstensions.swift
//  JDesign
//
//  Created by Vladimir Shevtsov on 05.11.2021.
//

//import Foundation

extension String {
    func firstLetterUppercased() -> String {
        guard let first = first, first.isLowercase else { return self }
        return first.uppercased() + dropFirst()
        //return String(first) + dropFirst()
    }
}
