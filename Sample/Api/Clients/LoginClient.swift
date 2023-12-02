//
//  LoginClient.swift
//  Sample
//
//  Created by Luka Kilasonia on 12/2/23.
//

import Foundation

class LoginClient: NetworkClient {
    func loadAndParse<T>() async throws -> T where T : Decodable {
        let response = AuthResponse(token: "Some Token")
        
        guard let response = response as? T else {
            throw ApiError.parsingError
        }
        return response
    }
}
