//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Imalka Muthukumara on 2023-08-12.
//

import Foundation

extension Date{
    
//    func convertToStringFormat(with format:DateFormat) -> String{
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = format.rawValue
//        return dateFormatter.string(from: self)
//    }
    
    func convertToStringFormat() -> String{
        return formatted(.dateTime.month().year())
    }
}
