//
//  String+Ex.swift
//  Verregular
//
//  Created by Даниил Павленко on 23.04.2023.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
