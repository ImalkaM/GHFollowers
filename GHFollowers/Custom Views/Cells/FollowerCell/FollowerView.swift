//
//  FollowerView.swift
//  GHFollowers
//
//  Created by Imalka Muthukumara on 2023-12-16.
//

import SwiftUI

struct FollowerView: View {
    
    var follower:Follower
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: follower.avatarUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Image(ImageResource.avatarPlaceholder)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }.clipShape(.circle)
            Text(follower.login)
                .bold()
                .lineLimit(1)
                .minimumScaleFactor(0.6)
        }
    }
}

#Preview {
    FollowerView(follower: Follower(login: "Imalka", avatarUrl: ""))
}
