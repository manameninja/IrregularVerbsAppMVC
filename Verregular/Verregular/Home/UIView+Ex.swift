//
//  UIView+Ex.swift
//  Verregular
//
//  Created by Даниил Павленко on 26.04.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { view in
            addSubview(view)
        }
    }
}
