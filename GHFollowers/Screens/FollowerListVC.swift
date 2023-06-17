//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Imalka Muthukumara on 2023-06-15.
//

import UIKit

class FollowerListVC: UIViewController {
    
    var userName:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        
        NetworkManager.shared.getFollowers(for: userName, page: 1) { result in
            switch result{
            case .success(let followers):
                print(followers)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad stuff happend", message: error.rawValue, buttonTitle: "ok")
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}
