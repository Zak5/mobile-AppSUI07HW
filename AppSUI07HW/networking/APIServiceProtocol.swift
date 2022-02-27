//
//  APIServiceProtocol.swift
//  AppSUI07HW
//
//  Created by Konstantin Zaharev on 17.02.2022.
//

import Foundation

protocol APIServiceProtocol {
    func fetchBreeds(url: URL?) async throws -> [Breed]
    func fetchBreedImageData(_ breed: Breed) async throws -> Data?
}
