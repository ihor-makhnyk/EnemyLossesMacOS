//
//  ELDateFormatter.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on 22.08.2023.
//

import Foundation

extension String {
    func dateFromString() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: self)
    }
}

extension Date {
    enum DateFormat { case dayMonth, month, yearShort, year }
    func format(_ format: DateFormat) -> String {
        let formatter = DateFormatter()
        var string: String
        
        if let localeId = Localizer.locale.selectedLanguage {
            formatter.locale = Locale(identifier: localeId)
        }
        
        switch format {
        case .dayMonth:
            formatter.dateFormat = formatter.locale.identifier == "en" ? "MMMM d" : "d MMMM"
            string = formatter.string(from: self)
        case .month:
            formatter.dateFormat = "MMMM"
            string = formatter.locale.identifier == "en" ? formatter.string(from: self) : formatter.string(from: self).localized(lang: "uk")
        case .yearShort:
            formatter.dateFormat = "yy"
            string = formatter.string(from: self)
        case .year:
            formatter.dateFormat = "yyyy"
            string = formatter.string(from: self)
        }
        
        return string
    }
    
}

