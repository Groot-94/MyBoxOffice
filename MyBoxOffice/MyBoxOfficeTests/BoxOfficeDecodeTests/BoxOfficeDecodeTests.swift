//
//  BoxOfficeDecodeTests.swift
//  BoxOfficeDecodeTests
//
//  Created by Groot on 2023/02/06.
//

import XCTest
@testable import MyBoxOffice

final class BoxOfficeDecodeTests: XCTestCase {
    func test_BoxOfficeDTO_Parsing_Dummy() {
        //given
        let data = MockNetworkData(fileName: "Box_Office_Sample").data ?? Data()
        let movieNm = try? JSONDecoder().decode(DailyBoxOfficeDTO.self, from: data)
            .boxOfficeResult
            .dailyBoxOfficeList[0].movieNm
        
        //when
        let result = "경관의 피"
        
        //then
        XCTAssertEqual(result, movieNm)
    }
}
