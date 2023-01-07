//
//  AppPalette.swift
//  vkMobileCup_1.AlecseevVladimir
//
//  Created by Vladimir Alecseev on 13.12.2022.
//

import UIKit
extension UIColor{
    enum appPalette{
        case laterbutton
        case infoText
        
        var color: UIColor {
            switch self {
            case .laterbutton:
                return UIColor(red: 1, green: 1, blue: 1, alpha: 0.12)
            case .infoText:
                return UIColor(red: 1, green: 1, blue: 1, alpha: 0.47)
            }
            
        }
    }
    
}
