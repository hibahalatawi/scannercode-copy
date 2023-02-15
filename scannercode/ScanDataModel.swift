//
//  ScannData.swift
//  scannercode
//
//  Created by Hibah Abdullah Alatawi on 21/07/1444 AH.
//

import Foundation
import UIKit

class ScanData:Identifiable{
    var id = UUID()
    let content:UIImage
    var name : String
    
    
    init(content:UIImage, name: String){
        self.content = content
        self.name = name
    }
}


