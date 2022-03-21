//
//  PostOverview.swift
//  JSON-placeholder-ios
//
//  Created by Paolo on 20/03/22.
//

import SwiftUI

struct PostOverview: View {
    @ObservedObject var viewModel: PostOverviewViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(viewModel.post.body)
                .fontWeight(.light)
                .padding(.horizontal)
            
            Divider()
            
            Text("User")
                .fontWeight(.bold)
                .padding(.horizontal)
            VStack(alignment: .leading) {
                Text(viewModel.user.name)
                Text(viewModel.user.email)
                Text(viewModel.user.phone)
                Text(viewModel.user.website)
            }.padding(.horizontal)
            
            List {
                Section(header: Text("Comments")) {
                    ForEach(viewModel.comments, id: \.id) { el in
                        Text(el.body)
                    }
                }
            }.listStyle(.plain)
            
            Spacer()
        }
        .navigationTitle("Description")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                viewModel.swapFavorite()
            } label: {
                Image(systemName: viewModel.isFavorite ? "star.fill" : "star")
            }
        }
        .onAppear {
            viewModel.getPostComments()
            viewModel.getUserInfo()
        }
    }
}

struct PostOverview_Preview: PreviewProvider {
    static var previews: some View {
        PostOverview(viewModel: PostOverviewViewModel(post: Post.emptyPost))
    }
}
