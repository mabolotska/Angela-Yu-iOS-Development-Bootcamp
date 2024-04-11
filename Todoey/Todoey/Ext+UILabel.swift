//
//  Ext+UILabel.swift
//  Typsy
//
//  Created by Maryna Bolotska on 10/03/24.
//

import UIKit


extension UILabel {
    convenience init(text: String, textColor: UIColor = .gray, aligment: NSTextAlignment = .left) {
        self.init()
        self.text = text
        self.textColor = textColor
        self.adjustsFontSizeToFitWidth = true


    }
}



