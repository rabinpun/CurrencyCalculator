//
//  TextField.swift
//  CurrencyConverter
//
//  Created by rabin on 22/07/2022.
//

import UIKit

final class TextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

    override public func textRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }

    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }

    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
}
