//
//  String+.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on 26.08.2023.
//

import Foundation

extension String {
    func localized(lang: String?) -> String {
        guard
            let lang,
            let path = Bundle.main.path(forResource: lang, ofType: "lproj"),
            let bundle = Bundle(path: path)
        else {
            return NSLocalizedString(self, comment: "")
        }
        
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
}
