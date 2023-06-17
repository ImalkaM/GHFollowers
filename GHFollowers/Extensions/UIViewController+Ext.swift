//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by Imalka Muthukumara on 2023-06-17.
//

import UIKit

extension UIViewController{
    func presentGFAlertOnMainThread(title:String,message:String,buttonTitle:String){
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(alertTitle: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}