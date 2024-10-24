//
//  CatViewModel.swift
//  CatFactsApp
//
//  Created by Yashwant Kumar on 23/10/24.
//

import Foundation

class CatViewModel {
    
    private var service: CatService
    var catFact: ((String) -> Void)?
    var catImageUrl: ((String) -> Void)?
    var onError: ((String) -> Void)?
    
    
    init(Service: CatService = CatService()) {
        self.service = Service
    }
    
    
    func fetchRandomCatFactAndImage() {
        // Fetch the cat fact
        service.fetchRandomCatFact { [weak self] result in
            switch result {
            case .success(let fact):
                print("Successs fetching fact")
                self?.catFact?(fact)
            case .failure(let error):
                print("Error fecting cat fact: \(error.localizedDescription)")
                self?.onError?("Could not load a cat fact. Try again!")
                print("Error fetching fact")
                self?.catFact?("Error fetching cat fact")
                
            }
        }

        // Fetch the cat image
        service.fetchRandomCatImage { [weak self] result in
            switch result {
            case .success(let catImage):
                print("Successs fetching image")
                self?.catImageUrl?(catImage.url)
            case .failure(let error):
                print("Error fetching cat image: \(error.localizedDescription)")
                self?.onError?("Could not load a cat image. Try again!")
                print("Error fetching image")
                self?.catImageUrl?("")
            }
        }
    }
    
}
