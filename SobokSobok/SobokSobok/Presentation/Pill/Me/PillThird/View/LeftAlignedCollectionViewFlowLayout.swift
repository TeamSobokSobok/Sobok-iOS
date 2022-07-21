//
//  LeftAlignedCollectionViewFlowLayout.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/05/10.
//

// import UIKit
//
// class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//    
//        let attributes = super.layoutAttributesForElements(in: rect)
//        var leftMargin = sectionInset.left
//        var maxY: CGFloat = -1.0
//        
//        attributes?.forEach { layoutAttribute in
//            if layoutAttribute.representedElementCategory == .cell {
//                
//                if layoutAttribute.frame.origin.y >= maxY {
//                    leftMargin = sectionInset.left
//                }
//                layoutAttribute.frame.origin.x = leftMargin
//                
//                leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
//                
//                maxY = max(layoutAttribute.frame.maxY, maxY)
//            }
//        }
//        return attributes
//    }
// }
