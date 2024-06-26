//
//  MockError.swift
//
//
//  Created by Ulaş Sancak on 7.10.2023.
//

import Foundation

enum MockError: LocalizedError {
    case fileNotFound(String)

    var errorDescription: String? {
        switch self {
        case .fileNotFound(let string):
            "File \(string) could not be found."
        }
    }
}
