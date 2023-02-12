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
    var targetDate: Date { get }
}

protocol BoxOfficeListViewModelInput {
    func viewWillAppear()
    func refreshList()
}

protocol BoxOfficeListViewModelOutput {
    var fetchedData: Observable<[BoxOfficeModel]> { get }
    var viewWillApperLoading: Observable<Void> { get }
    var refreshListLoading: Observable<Bool> { get }
}

final class BoxOfficeListViewModel: BoxOfficeViewModelable {
    private let disposeBag = DisposeBag()
    private let dailyBoxOffices = BehaviorRelay<[BoxOfficeModel]>(value: [])
    private let postEndLoding = PublishSubject<Void>()
    private let postEndRefreshLoading = PublishSubject<Bool>()
    var targetDate = Date()
    var input: BoxOfficeListViewModelInput { self }
    var output: BoxOfficeListViewModelOutput { self }
}

extension BoxOfficeListViewModel: BoxOfficeRepository {
    private func fetchData() {
        let yesterdayDate = targetDate.yesterday
        let endPoint = BoxOfficeEndPoint.dailyBoxOfficeList(BoxOfficeListParameters(targetDate: yesterdayDate,
                                                                                    itemPerPage: "10"))
        readDailyBoxOffice(endPoint: endPoint)
            .subscribe { [weak self] list in
                self?.dailyBoxOffices.accept(list)
                self?.postEndLoding.onNext(())
                self?.postEndRefreshLoading.onNext(false)
            }.disposed(by: disposeBag)
    }
}

extension BoxOfficeListViewModel: BoxOfficeListViewModelInput {
    func viewWillAppear() {
        fetchData()
    }
    
    func refreshList() {
        fetchData()
    }
}

extension BoxOfficeListViewModel: BoxOfficeListViewModelOutput {
    var fetchedData: Observable<[BoxOfficeModel]> {
        dailyBoxOffices.asObservable()
    }
    
    var viewWillApperLoading: Observable<Void> {
        postEndLoding.asObservable()
    }
    
    var refreshListLoading: Observable<Bool> {
        postEndRefreshLoading.asObservable()
    }
}

extension BoxOfficeListViewModel: DateSelectViewModelDelegate {
    func dateSelectViewModel(didTapedDate date: Date) {
        targetDate = date
        fetchData()
    }
}
