//
//  MovieDetailView.swift
//  SabaideaTask
//
//  Created by Erfan mac mini on 12/12/24.
//


import SwiftUI

struct MovieDetailView: View {
    // MARK: - properties
    @StateObject var viewModel: MovieDetailViewModel
    var previewItem: MoviesUIModel
    
    // MARK: - init
    init(previewItem: MoviesUIModel) {
        self.previewItem = previewItem
        let client: NetworkClientImpl<MovieDetailNetworkClient>
#if DEBUG
        client = .init(client: MockMovieDetailNetworkClient())
#else
        client = .init(client: MovieDetailNetworkClient())
#endif
        self._viewModel = .init(wrappedValue: MovieDetailViewModel(id: previewItem.id,
                                                                   dataSource: .init(id: previewItem.id, network: client)))
    }
    // MARK: - view
    var body: some View {
        VStack {
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
            GeometryReader { reader in
                VStack {
                    ImageViewBuilder(url: viewModel.uiModel?.imageUrl ?? previewItem.imageUrl)
                        .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fit)
                        .cornerRadius(12)
                        .frame(maxWidth: .infinity)
                        .padding(8)
                    
                    Text(viewModel.uiModel?.detail ?? previewItem.detail)
                        .font(.footnote)
                        .foregroundStyle(.black)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                }
            }
        }
        Spacer()
        .background(.white)
        .navigationTitle(viewModel.uiModel?.title ?? previewItem.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
