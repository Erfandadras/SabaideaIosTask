//
//  Bundle+decoder.swift
//  SabaideaTask
//
//  Created by Erfan mac mini on 12/11/24.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ file: String, withExtension: String = "json") throws -> T {
        guard let url = self.url(forResource: file, withExtension: withExtension) else {
            throw CustomError(description: "Failed to locate \(file + withExtension) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            throw CustomError(description: "Failed to load \(file) from bundle.")
        }

        return try data.decode()
    }
}
