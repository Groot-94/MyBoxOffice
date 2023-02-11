//
//  BoxOfficeListViewModelTests.swift
//  MyBoxOfficeTests
//
//  Created by Groot on 2023/02/07.
//

import XCTest
import RxSwift
@testable import MyBoxOffice

final class BoxOfficeListViewModelTests: XCTestCase {
    var sut: BoxOfficeViewModelable!
    var disposeBag: DisposeBag!
    var fetchDatas: [BoxOfficeModel]?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = BoxOfficeListViewModel()
        disposeBag = DisposeBag()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
        disposeBag = nil
    }
    
    func test_ViewDidLoad() {
        let expectation = expectation(description: "비동기 처리")
        var movieName: String?
        //given
        sut.output.fetchedData
            .skip(1)
            .subscribe { list in
                movieName = list.first?.movieName
                expectation.fulfill()
            }.disposed(by: disposeBag)
        
        //when
        sut.input.viewWillAppear()
        let result = "더 퍼스트 슬램덩크"
        
        //then
        waitForExpectations(timeout: 3)
        XCTAssertEqual(result, movieName)
    }
}
