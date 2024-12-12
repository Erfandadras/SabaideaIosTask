//
//  SabaideaTaskApp.swift
//  SabaideaTask
//
//  Created by Erfan mac mini on 12/9/24.
//

import SwiftUI

@main
struct SabaideaTaskApp: App {
    @ObservedObject var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            MovieListView()
                .preferredColorScheme(.light)
                .environmentObject(appState)
                .environment(\.layoutDirection, appState.isRTL ? .rightToLeft : .leftToRight)
        }
    }
}
