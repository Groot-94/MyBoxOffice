//
//  DateSelectViewModel.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/12.
//

import Foundation
import RxSwift

protocol DateSelectViewModelable {
    var input: DateSelectModelInput { get }
    var targetDate: Date { get }
}

protocol DateSelectModelInput {
    func didTapDate(date: Date)
}

protocol DateSelectViewModelDelegate: AnyObject {
    func dateSelectViewModel(didTapedDate date: Date)
}

final class DateSelectViewModel: DateSelectViewModelable {
    var targetDate: Date
    var input: DateSelectModelInput { self }
    private let selectedDate = PublishSubject<Date>()
    weak var delegate: DateSelectViewModelDelegate?
    
    init(targetDate: Date, delegate: DateSelectViewModelDelegate? = nil) {
        self.targetDate = targetDate
        self.delegate = delegate
    }
}

extension DateSelectViewModel: DateSelectModelInput {
    func didTapDate(date: Date) {
        delegate?.dateSelectViewModel(didTapedDate: date)
    }
}
