//
//  MovieListView.swift
//  SabaideaTask
//
//  Created by Erfan mac mini on 12/12/24.
//


import SwiftUI

struct MovieListView: View {
    // MARK: - properties
    @FocusState var focused
    @StateObject var viewModel: MovieViewModel
    
    init() {
        let client: NetworkClientImpl<MoviesNetworkClient>
#if DEBUG
        client = .init(client: MockMoviesNetworkClient())
#else
        client = .init(client: MoviesNetworkClient())
#endif
        self._viewModel = .init(wrappedValue: MovieViewModel(dataSource: .init(network: client)))
    }
    // MARK: - view
    var body: some View {
        NavigationStack {
            ScrollViewReader { reader in
                ScrollView {
                    if case .failure(let error) = viewModel.state {
                        Text(error.localizedDescription)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(12)
                            .background(.red)
                            .padding(.top, 1)
                    } else if viewModel.state == .loading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    }
                    LazyVStack {
                        ForEach(viewModel.uiModels) { item in
                            NavigationLink {
                                MovieDetailView(previewItem: item)
                            } label: {
                                MovieListItemView(data: item)
                                    .background(.white)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .id(item.id)
                        }
                    }
                }// scrollView
                .scrollDismissesKeyboard(.automatic)
                .refreshable {
                    viewModel.fetchData(refresh: true)
                }
                .navigationTitle("Home")
                .navigationBarTitleDisplayMode(.automatic)
                .background(.white)
                .animation(.linear, value: focused)
            }
        }// navigation view
        .searchable(text: $viewModel.keyword, placement: .navigationBarDrawer, prompt: Text("Search"))
        .focused($focused)
        .background(.white)
    }
}
