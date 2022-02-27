//
//  APIService.swift
//  AppSUI07HW
//
//  Created by Konstantin Zaharev on 17.02.2022.
//

import Foundation
import SwiftUI


class APIService: APIServiceProtocol {
    
    func fetch(url: URL?) async throws -> Data {
        guard let url = url else { throw APIError.badURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { throw APIError.unknown }
        guard (200...299).contains(statusCode) else { throw APIError.badResponse(statusCode: statusCode) }
        
        return data
    }
    
    
    func fetchBreeds(url: URL?) async throws -> [Breed] {
        let data = try await fetch(url: url)
        let decoder = JSONDecoder()
        let breeds = try decoder.decode([Breed].self, from: data)
        return breeds
    }
    
    func fetchBreedImageData(_ breed: Breed) async throws -> Data? {
        guard let urlStr = breed.image?.url else { throw APIError.badURL }
        let data = try await fetch(url: URL(string: urlStr))
        return data
    }
    
}
