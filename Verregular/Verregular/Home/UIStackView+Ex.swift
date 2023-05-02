//
//  UIStackView+Ex.swift
//  Verregular
//
//  Created by Даниил Павленко on 26.04.2023.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { view in
            addArrangedSubview(view)
        }
    }
}
