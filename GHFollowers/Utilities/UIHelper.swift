//
//  UIHelper.swift
//  GHFollowers
//
//  Created by Imalka Muthukumara on 2023-07-02.
//

import UIKit

class UIHelper{
    static func createThreeColumnFlowLayout(in view:UIView) -> UICollectionViewFlowLayout{
        
        //calculate available width for a single object
        let width = view.bounds.width
        let padding:CGFloat = 12
        let minimumItemSpacing:CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
}
