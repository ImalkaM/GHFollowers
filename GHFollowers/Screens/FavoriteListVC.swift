//
//  FavoriteListVC.swift
//  GHFollowers
//
//  Created by Imalka Muthukumara on 2023-06-10.
//

import UIKit

class FavoriteListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        
        PersistenceManager.retrieveFavourites { result in
            switch result{
            case .success(let favorites):
                print(favorites)
            case .failure(let error):
                print(error)
            }
        }
    }
}
