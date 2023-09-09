//
//  UIView+EXT.swift
//  GHFollowers
//
//  Created by Imalka Muthukumara on 2023-09-09.
//

import UIKit

extension UIView{
    //Variadic Parameter
    func addSubviews(_ views: UIView...){
        for view in views{addSubview(view)}
    }
}
