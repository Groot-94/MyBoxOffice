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
    
    func test_input_viewWillAppear_bind_output_postMovieInfo() {
        let expectation = expectation(description: "비동기 처리")
        var movieName: String?
        //given
        sut.output.postMovieInfo
            .subscribe { info in
                movieName = info.movieName
                expectation.fulfill()
            }.disposed(by: disposeBag)
        
        //when
        sut.input.viewWillAppear()
        let result = "더 퍼스트 슬램덩크"
        
        //then
        waitForExpectations(timeout: 3)
        XCTAssertEqual(result, movieName)
    }
    
    func test_input_viewWillAppear_bind_output_postMoviePoster() {
        let expectation = expectation(description: "비동기 처리")
        var imageurl: String?
        //given
        sut.output.postMoviePoster
            .subscribe { url in
                imageurl = url
                expectation.fulfill()
            }.disposed(by: disposeBag)
        
        //when
        sut.input.viewWillAppear()
        let result = "http://imgnews.naver.net/image/108/2022/11/28/0003108248_001_20221128094101232.jpg"
        
        //then
        waitForExpectations(timeout: 3)
        XCTAssertEqual(result, imageurl)
    }
}
