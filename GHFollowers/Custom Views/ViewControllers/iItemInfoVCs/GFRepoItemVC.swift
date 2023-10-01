//
//  GFRepoItemVC.swift
//  GHFollowers
//
//  Created by Imalka Muthukumara on 2023-08-11.
//

import UIKit

protocol GFRepoItemVCDelegate:AnyObject{
    func didTapGitHubProfileButton(for user:User)
}

class GFRepoItemVC:GFItemInfoVC{
    
    weak var delegate:GFRepoItemVCDelegate!
    
    init(user: User,delegate: GFRepoItemVCDelegate!) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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


