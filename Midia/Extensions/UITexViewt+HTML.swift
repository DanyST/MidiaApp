//
//  UITexViewt+HTML.swift
//  Midia
//
//  Created by Luis Herrera Lillo on 22-11-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//

import UIKit

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = self.data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

extension UITextView {
    func htmlText(withString string: String?, usingDefaultAppeareance isDefaultAppeareance: Bool = true) {
        let (currentFont, currentTextColor) = (self.font, self.textColor)
        
        self.attributedText = string?.htmlToAttributedString
 
        if isDefaultAppeareance {
            (self.font, self.textColor) = (currentFont, currentTextColor)
        }
    }
}
