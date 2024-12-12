//
//  AppState.swift
//  SabaideaTask
//
//  Created by Erfan mac mini on 12/12/24.
//

import SwiftUI
import Combine

class AppState: ObservableObject {
    private let userManager = UserManager.shared
    @Published var isRTL = false
    var bag = Set<AnyCancellable>()
    
    init() {
        isRTL = userManager.language == "fa"
        $isRTL.dropFirst().sink { [weak self] value in
            guard let self else { return }
            self.userManager.language = value ? "fa" : "en_US"
        }.store(in: &bag)
    }
}
