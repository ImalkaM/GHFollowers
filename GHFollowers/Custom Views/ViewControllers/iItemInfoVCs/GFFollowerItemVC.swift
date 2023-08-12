//
//  GHFollowersItemVC.swift
//  GHFollowers
//
//  Created by Imalka Muthukumara on 2023-08-11.
//

import UIKit

class GFFollowerItemVC:GFItemInfoVC{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure(){
        itemInfoViewOne.set(itemInfoType: .following, with: user.following)
        itemInfoViewTwo.set(itemInfoType: .followers, with: user.followers)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
}


