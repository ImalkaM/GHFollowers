//
//  GHFollowersItemVC.swift
//  GHFollowers
//
//  Created by Imalka Muthukumara on 2023-08-11.
//

import UIKit

protocol GFFollowerItemVCDelegate:AnyObject{
    func didTapGetFollowersButton(for user:User)
}

class GFFollowerItemVC:GFItemInfoVC{
    
    weak var delegate:GFFollowerItemVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    init(user: User,delegate: GFFollowerItemVCDelegate!) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        itemInfoViewOne.set(itemInfoType: .following, with: user.following)
        itemInfoViewTwo.set(itemInfoType: .followers, with: user.followers)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowersButton(for: user)
    }
}


