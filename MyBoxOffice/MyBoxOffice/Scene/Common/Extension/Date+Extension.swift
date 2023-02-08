//
//  Date+Extension.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/06.
//

import Foundation

extension Date {
    var convertBoxOfficeVersion: String {
        return self.toString(form: "yyyyMMdd")
    }
    
    var yesterday: String {
        self.addingTimeInterval(-86400).convertBoxOfficeVersion
    }
    
    func toString(form: String) -> String {
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = form
        
        return myDateFormatter.string(from: self)
    }
}
