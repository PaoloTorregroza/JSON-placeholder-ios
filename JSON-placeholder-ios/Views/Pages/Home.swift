//
//  Home.swift
//  JSON-placeholder-ios
//
//  Created by Paolo on 20/03/22.
//

import SwiftUI

struct Home: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.posts) { post in
                if (!viewModel.onlyFavorites)
                    ||
                    (
                        viewModel.onlyFavorites
                        && UserDefaultManager.getSingleFavorite(id: post.id) != nil
                    )
                {
                    HStack {
                        NavigationLink(post.title, destination: PostOverview(viewModel: PostOverviewViewModel(post: post)))
                        Button {
                            UserDefaultManager.swapFavorite(post: post)
                            // If I had more time I would work on a way to reduce the number of service calls.
                            viewModel.getPosts()
                        } label: {
                            Image(
                                systemName: UserDefaultManager.getSingleFavorite(id: post.id) != nil ? "star.fill" : "star"
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .swipeActions {
                        Button {
                            viewModel.removePost(id: post.id)
                        } label: {
                            Image(systemName: "trash")
                        }.tint(.red)
                    }
                }
            }
            .navigationTitle("Posts")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button() {
                        viewModel.posts = []
                    } label: {
                        Image(systemName: "trash")
                    }
                    
                    Button {
                        viewModel.onlyFavorites = !viewModel.onlyFavorites
                    } label: {
                        Image(systemName: viewModel.onlyFavorites ? "star.fill" : "star")
                    }
                }
            }
            .onAppear() {
                viewModel.getPosts()
            }
            .refreshable {
                viewModel.getPosts()
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(viewModel: HomeViewModel())
    }
}
