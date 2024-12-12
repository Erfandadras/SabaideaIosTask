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
        mainThread {
            self.state = refresh ? .refresh : .loading
        }
        Task {
            do {
                let data = try await dataSource.fetchData()
                mainThread {
                    self.state = data.isEmpty ? .noData : .success
                    self.uiModels = data
                }
            } catch {
                mainThread {
                    self.state = .failure(error: error)
                }
            }
        }
    }
}

extension MovieViewModel{
    private func bindSearchText() {
        $keyword
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.global()) // Debounce for 500ms
            .removeDuplicates() // Avoid triggering fetch for the same value
            .sink { [weak self] keyword in
                guard let self else { return }
                self.dataSource.keyword = keyword.isEmpty ? nil : keyword
                self.fetchData()
            }
            .store(in: &bag)
    }
}
