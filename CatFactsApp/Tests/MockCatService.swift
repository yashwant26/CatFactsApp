//
//  MockCatService.swift
//  CatFactsAppTests
//
//  Created by Yashwant Kumar on 24/10/24.
//

import Foundation
@testable import CatFactsApp

class MockCatService: CatService {
    var shouldReturnError = false
    var mockCatFact: String = "Mock Cat Fact"
    var mockCatImage: CatImage = CatImage(url: APIConstants.mockCatImageUrl)
    
    override func fetchRandomCatFact(completion: @escaping (Result<String, Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
        } else {
            completion(.success(mockCatFact))
        }
    }
    
    override func fetchRandomCatImage(completion: @escaping (Result<CatImage, Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
        } else {
            completion(.success(mockCatImage))
        }
    }
}
