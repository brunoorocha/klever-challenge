//
//  HomeView.swift
//  KleverChallenge
//
//  Created by Bruno Rocha on 07/12/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    
    let gridColumns = [GridItem(.flexible(), spacing: 16), GridItem(.flexible())]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    LazyVGrid(columns: gridColumns, spacing: 40) {
                        ForEach(viewModel.animes) { anime in
                            AnimeListItemView(viewModel: anime)
                        }
                    }
                    .padding(16)

                    if viewModel.isLoading {
                        loadingView
                    }
                    
                    if viewModel.isShowingError && !viewModel.isLoading {
                        errorView
                    }
                }
            }
            .navigationTitle("Home")
        }
        .onAppear {
            Task {
                await viewModel.loadAnimes()
            }
        }
    }
    
    private var loadingView: some View {
        HStack() {
            ProgressView()
                .padding(20)
        }
    }
    
    private var errorView: some View {
        VStack {
            Text("Something's went wrong 😕")
                .padding(.bottom, 8)
            Button("Try again") {
                Task {
                    await viewModel.loadAnimes()
                }
            }
        }
        .padding([.bottom], 20)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
