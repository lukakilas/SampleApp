//
//  NetworkClient.swift
//  Sample
//
//  Created by Luka Kilasonia on 12/2/23.
//

import Foundation

protocol NetworkClient {
    func loadAndParse<T: Decodable>() async throws -> T
}
