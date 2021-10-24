//
//  Arrays.swift
//  JDesign
//
//  Created by Vladimir Shevtsov on 23.10.2021.
//

func getSourceStringArray() -> Any {
    
    var stringArray: [Any] = [["1","001","00001","01","01","001"]]
    stringArray.removeAll()
    
    for i in 0...jImages.count-1 {
        
        stringArray.append(["1","001","00001","01","01","001"])
    }
    
    return stringArray
}
