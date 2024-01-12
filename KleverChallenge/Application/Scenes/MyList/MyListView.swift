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
                    EmptyStateView()
                } else {
                    ListView()
                }
            }
            .onAppear {
                viewModel.loadMyList()
            }
            .navigationTitle("My List")
            .navigationDestination(for: Anime.self) { anime in
                AnimeDetailsView(viewModel: AnimeDetailsViewModel(model: anime))
            }
            .toolbar {
                ToolbarItem {
                    FilterView()
                }
            }
        }
    }
    
    @ViewBuilder
    private func FilterView() -> some View {
        Menu {
            Section {
                Menu {
                    Picker("Sort results by", selection: $viewModel.selectedSorting) {
                        ForEach(viewModel.sortingOptions) { option in
                            Text(option.rawValue)
                        }
                    }
                } label: {
                    Label("Sort results by", systemImage: "arrow.up.arrow.down")
                }
            }
        } label: {
            Label("", systemImage: "ellipsis.circle")
        }
    }
    
    @ViewBuilder
    private func EmptyStateView() -> some View {
        VStack {
            Text("You don't have animes in your list 🍃")
                .font(.headline)
            Text("To add animes to your list open an anime and tap on \"+ My List\" button.")
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                .padding(.top, 1)
        }
    }
    
    @ViewBuilder
    private func ListView() -> some View {
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

