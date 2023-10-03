//
//  UITableView+Ext.swift
//  GHFollowers
//
//  Created by Imalka Muthukumara on 2023-10-03.
//

import UIKit


extension UITableView{
    
    func reloadDataonMainThread(){
        DispatchQueue.main.async { self.reloadData()}
    }
    
    func removeExcessCells(){
        tableFooterView = UIView(frame: .zero)
    }
}
