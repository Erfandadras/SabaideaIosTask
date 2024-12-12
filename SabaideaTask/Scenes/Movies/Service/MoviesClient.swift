//
//  MoviesClient.swift
//  SabaideaTask
//
//  Created by Erfan mac mini on 12/9/24.
//

import Foundation

class MoviesNetworkClient: NetworkClient {
    typealias T = PaginateMoviesResponseModel // associated type
    
    func fetch(setup: NetworkSetup) async throws -> PaginateMoviesResponseModel {
        try await NetworkService.fetch(parser: self, setup: setup)
    }
}

// MARK: - mock CreditCardsNetworkClient
final class MockPropertyAdsNetworkClient: MoviesNetworkClient {
    override func fetch(setup: NetworkSetup) async throws -> PaginateMoviesResponseModel {
        return try await withCheckedThrowingContinuation { continuation in
            let data: PaginateMoviesResponseModel = Bundle.main.decode("Movies")
            delayWithSeconds(5) {
                continuation.resume(returning: data)
            }
        }
    }
}
