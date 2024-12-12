//
//  MovieDetailViewModel.swift
//  SabaideaTask
//
//  Created by Erfan mac mini on 12/12/24.
//

import SwiftUI

final class MovieDetailViewModel: BaseViewModel {
    // MARK: - properties
    private let id: Int
    private let dataSource: MovieDetailDataSource
    @Published var uiModel: MovieDetailUIModel?
    
    // MARK: - init
    init(id: Int, dataSource: MovieDetailDataSource) {
        self.id = id
        self.dataSource = dataSource
        super.init()
        fetchData()
    }
    
    func fetchData() {
        mainThread {
            self.state = .loading
        }
        Task {
            do {
                let data = try await dataSource.fetchData()
                mainThread {
                    self.state = .success
                    self.uiModel = data
                }
            } catch {
                mainThread {
                    self.state = .failure(error: error)
                }
            }
        }
    }
}
