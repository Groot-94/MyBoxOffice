//
//  String+Extension.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/12.
//

import Foundation

extension String {
    var convertDateFormat: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        
        guard let date = dateFormatter.date(from: self) else { return self }
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.string(from: date)
    }
    
    var convertToDecimal: String {
        guard let number = Int(self) else { return self }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(from: number as NSNumber) ?? self
    }
}
