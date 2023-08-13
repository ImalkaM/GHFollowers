//
//  GFRepoItemVC.swift
//  GHFollowers
//
//  Created by Imalka Muthukumara on 2023-08-11.
//

import UIKit

class GFRepoItemVC:GFItemInfoVC{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure(){
        itemInfoViewOne.set(itemInfoType: .repos, with: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, with: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGitHubProfileButton(for: user)
    }
}


