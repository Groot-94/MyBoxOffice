//
//  MovieInfoViewModelTests.swift
//  MyBoxOfficeTests
//
//  Created by Groot on 2023/02/11.
//

import XCTest
import RxSwift
@testable import MyBoxOffice

final class MovieInfoViewModelTests: XCTestCase {
    var sut: MovieInfoViewModelable!
    var disposeBag: DisposeBag!
    var fetchDatas: MovieInfoModel?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = MovieInfoViewModel(movieCode: "20228555")
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
        sut.output.postMovieInfo
            .subscribe { info in
                movieName = info.movieName
                expectation.fulfill()
            }.disposed(by: disposeBag)
        
        //when
        sut.input.viewDidLoad()
        let result = "더 퍼스트 슬램덩크"
        
        //then
        waitForExpectations(timeout: 3)
        XCTAssertEqual(result, movieName)
    }
}
