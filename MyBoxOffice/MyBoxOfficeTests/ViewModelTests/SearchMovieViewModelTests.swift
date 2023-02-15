//
//  SearchMovieViewModelTests.swift
//  MyBoxOfficeTests
//
//  Created by Groot on 2023/02/15.
//

import XCTest
import RxSwift
@testable import MyBoxOffice

final class SearchMovieViewModelTests: XCTestCase {
    var sut: SearchMovieViewModelable!
    var disposeBag: DisposeBag!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = SearchMovieViewModel()
        disposeBag = DisposeBag()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
        disposeBag = nil
    }
    
    func test_input_searchMovie_bind_output_postMovieInfo() {
        let expectation = expectation(description: "비동기 처리")
        var movieName: String?
        
        //given
        sut.output.postMovieSearchResult
            .subscribe (onNext: { info in
                movieName = info.first?.movieName
                expectation.fulfill()
            }).disposed(by: disposeBag)
        
        //when
        sut.input.searchMovie(name: "더 퍼스트 슬램덩크")
        let result = "더 퍼스트 슬램덩크"
        
        //then
        waitForExpectations(timeout: 3)
        XCTAssertEqual(result, movieName)
    }
    
    func test_input_didTapCell_bind_output_postMovieCodeSearchResult() {
        let expectation = expectation(description: "비동기 처리")
        var movieCode: String?
        
        //given
        sut.output.postMovieCodeSearchResult
            .subscribe { code in
                movieCode = code
                expectation.fulfill()
            }.disposed(by: disposeBag)
        
        //when
        sut.input.didTapCell(model: .init(title: "더 퍼스트 슬램덩크", imageUrl: "", director: "", userRating: ""))
        let result = "20228555"
        
        //then
        waitForExpectations(timeout: 3)
        XCTAssertEqual(result, movieCode)
    }
}
