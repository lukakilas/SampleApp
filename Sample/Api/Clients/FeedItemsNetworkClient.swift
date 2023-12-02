//
//  ApiClient.swift
//  Sample
//
//  Created by Luka Kilasonia on 11/28/23.
//

import Foundation

struct FeedItemsNetworkClient: NetworkClient {
    private let apiKey = "40975410-4a1ddccd9b1879f924a0722ec"
    private let urlString = "https://pixabay.com/api"
    
    func loadAndParse<T: Decodable>() async throws -> T {
        guard let url = constructedURL() else {
            throw ApiError.urlError
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
    
    private func constructedURL() -> URL? {
        if let url = URL(string: urlString) {
            return url.appending(queryItems: [.init(name: "key", value: apiKey)])
        }
        return nil
    }
    
}
