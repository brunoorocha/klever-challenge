//
//  MyListView.swift
//  KleverChallenge
//
//  Created by Bruno Rocha on 08/12/23.
//

import SwiftUI

struct MyListView: View {
    @StateObject var viewModel: MyListViewModel
    
    let gridColumns = [GridItem(.flexible(), spacing: 16), GridItem(.flexible())]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    LazyVGrid(columns: gridColumns, spacing: 32) {
                        ForEach(viewModel.animes) { viewModel in
                            NavigationLink(value: viewModel.model) {
                                AnimeListItemView(viewModel: viewModel)
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                    .padding(16)
                }
            }
            .onAppear {
                viewModel.loadMyList()
            }
            .navigationTitle("My List")
            .navigationDestination(for: Anime.self) { anime in
                AnimeDetailsView(viewModel: AnimeDetailsViewModel(model: anime))
            }
        }
    }
}

struct MyListView_Previews: PreviewProvider {
    static var previews: some View {
        MyListView(viewModel: MyListViewModel())
    }
}

