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
    var targetDate: Date { get set }
}

protocol BoxOfficeListViewModelInput {
    func viewWillAppear()
    func refreshList()
}

protocol BoxOfficeListViewModelOutput {
    var fetchedData: Observable<[BoxOfficeModel]> { get }
    var hideLoadingView: Observable<Void> { get }
    var hideRefresh: Observable<Bool> { get }
}

final class BoxOfficeListViewModel: BoxOfficeViewModelable {
    private let disposeBag = DisposeBag()
    private let dailyBoxOffices = BehaviorRelay<[BoxOfficeModel]>(value: [])
    private let postEndLoding = PublishSubject<Void>()
    private let postEndRefresh = PublishSubject<Bool>()
    var targetDate = Date()
    var input: BoxOfficeListViewModelInput { self }
    var output: BoxOfficeListViewModelOutput { self }
}

extension BoxOfficeListViewModel: BoxOfficeRepository {
    private func fetchData() {
        readDailyBoxOffice(date: targetDate)
            .subscribe { [weak self] list in
                self?.dailyBoxOffices.accept(list)
                self?.postEndLoding.onNext(())
                self?.postEndRefresh.onNext(false)
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
    
    var hideLoadingView: Observable<Void> {
        postEndLoding.asObservable()
    }
    
    var hideRefresh: Observable<Bool> {
        postEndRefresh.asObservable()
    }
}

extension BoxOfficeListViewModel: DateSelectViewModelDelegate {
    func dateSelectViewModel(didTapedDate date: Date) {
        targetDate = date
        fetchData()
    }
}
