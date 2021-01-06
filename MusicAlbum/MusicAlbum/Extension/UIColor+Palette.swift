//
//  UIColor+Palette.swift
//  MusicAlbum
//
//  Created by Pedro Trujillo on 1/6/21.
//

import Foundation
import UIKit

extension UIColor {
    public static var nikeColor: UIColor {
        return UIColor(named: "ibColor") ?? systemRed
    }
    
    public static var artistNameTextColor: UIColor {
        return UIColor(named: "amountTextColor") ?? systemGray
    }
    
    public static var albumNameTextColor: UIColor {
        return UIColor(named: "nameTextColor") ?? systemGray2
    }
    
    public static var cellImageBackgroundColor: UIColor {
        return UIColor(named: "cellImageBackgroundColor") ?? systemBackground
    }
    
}
