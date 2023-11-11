//
//  FollowerCell.swift
//  GHFollowers
//
//  Created by Imalka Muthukumara on 2023-06-21.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    static let reuseID = "FollowerCell"
    
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower:Follower){
        usernameLabel.text = follower.login
        
        Task{
            do{
                let image = await NetworkManager.shared.downloadImage(from: follower.avatarUrl)
                self.avatarImageView.image = image
            }
        }
//        NetworkManager.shared.downloadImage(from: follower.avatarUrl) {[weak self] image in
//            guard let self = self else {return}
//            DispatchQueue.main.async {
//                self.avatarImageView.image = image
//            }
//        }
    }
    
    
    private func configure(){
        addSubviews(avatarImageView,usernameLabel)
        
        let padding:CGFloat = 8
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: widthAnchor),
            
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
         ])
    }
}
