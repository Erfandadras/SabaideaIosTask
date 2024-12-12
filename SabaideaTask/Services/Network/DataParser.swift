//
//  DataParser.swift
//  BSLA tech task
//
//  Created by Erfan mac mini on 9/30/24.
//

import Foundation

protocol DataParser {
    associatedtype T: Codable
    func mapData(result: Data, response: HTTPURLResponse) throws -> T
}
