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
            VStack {
                if viewModel.animes.isEmpty {
                    emptyStateView
                } else {
                    listView
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
    
    private var emptyStateView: some View {
        VStack {
            Text("You don't have animes in your list 🍃")
                .font(.headline)
            Text("To add animes to your list open an anime and tap on \"+ My List\" button.")
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                .padding(.top, 1)
        }
    }
    
    private var listView: some View {
        ScrollView {
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
}

struct MyListView_Previews: PreviewProvider {
    static var previews: some View {
        MyListView(viewModel: MyListViewModel())
    }
}

