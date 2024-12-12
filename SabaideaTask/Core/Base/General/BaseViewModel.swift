//
//  BaseViewModel.swift
//  SabaideaTask
//
//  Created by Erfan mac mini on 12/9/24.
//

import Combine

enum ViewModelState: Equatable {
    static func == (lhs: ViewModelState, rhs: ViewModelState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading): return true
        case (.noData, .noData): return true
        case (.success, .success): return true
        case (.failure, .failure): return true
        default: return false
        }
    }
    
    case loading
    case noData
    case success
    case failure(error: Error)
}

protocol BaseViewModelProtocol {
    func fetchData()
}

class BaseViewModel: BaseViewModelProtocol, ObservableObject {
    // MARK: - properties
    @Published var state: ViewModelState = .loading
    var bag: Set<AnyCancellable> = []
    
    // MARK: - logics
    func fetchData() {
        fatalError("function must be override")
    }
}

extension BaseViewModel: ErrorDataSourceDelegate {
    func handleError(_ error: Error) {
        self.state = .failure(error: error)
    }
}
