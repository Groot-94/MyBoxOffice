//
//  NetworkManagerTests.swift
//  NetworkManagerTests
//
//  Created by Groot on 2023/02/06.
//


import XCTest
import Foundation
import RxSwift
import Alamofire
@testable import MyBoxOffice

final class NetworkManagerTests: XCTestCase {
    private let disposeBag = DisposeBag()
    
    func test_MockSessionNetworkManager_Daily_BoxOffice_request() {
        let expectation = expectation(description: "비동기 처리")
        //given
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses?.insert(contentsOf: [MockURLProtocol.self], at: 0)
        let mockSession = Session(configuration: configuration)
        let networkManager = NetworkManager(session: mockSession)
        var movieNm: String?
        let url = "MockDailyBoxOfficeURL"
        networkManager.requestGetAPI(url: url)
            .decode(type: BoxOfficeDTO.self, decoder: JSONDecoder())
            .subscribe { event in
                guard let data = event.element else { return }
                
                movieNm = data.boxOfficeResult.dailyBoxOfficeList.first?.movieNm
                expectation.fulfill()
            }.disposed(by: disposeBag)
        
        //when
        let result = "경관의 피"
        
        //then
        waitForExpectations(timeout: 3)
        XCTAssertEqual(result, movieNm)
    }
}
