//
//  Bundle+decoder.swift
//  SabaideaTask
//
//  Created by Erfan mac mini on 12/11/24.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ file: String, withExtension: String = "json") -> T {
        guard let url = self.url(forResource: file, withExtension: withExtension) else {
            fatalError("Failed to locate \(file + withExtension) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()

        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }

        return loaded
    }
}
