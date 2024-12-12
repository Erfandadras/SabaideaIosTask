//
//  NetworkClient.swift
//  BSLA tech task
//
//  Created by Erfan mac mini on 9/30/24.
//

import Foundation

enum NetworkClientError: Error {
    case typeError
}

class NetworkClientImpl<Client: NetworkClient> {
    let client: Client
    typealias T = Client.T
    
    init(client: Client) {
        self.client = client
    }
    
    func fetch(setup: NetworkSetup) async throws -> T {
        try await client.fetch(setup: setup)
    }
}


protocol NetworkClient: DataParser {
    func fetch(setup: NetworkSetup) async throws -> T
}

extension NetworkClient {
    var queue : DispatchQueue { DispatchQueue(label: "NetworkClient", qos: .background, attributes: .concurrent, target: .main)}
    
    func mapData(result: Data, response: HTTPURLResponse) throws -> T {
        if response.statusCode == 204 {
            Logger.log(.error, "204 -> no data")
            throw CustomError(description: "204 -> no data")
        }
        
        if response.statusCode == 200 {
            var errorMessage: String = ""
            
            do {
                let result = try JSONDecoder().decode(T.self, from: result)
                return result
            } catch let DecodingError.dataCorrupted(context) {
                errorMessage = "\(context)"

            } catch let DecodingError.keyNotFound(key, context) {
                errorMessage = "Key '\(key)' not found: " + context.debugDescription
                errorMessage += "\n codingPath: \(context.codingPath)"
                
            } catch let DecodingError.valueNotFound(value, context) {
                errorMessage = "value '\(value)' not found: " + context.debugDescription
                errorMessage += "\n codingPath: \(context.codingPath)"

            } catch let DecodingError.typeMismatch(type, context)  {
                errorMessage = "Type '\(type)' mismatch: " + context.debugDescription
                errorMessage += "\n codingPath: \(context.codingPath)"

            } catch {
                errorMessage = error.localizedDescription
                
            }
            throw CustomError(description: errorMessage)
        } else {
            throw CustomError(description: "error code \(response.statusCode)")
        }
    }
}
