//
//  MovieViewModel.swift
//  SabaideaTask
//
//  Created by Erfan mac mini on 12/9/24.
//


import Combine
import UIKit

final class MovieViewModel: BaseViewModel {
    // MARK: - properties
    private let dataSource: MoviesDatasource
    @Published var uiModels: [MoviesUIModel] = []
    @Published var keyword: String = ""
    
    // MARK: - init
    init(dataSource: MoviesDatasource) {
        self.dataSource = dataSource
        super.init()
        fetchData()
        bindSearchText()
    }
    
    // MARK: - deinit
    deinit {
        Logger.log(.info, "Deinit")
    }
    
    // MARK: - override functions
    func fetchData(refresh: Bool = false) {
        self.updateState(state: refresh ? .refresh : .loading)
        Task {
            do {
                let data = try await dataSource.fetchData()
                self.updateState(state: data.isEmpty ? .noData : .success)
                mainThread {
                    self.uiModels = data
                }
            } catch {
                self.updateState(state: .failure(error: error))
            }
        }
    }
}

extension MovieViewModel{
    private func bindSearchText() {
        $keyword
            .debounce(for: .milliseconds(500), scheduler: RunLoop.current) // Debounce for 500ms
            .removeDuplicates() // Avoid triggering fetch for the same value
            .sink { [weak self] keyword in
                print(keyword)
                guard let self else { return }
                self.dataSource.keyword = keyword.isEmpty ? nil : keyword
                self.fetchData()
            }
            .store(in: &bag)
    }
}
