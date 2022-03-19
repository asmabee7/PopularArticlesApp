//
//  PopularArticlesTests.swift
//  PopularArticlesTests
//
//  Created by Asma Bee on 17/03/22.
//

import XCTest
@testable import PopularArticles

class PopularArticlesTests: XCTestCase {
    let networkManager = NetworkManager()
    var apiRequest = ArticlesRequest()

    override class func setUp() {
        
    }
    
    func executeRequest(request: APIRequest, completionHandler: @escaping (RequestState) -> ()) {
        var requestState = RequestState.inProgress
        let promise = expectation(description: "Completion handler invoked")

        networkManager.execute(request: request, responseType: ArticleResponse.self) { result in
            switch result {
            case .success(_):
                requestState = .success
            case .failure(let error):
                requestState = .failed(error)
            }
            promise.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        completionHandler(requestState)

    }
    
    func testNetworkFailure() {
        apiRequest.baseURL = "test"
        executeRequest(request: apiRequest) { state in
            switch state {
            case .success:
                XCTAssertTrue(true,  "Network request is sucsess")
            case .failed(let error):
                XCTAssertNotNil(error, "Network request failed with message - \(error)")
            case .inProgress:
                print("Test failed")
            }
        }
    }
    
    func testNetworkSucess() {
        apiRequest.baseURL = "api.nytimes.com"
        executeRequest(request: apiRequest) { state in
            switch state {
            case .success:
                XCTAssertTrue(true,  "Network request is sucsess")
            case .failed(let error):
                XCTAssertNotNil(error, "Network request failed with message - \(error)")
            case .inProgress:
                print("Test failed")
            }
        }
    }

}
