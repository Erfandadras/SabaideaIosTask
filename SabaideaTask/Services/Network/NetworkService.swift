//
//  NetworkService.swift
//  BSLA tech task
//
//  Created by Erfan mac mini on 9/30/24.
//

import Foundation

final class NetworkService: NSObject {}


// MARK: - use mapper with Generic model confirms DataParser
extension NetworkService {
    static func fetch<parser: DataParser>(parser dump: parser, setup: NetworkSetup) async throws -> parser.T {
        var url: URLRequest
        
        do {
            url = try setup.asUrlRequest()
        } catch let error {
            throw CustomError(description: error.localizedDescription)
        }
        
        let (result, response) = try await URLSession.shared.data(for: url)
        if let httpResponse = response as? HTTPURLResponse {
            if setup.range.contains(httpResponse.statusCode) {
                return try dump.mapData(result: result, response: httpResponse)
            } else {
                throw CustomError(description: "No valid status code")
            }
        } else {
            throw CustomError(description: "No Http response")
        }
    }
}
