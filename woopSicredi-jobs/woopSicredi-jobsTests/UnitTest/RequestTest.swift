//
//  RequestTest.swift
//  woopSicredi-jobsTests
//
//  Created by Ádria Cardoso on 15/08/20.
//  Copyright © 2020 Ádria Cardoso. All rights reserved.
//

import Foundation
import XCTest

@testable import woopSicredi_jobs

class RequestTest: XCTestCase {

    var urlSession: URLSession!
    
    override func setUp() {
        super.setUp()
        
        urlSession = URLSession(configuration: .default)
    }
    
    override func tearDown() {
        super.tearDown()
        
        urlSession = nil
    }
    
    func testEventListRequest() {
        
        let url = URL(string: "http://5b840ba5db24a100142dcd8c.mockapi.io/api/events")
        let promise = expectation(description: "Success")
        
        let dataTask = urlSession.dataTask(with: url!) { data, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                print(statusCode)
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        
        dataTask.resume()
        
        wait(for: [promise], timeout: 5)
    }
}
