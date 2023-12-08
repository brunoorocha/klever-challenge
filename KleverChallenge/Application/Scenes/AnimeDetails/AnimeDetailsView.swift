//
//  AnimeDetailsView.swift
//  KleverChallenge
//
//  Created by Bruno Rocha on 08/12/23.
//

import SwiftUI

struct AnimeDetailsView: View {
    @StateObject var viewModel: AnimeDetailsViewModel
    
    var snackBarOffset: CGFloat {
        viewModel.isShowingSnackBar ? 0 : 160
    }

    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .bottom) {
                
                ScrollView {
                    VStack(alignment: .leading) {
                        
                        ZStack(alignment: .bottom) {
                            if let posterImage = viewModel.posterImage {
                                Image(uiImage: posterImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: proxy.size.width, height: proxy.size.height * 0.9)
                            }
                            
                            VStack(spacing: 0) {
                                Text(viewModel.title)
                                    .font(.system(size: 24, weight: .heavy))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                                    .padding(.bottom, 12)
                                
                                HStack {
                                    Text(viewModel.type)
                                        .font(.caption)
                                        .fontWeight(.heavy)
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.white.opacity(0.8))
                                    
                                    dotSeparator
                                    
                                    Text(viewModel.status)
                                        .font(.caption)
                                        .fontWeight(.heavy)
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.white.opacity(0.8))
                                    
                                    if let episodeCount = viewModel.episodeCount {
                                        dotSeparator
                                        
                                        Text(episodeCount)
                                            .font(.caption)
                                            .fontWeight(.heavy)
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(.white.opacity(0.8))
                                    }
                                }
                                .padding(.bottom, 20)
                                
                                HStack {
                                    Button {
                                        viewModel.didTapOnMyListButton()
                                    } label: {
                                        Label("My List", systemImage: viewModel.isInMyList ? "checkmark" : "plus")
                                            .fontWeight(.bold)
                                            .padding(.horizontal, 20)
                                            .padding(.vertical, 16)
                                            .background(.ultraThinMaterial)
                                            .foregroundColor(.white)
                                            .cornerRadius(8)
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(32)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [.black, .black.opacity(0)]), startPoint: .bottom, endPoint: .top)
                            )
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Synopsis")
                                .font(.headline)
                                .fontWeight(.heavy)
                                .padding(.bottom, 8)
                            
                            Text(viewModel.synopsis)
                                .lineSpacing(8)
                                .multilineTextAlignment(.leading)
                        }
                        .padding(.top, 20)
                        .padding(.horizontal, 16)
                        
                        Spacer(minLength: 80)
                    }
                }
                .ignoresSafeArea()
                
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                    Text(viewModel.snackBarMessage)
                        .fontWeight(.semibold)
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(8)
                .animation(.spring(), value: viewModel.isShowingSnackBar)
                .offset(y: snackBarOffset)
            }
            .padding(.bottom, 16)
        }
        .navigationTitle(viewModel.title)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var dotSeparator: some View {
        Text("•")
            .font(.caption)
            .fontWeight(.heavy)
            .multilineTextAlignment(.center)
            .foregroundColor(.white.opacity(0.8))
    }
}

struct AnimeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TabView {
                NavigationStack {
                    AnimeDetailsView(viewModel: AnimeDetailsViewModel(model: .mock))
                        .preferredColorScheme(.dark)
                }
            }
            NavigationStack {
                AnimeDetailsView(viewModel: AnimeDetailsViewModel(model: .mock))
            }
        }
    }
}
