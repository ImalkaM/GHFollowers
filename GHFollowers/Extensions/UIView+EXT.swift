//
//  UIView+EXT.swift
//  GHFollowers
//
//  Created by Imalka Muthukumara on 2023-09-09.
//

import UIKit

extension UIView{
    func pinToEdges(of superview:UIView){
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }
    
    //Variadic Parameter
    func addSubviews(_ views: UIView...){
        for view in views{addSubview(view)}
    }
}
