//
//  BoxOfficeListViewModel.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/07.
//

import Foundation
import RxSwift
import RxRelay

protocol BoxOfficeViewModelable {
    var input: BoxOfficeListViewModelInput { get }
    var output: BoxOfficeListViewModelOutput { get }
}

protocol BoxOfficeListViewModelInput {
    func viewDidLoad(date: Date)
    func refreshList(date: Date)
}

protocol BoxOfficeListViewModelOutput {
    var fetchedData: Observable<[DailyBoxOffice]> { get }
}

struct BoxOfficeListViewModel: BoxOfficeViewModelable {
    var input: BoxOfficeListViewModelInput { self }
    var output: BoxOfficeListViewModelOutput { self}
    private let disposeBag = DisposeBag()
    private var dailyBoxOffices = BehaviorRelay<[DailyBoxOffice]>(value: [])
}

extension BoxOfficeListViewModel: BoxOfficeRepository {
    private func fetchData(_ date: Date) {
        let yesterdayDate = date.yesterday
        let endPoint = BoxOfficeEndPoint.dailyBoxOfficeList(BoxOfficeListParameters(targetDate: yesterdayDate,
                                                                                    itemPerPage: "10"))
        readDailyBoxOffice(endPoint: endPoint)
            .subscribe { list in
                dailyBoxOffices.accept(list)
            }.disposed(by: disposeBag)
    }
}

extension BoxOfficeListViewModel: BoxOfficeListViewModelInput {
    func viewDidLoad(date: Date) {
        fetchData(date)
    }
    
    func refreshList(date: Date) {
        fetchData(date)
    }
}

extension BoxOfficeListViewModel: BoxOfficeListViewModelOutput {
    var fetchedData: RxSwift.Observable<[DailyBoxOffice]> {
        return dailyBoxOffices.asObservable()
    }
}
