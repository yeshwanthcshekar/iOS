//
//  Date+Extension.swift
//  Appetizers
//
//  Created by Yeshwanth Chandrashekar on 2/11/25.
//

import Foundation


extension Date {
    
    var eighteenYearsAgo: Date {
        Calendar.current.date(byAdding: .year, value: -18, to: Date())!
    }
    
    
    var oneHundredTenYearsAgo: Date {
        Calendar.current.date(byAdding: .year, value: -110, to: Date())!
    }
}
