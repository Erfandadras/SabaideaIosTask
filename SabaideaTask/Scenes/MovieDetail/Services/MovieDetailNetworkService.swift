//
//  MovieDetailNetworkService.swift
//  SabaideaTask
//
//  Created by Erfan mac mini on 12/12/24.
//

import Foundation

class MovieDetailNetworkClient: NetworkClient {
    typealias T = MovieDetailResponseModel // associated type
    
    func fetch(setup: NetworkSetup) async throws -> MovieDetailResponseModel {
        try await NetworkService.fetch(parser: self, setup: setup)
    }
}

// MARK: - mock CreditCardsNetworkClient
final class MockMovieDetailNetworkClient: MovieDetailNetworkClient {
    override func fetch(setup: NetworkSetup) async throws -> MovieDetailResponseModel {
        return try await withCheckedThrowingContinuation { continuation in
            do {
                let result: MovieDetailResponseModel = try Bundle.main.decode("MovieDetail")
                delayWithSeconds(0.2) { // simulate request
                    continuation.resume(returning: result)
                }
            } catch {
                continuation.resume(throwing: error)
            }

        }
    }
}
