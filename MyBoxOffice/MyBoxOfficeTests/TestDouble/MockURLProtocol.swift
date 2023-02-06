//
//  MockURLProtocol.swift
//  MyBoxOfficeTests
//
//  Created by Groot on 2023/02/06.
//

import Foundation

final class MockURLProtocol: URLProtocol {
        override class func canInit(with request: URLRequest) -> Bool {
            return true
        }

        override class func canonicalRequest(for request: URLRequest) -> URLRequest {
            return request
        }

        override func startLoading() {
            let data = MockNetworkData(fileName: "Box_Office_Sample").data!
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocol(self, didReceive: HTTPURLResponse(), cacheStoragePolicy: .allowed)
            client?.urlProtocolDidFinishLoading(self)
        }

        override func stopLoading() {}
}
