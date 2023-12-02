//
//  FetchItemsUsecase.swift
//  Sample
//
//  Created by Luka Kilasonia on 11/29/23.
//

import Foundation

protocol FetchItemsUsecase {
    func fetchIcons() async throws -> HitsResponse
}
 
class FetchItemsUsecaseImpl: FetchItemsUsecase {
    
    private let gateway: FetchItemsGateway
    
    init(gateway: FetchItemsGateway) {
        self.gateway = gateway
    }
    
    func fetchIcons() async throws -> HitsResponse {
        return try await gateway.fetchItems()
    }
    
}
