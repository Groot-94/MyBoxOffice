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
    
    func test_input_viewWillAppear_bind_output_fetchedData() {
        let expectation = expectation(description: "비동기 처리")
        var movieName: String?
        //given
        sut.targetDate.accept(DateComponents(calendar: .current, year: 2023, month: 2, day: 5).date ?? Date())
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
    
    func test_input_viewWillAppear_bind_output_hideLoadingView() {
        let expectation = expectation(description: "비동기 처리")
        var isHideLodingView: Bool?
        
        //given
        sut.output.hideLoadingView
            .subscribe(onNext: { _ in
                isHideLodingView = true
                expectation.fulfill()
            }).disposed(by: disposeBag)
        
        //when
        sut.input.viewWillAppear()
        let result = true
        
        //then
        waitForExpectations(timeout: 3)
        XCTAssertEqual(result, isHideLodingView)
    }
    
    func test_input_hideRefresh_bind_output_refreshList() {
        let expectation = expectation(description: "비동기 처리")
        var isHideRefresh: Bool?
        
        //given
        sut.output.hideRefresh
            .subscribe(onNext: { bool in
                isHideRefresh = bool
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        //when
        sut.input.refreshList()
        let result = false
        
        //then
        waitForExpectations(timeout: 3)
        XCTAssertEqual(result, isHideRefresh)
    }
    
    func test_output_fetchedTargetDate() {
        let expectation = expectation(description: "비동기 처리")
        var targetDate: Date?
        
        //given
        sut.targetDate.accept(DateComponents(calendar: .current, year: 2023, month: 2, day: 5).date ?? Date())
        sut.output.fetchedTargetDate
            .subscribe(onNext: { date in
                targetDate = date
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        //when
        sut.input.refreshList()
        let result = DateComponents(calendar: .current, year: 2023, month: 2, day: 5).date ?? Date()
        
        //then
        waitForExpectations(timeout: 3)
        XCTAssertEqual(result, targetDate)
    }
}
