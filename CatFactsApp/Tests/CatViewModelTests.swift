//
//  CatViewModelTests.swift
//  CatFactsAppTests
//
//  Created by Yashwant Kumar on 24/10/24.
//

import XCTest
@testable import CatFactsApp

class CatViewModelTests: XCTestCase {

    var viewModel: CatViewModel!
    var mockService: MockCatService!
    
    override func setUp() {
           super.setUp()
           mockService = MockCatService()
           viewModel = CatViewModel(Service: mockService)
       }
       
       override func tearDown() {
           viewModel = nil
           mockService = nil
           super.tearDown()
       }
    
    
    func testFetchRandomCatFactAndImage_Success() {
        let factExpectation = XCTestExpectation(description: "Fetches random cat fact successfully")
        let imageExpectation = XCTestExpectation(description: "Fetches random cat image successfully")
        
        viewModel.catFact = { fact in
            XCTAssertEqual(fact, "Mock Cat Fact")
            factExpectation.fulfill()
        }
        
        viewModel.catImageUrl = { url in
            XCTAssertEqual(url, APIConstants.mockCatImageUrl)
            imageExpectation.fulfill()
        }
        
        viewModel.fetchRandomCatFactAndImage()
        
        wait(for: [factExpectation, imageExpectation], timeout: 1.0)
    }
    
    
    func testFetchRandomCatFactAndImage_Failure() {
        
        mockService.shouldReturnError = true
        
        let factExpectation = XCTestExpectation(description: "Handles error fetching cat fact")
        let imageExpectation = XCTestExpectation(description: "Handles error fetching cat image")
        
        // Binding the ViewModel's closures to capture the results
        viewModel.catFact = { fact in
            // We expect the error message for cat fact
            XCTAssertEqual(fact, "Error fetching cat fact")
            factExpectation.fulfill()
        }
        
        viewModel.catImageUrl = { url in
            // We expect an empty URL for cat image in case of failure
            XCTAssertEqual(url, "")
            imageExpectation.fulfill()
        }
        
        viewModel.fetchRandomCatFactAndImage()
        
        wait(for: [factExpectation, imageExpectation], timeout: 3.0)
    }

}
