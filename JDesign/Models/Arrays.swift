//
//  Arrays.swift
//  JDesign
//
//  Created by Vladimir Shevtsov on 23.10.2021.
//

public func arrayFiltererd(color: String, type: String, gem: String) -> Any {
    
    //let text  = "001.00032.02.01.001"
    //let index = "1234567891111111111"
    //            "         0123456789"
    
    let jdImagesFiltered = jdImages.filter({ $0[1][$0[1].index($0[1].startIndex, offsetBy: 12)...$0[1].index($0[1].startIndex, offsetBy: 15)] == color})
    
    return jdImagesFiltered
}
