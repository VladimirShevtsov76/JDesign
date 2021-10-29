//
//  Arrays.swift
//  JDesign
//
//  Created by Vladimir Shevtsov on 23.10.2021.
//

public func arrayFiltererd(jdColor: String, jdType: String, jdGem: String) -> Any {
    
    //let text  = "001.00032.02.01.001"
    //let index = "01234567891111111111"
    //            "          0123456789"
    var jdImagesFiltered = jdImages
    
    //Filtered by type
    let typeIndex = jdTypes.filter({$0[1] == jdType})[0][0]
    jdImagesFiltered = jdImagesFiltered.filter({ $0[1][$0[1].index($0[1].startIndex, offsetBy: 10)...$0[1].index($0[1].startIndex, offsetBy: 11)] == typeIndex})
    
    //Filtered by color
    if jdColor != jdColors[0][1] {
        let colorIndex = jdColors.filter({$0[1] == jdColor})[0][0]
        jdImagesFiltered = jdImagesFiltered.filter({ $0[1][$0[1].index($0[1].startIndex, offsetBy: 13)...$0[1].index($0[1].startIndex, offsetBy: 14)] == colorIndex}) }
    
    return jdImagesFiltered
}
