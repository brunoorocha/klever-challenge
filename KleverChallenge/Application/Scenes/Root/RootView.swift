//
//  RootView.swift
//  KleverChallenge
//
//  Created by Bruno Rocha on 07/12/23.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            HomeView(viewModel: HomeViewModel())
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            MyListView(viewModel: MyListViewModel())
                .tabItem {
                    Label("My List", systemImage: "heart")
                }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
