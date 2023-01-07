//
//  CustomLayout.swift
//  vkMobileCup_1.AlecseevVladimir
//
//  Created by Vladimir Alecseev on 13.12.2022.
//

import UIKit
class CustomCollectionViewLayout: UICollectionViewFlowLayout {
    required override init() {
        super.init()
        common()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        common()
    }
    
    private func common() {
        estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        minimumLineSpacing = 8
        minimumInteritemSpacing = 8
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        guard let att = super.layoutAttributesForElements(in: rect) else {return []}
        var x: CGFloat = sectionInset.left
        var y: CGFloat = -1.0
        
        for i in att {
            if i.representedElementCategory != .cell { continue }
            
            if i.frame.origin.y >= y { x = sectionInset.left }
            i.frame.origin.x = x
            x += i.frame.width + minimumInteritemSpacing
            y = i.frame.maxY
        }
        return att
    }
}
