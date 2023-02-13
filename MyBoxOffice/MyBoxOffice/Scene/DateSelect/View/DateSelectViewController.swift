//
//  DateSelectViewController.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/12.
//

import UIKit
import RxSwift
import SnapKit

final class DateSelectViewController: UIViewController {
    weak var coodinator: Coordinator?
    private let disposeBag = DisposeBag()
    private var viewModel: DateSelectViewModelable
    private let calendarView = UICalendarView()
    
    init(coodinator: Coordinator? = nil, viewModel: DateSelectViewModelable) {
        self.coodinator = coodinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        coodinator?.parentCoordinator?.childDidFinish(coodinator)
    }
}

extension DateSelectViewController: ViewSettingProtocol {
    func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    func configureSubViews() {
        view.addSubview(calendarView)
        calendarView.selectionBehavior = UICalendarSelectionSingleDate(delegate: self)
        calendarView.visibleDateComponents = Calendar.current.dateComponents([.year, .month, .day],
                                                                             from: viewModel.targetDate)
        configureCalenderViewAvailableDateRange()
    }
    
    private func configureCalenderViewAvailableDateRange() {
        let fromDateComponents = DateComponents(calendar: Calendar(identifier: .gregorian), year: 2000, month: 1, day: 1)
        
        guard let fromDate = fromDateComponents.date else { return }
        
        let calendarViewDateRange = DateInterval(start: fromDate, end: Date())
        calendarView.availableDateRange = calendarViewDateRange
    }
    
    func configureLayouts() {
        calendarView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension DateSelectViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        guard let date = dateComponents?.date else { return }
        
        viewModel.input.didTapDate(date: date)
        dismiss(animated: true)
    }
}
