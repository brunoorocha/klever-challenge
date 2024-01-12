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
                    LazyVGrid(columns: gridColumns, spacing: 32) {
                        ForEach(viewModel.animes) { viewModel in
                            NavigationLink(value: viewModel.model) {
                                AnimeListItemView(viewModel: viewModel)
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                    .padding(16)

                    if viewModel.isLoading {
                        LoadingView()
                    }
                    
                    if viewModel.isShowingError && !viewModel.isLoading {
                        ErrorView()
                    }
                }
            }
            .navigationTitle(viewModel.season)
            .navigationDestination(for: Anime.self) { anime in
                AnimeDetailsView(viewModel: AnimeDetailsViewModel(model: anime))
            }
        }
        .onAppear {
            Task {
                await viewModel.loadAnimes()
            }
        }
    }

    @ViewBuilder
    private func LoadingView() -> some View {
        HStack() {
            ProgressView()
                .padding(20)
        }
    }
    
    @ViewBuilder
    private func ErrorView() -> some View {
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
        Group {
            HomeView(viewModel: HomeViewModel())
            HomeView(viewModel: HomeViewModel())
                .preferredColorScheme(.dark)
        }
    }
}
