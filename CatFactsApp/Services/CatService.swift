//
//  CatService.swift
//  CatFactsApp
//
//  Created by Yashwant Kumar on 23/10/24.
//

import Foundation
import Alamofire

class CatService {
    func fetchRandomCatFact(completion: @escaping (Result<String, Error>) -> Void) {
        let url = APIConstants.catFactBaseURL
        
        AF.request(url).responseDecodable(of: CatFact.self) { response in
            switch response.result {
            case .success(let catFact):
                if let fact = catFact.data.first {
                    completion(.success(fact))
                } else {
                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No fact found"])))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    func fetchRandomCatImage(completion: @escaping (Result<CatImage, Error>) -> Void) {
        let url = APIConstants.catImageBaseURL
        
        AF.request(url).responseDecodable(of: [CatImage].self) { response in
            switch response.result {
            case .success(let images):
                if let catImage = images.first {
                    completion(.success(catImage))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
