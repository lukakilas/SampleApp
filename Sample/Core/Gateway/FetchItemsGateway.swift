//
//  FetchItemsGateway.swift
//  Sample
//
//  Created by Luka Kilasonia on 12/1/23.
//

import Foundation

protocol FetchItemsGateway {
    func fetchItems() async throws -> HitsResponse
}

class ApiFetchItemsGatewayImpl: FetchItemsGateway {
    private let client: NetworkClient
    
    init(client: NetworkClient) {
        self.client = client
    }
    
    func fetchItems() async throws -> HitsResponse {
        do {
            let response: HitsResponse = try await client.loadAndParse()
            return response
        } catch {
            throw error
        }
    }
}
