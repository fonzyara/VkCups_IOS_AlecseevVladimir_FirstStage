//
//  SystemImagePicker.swift
//  vkMobileCup_1.AlecseevVladimir
//
//  Created by Vladimir Alecseev on 12.12.2022.
//
import UIKit
class SystemImagePicker{
    enum Images{
        case checkmark
        case plus
    }
    
    static func getImage(ofType: Images) -> UIImage{
        switch ofType {
        case .checkmark:
            guard let image = UIImage(systemName: "checkmark")?.withTintColor(.white).withRenderingMode(.alwaysOriginal) else {return UIImage()}
            return image
        case .plus:
            guard let image = UIImage(systemName: "plus")?.withTintColor(.white).withRenderingMode(.alwaysOriginal) else {return UIImage()}
            return image
        }
    }
}
