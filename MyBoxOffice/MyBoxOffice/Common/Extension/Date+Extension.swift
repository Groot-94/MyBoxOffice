//
//  Date+Extension.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/06.
//

import Foundation

extension Date {
    var convertBoxOfficeVersion: String {
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "yyyyMMdd"
        
        return myDateFormatter.string(from: self)
    }
    
    var yesterday: String {
        self.addingTimeInterval(-86400).convertBoxOfficeVersion
    }
}
