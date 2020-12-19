//
//  NSMutableAttributedString+Extensions.swift
//  PhotoAlbums
//
//  Created by Peter Chambers on 18/12/2020.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    
    var boldFontSize: CGFloat { return 18 }
    var normalFontSize: CGFloat { return 14 }
    var boldFont: UIFont { return UIFont(name: "AvenirNext-Bold", size: boldFontSize) ?? UIFont.boldSystemFont(ofSize: boldFontSize) }
    var normalFont: UIFont { return UIFont(name: "AvenirNext-Regular", size: normalFontSize) ?? UIFont.systemFont(ofSize: normalFontSize) }
    
    func bold(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font : boldFont
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func normal(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font : normalFont,
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
}
