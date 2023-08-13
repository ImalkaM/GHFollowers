//
//  String+Ext.swift
//  GHFollowers
//
//  Created by Imalka Muthukumara on 2023-08-12.
//

import Foundation


extension String{
    func convertTodate() -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current
        
        return dateFormatter.date(from: self)
    }
    
    func convertToDisplayFormat(with format:DateFormat) -> String{
        guard let date = self.convertTodate() else {return "NA"}
        return date.convertToStringFormat(with: format)
    }
}
