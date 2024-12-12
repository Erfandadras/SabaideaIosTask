//
//  BaseViewModel.swift
//  SabaideaTask
//
//  Created by Erfan mac mini on 12/9/24.
//

import Combine
import SwiftUI

enum ViewModelState: Equatable {
    static func == (lhs: ViewModelState, rhs: ViewModelState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading): return true
        case (.noData, .noData): return true
        case (.success, .success): return true
        case (.failure, .failure): return true
        case (.refresh, .refresh): return true
        default: return false
        }
    }
    case refresh
    case loading
    case noData
    case success
    case failure(error: Error)
}

protocol BaseViewModelProtocol {}

class BaseViewModel: BaseViewModelProtocol, ObservableObject {
    // MARK: - properties
    @Published private(set) var state: ViewModelState?
    var bag: Set<AnyCancellable> = []
    
    func updateState(state: ViewModelState) {
        mainThread {
            withAnimation {
                self.state = state
            }
        }
    }
}

extension BaseViewModel: ErrorDataSourceDelegate {
    func handleError(_ error: Error) {
        self.state = .failure(error: error)
    }
}
