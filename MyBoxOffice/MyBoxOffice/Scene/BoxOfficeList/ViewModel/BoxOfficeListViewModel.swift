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
    var targetDate: BehaviorRelay<Date> { get set }
}

protocol BoxOfficeListViewModelInput {
    func viewWillAppear()
    func refreshList()
    func changeWeekGroup(standard: BoxOfficeListViewModel.BoxOfficeStandard)
}

protocol BoxOfficeListViewModelOutput {
    var fetchedData: Observable<[BoxOfficeModel]> { get }
    var hideLoadingView: Observable<Void> { get }
    var hideRefresh: Observable<Bool> { get }
    var fetchedTargetDate: Observable<Date> { get }
}

final class BoxOfficeListViewModel: BoxOfficeViewModelable {
    private let disposeBag = DisposeBag()
    private let dailyBoxOffices = BehaviorRelay<[BoxOfficeModel]>(value: [])
    private let postEndLoding = PublishSubject<Void>()
    private let postEndRefresh = PublishSubject<Bool>()
    private var standard: BoxOfficeStandard = .daliy
    var targetDate = BehaviorRelay<Date>(value: Date())
    var input: BoxOfficeListViewModelInput { self }
    var output: BoxOfficeListViewModelOutput { self }
}

extension BoxOfficeListViewModel: BoxOfficeRepository {
    private func fetchData() {
        standard == .daliy ? fetchDataDailyBoxOffice() : fetchDataWeeklyBoxOffice()
    }
    
    private func fetchDataDailyBoxOffice() {
        readDailyBoxOffice(date: targetDate.value)
            .subscribe { [weak self] list in
                self?.dailyBoxOffices.accept(list)
                self?.postEndLoding.onNext(())
                self?.postEndRefresh.onNext(false)
            }.disposed(by: disposeBag)
    }
    
    private func fetchDataWeeklyBoxOffice() {
        readWeeklyBoxOffice(date: targetDate.value, standard: standard.value)
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
    
    func changeWeekGroup(standard: BoxOfficeStandard) {
        self.standard = standard
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
    
    var fetchedTargetDate: Observable<Date> {
        targetDate.asObservable()
    }
}

extension BoxOfficeListViewModel: DateSelectViewModelDelegate {
    func dateSelectViewModel(didTapedDate date: Date) {
        targetDate.accept(date)
        fetchData()
    }
}

extension BoxOfficeListViewModel {
    enum BoxOfficeStandard {
        case daliy
        case week
        case weekend
        
        var value: String {
            switch self {
            case .daliy:
                return ""
            case .week:
                return "0"
            case .weekend:
                return "1"
            }
        }
    }
}
