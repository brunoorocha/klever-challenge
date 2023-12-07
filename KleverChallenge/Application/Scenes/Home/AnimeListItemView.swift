//
//  AnimeListItemView.swift
//  KleverChallenge
//
//  Created by Bruno Rocha on 07/12/23.
//

import SwiftUI

struct AnimeListItemView: View {
    let viewModel: AnimeListItemViewModel

    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                VStack {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 32)
                        .foregroundColor(.gray)
                        .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.opacity(0.1))
            }
            .cornerRadius(16)

            Text(viewModel.title)
                .bold()
                .lineLimit(2)
                .frame(height: 48, alignment: .top)
                .padding(.top, 8)
                .multilineTextAlignment(.leading)
        }
    }
}

struct AnimeListItemView_Previews: PreviewProvider {
    static var previews: some View {
        AnimeListItemView(viewModel: AnimeListItemViewModel(model: .mock))
    }
}


