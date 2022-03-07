//
//  MockURLProtocol.swift
//  BaluchonTests
//
//  Created by Thibault Ballof on 07/03/2022.
//

import Foundation
import XCTest

class MockURLProtocol: URLProtocol {
  
  override class func canInit(with request: URLRequest) -> Bool {
    // To check if this protocol can handle the given request.
    return true
  }

  override class func canonicalRequest(for request: URLRequest) -> URLRequest {
    // Here you return the canonical version of the request but most of the time you pass the orignal one.
    return request
  }

    static var requestHandler: ((URLRequest) -> (HTTPURLResponse, Data?, Error?))?
      
    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
                  XCTFail("Loading handler is not set.")
                  return
              }
              let (response, data, _) = handler(request)
              if let data = data {
                  client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                  client?.urlProtocol(self, didLoad: data)
                  client?.urlProtocolDidFinishLoading(self)
              }
              else {
                  class ProtocolError: Error {}
                  let protocolError = ProtocolError()
                  client?.urlProtocol(self, didFailWithError: protocolError)
              }
    }

  override func stopLoading() {
    // This is called if the request gets canceled or completed.
  }
}
