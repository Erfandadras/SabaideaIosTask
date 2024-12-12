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
        client = .init(client: MOckMoviesNetworkClient())
#else
        client = .init(client: MoviesNetworkClient())
#endif
        self._viewModel = .init(wrappedValue: MovieViewModel(dataSource: .init(network: client)))
    }
    // MARK: - view
    var body: some View {
        NavigationView {
            VStack {
                if case .failure(let error) = viewModel.state {
                    Text(error.localizedDescription)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(12)
                        .background(.red)
                        .padding(.top, 1)
                }
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.uiModels) { item in
                            NavigationLink {
                                VStack {
                                    Text(item.title)
                                }
                                //                            NavigationLazyView(MovieListItemView(data: item))
                            } label: {
                                NavigationLazyView(MovieListItemView(data: item))
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }// scrollView
                .refreshable {
                    viewModel.fetchData()
                }
            }
            .navigationTitle("Home")
            .animation(.linear, value: focused)
        }// navigation view
        .searchable(text: $viewModel.keyword, placement: .navigationBarDrawer, prompt: Text("Search"))
        .focused($focused)
        .background(.white)
        .onTapGesture {
            hideKeyboard()
        }
    }
}
//
#Preview {
    MovieListView()
}
