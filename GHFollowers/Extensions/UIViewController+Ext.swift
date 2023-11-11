//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by Imalka Muthukumara on 2023-06-17.
//

import UIKit
import SafariServices

extension UIViewController{
    func presentGFAlert(title:String,message:String,buttonTitle:String){
            let alertVC = GFAlertVC(alertTitle: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            present(alertVC, animated: true)
    }
    
    func presentDefaultGFAlert(){
            let alertVC = GFAlertVC(alertTitle: "Something Went Wrong", message: "We were unable to complete the task at this moment,Please try agaian later.", buttonTitle: "Ok")
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            present(alertVC, animated: true)
    }
    
    func presentSafariVC(with url:URL){
        let saffariVC = SFSafariViewController(url: url)
        saffariVC.preferredControlTintColor = .systemGreen
        present(saffariVC, animated: true)
    }
}
