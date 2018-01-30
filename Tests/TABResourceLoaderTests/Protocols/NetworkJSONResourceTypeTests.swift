//
//  NetworkJSONResourceTypeTests.swift
//  TABResourceLoader
//
//  Created by John Sanderson on 30/01/2018.
//  Copyright © 2018 Luciano Marisi. All rights reserved.
//

import XCTest
@testable import TABResourceLoader

private struct MockNetworkJSONResourceType: NetworkJSONResourceType {

  typealias Model = String
  let url: URL
  let body: Any?

}

class NetworkJSONResourceTypeTests: XCTestCase {

  let url = URL(string: "www.test.com")!
  let expectedBody: [String: Any] = ["testKey": "withATestValue",
                                     "anotherKey": "withAnotherValue"]

  func test_correctDefaultValues() {
    let resource = MockNetworkJSONResourceType(url: url, body: expectedBody)
    let expectedJSONData = try? JSONSerialization.data(withJSONObject: expectedBody, options: JSONSerialization.WritingOptions.prettyPrinted)
    XCTAssertEqual(resource.httpRequestMethod, HTTPMethod.get)
    XCTAssertEqual(resource.httpHeaderFields!, ["Content-Type": "application/json"])
    XCTAssertNil(resource.queryItems)
    XCTAssertEqual(resource.bodyData, expectedJSONData)

    let urlRequest = resource.urlRequest()
    XCTAssertNotNil(urlRequest)
    XCTAssertEqual(urlRequest!.httpBody, expectedJSONData)
  }

}