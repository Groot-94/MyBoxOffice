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
        myDateFormatter.dateFormat = "yyyymmdd"
        
        return myDateFormatter.string(from: self)
    }
}
