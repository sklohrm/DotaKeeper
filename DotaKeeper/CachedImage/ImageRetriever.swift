//
//  ImageRetriever.swift
//  DotaKeeper
//
//  Created by Spencer Lohrmann on 9/26/22.
//

import Foundation

struct ImageRetriever {
    func fetch(_ imageURL: String) async throws -> Data {
        guard let url = URL(string: imageURL) else {
            throw RetrieverError.invalidURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}

private extension ImageRetriever {
    enum RetrieverError: Error {
        case invalidURL
    }
}
