//
//  BoxOfficeListViewController.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/06.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

final class BoxOfficeListViewController: UIViewController {
    weak var coodinator: BoxOfficeListCoodinator?
    private let viewModel: BoxOfficeViewModelable
    private let disposeBag = DisposeBag()
    private let tapBarView = CustomTapBarView()
    private let listView = BoxOfficeListView()
    private let refreshControl = UIRefreshControl()
    let backgroundView = UIView()
    let activityIndicatorView = UIActivityIndicatorView(style: .large)
    
    init(coodinator: BoxOfficeListCoodinator? = nil, viewModel: BoxOfficeViewModelable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        commonInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.input.viewWillAppear()
        startLodingView(hideView: listView)
    }
    
    private func bind() {
        viewModel.output.fetchedData
            .skip(1)
            .bind(to: listView.listCollectionView.rx.items(cellIdentifier: "BoxOfficeCollectionViewCell",
                                                           cellType: BoxOfficeCollectionViewCell.self))
        { (row, model, cell) in
            
            cell.configureCellItems(dailyBoxOfficeModel: model)
        }.disposed(by: disposeBag)
        
        viewModel.output.hideLoadingView
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                
                self.endLodingView(showView: self.listView)
            }.disposed(by: disposeBag)
        
        viewModel.output.hideRefresh
            .skip(1)
            .bind(to: refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        viewModel.output.fetchedTargetDate
            .subscribe { [weak self] date in
                self?.configureNavigationTitle(date.toString(form: "yyyy-MM-dd"))
            }.disposed(by: disposeBag)
        
        listView.listCollectionView.rx.modelSelected(BoxOfficeModel.self)
            .bind(onNext: { [weak self] model in
                guard let self = self else { return }
                
                self.coodinator?.showMovieInfo(movieCode: model.movieCode)
            })
            .disposed(by: disposeBag)
    }
    
    private func configureNavigationTitle(_ text: String) {
        navigationController?.navigationBar.topItem?.title = text
    }
}

extension BoxOfficeListViewController: ViewSettingProtocol, LodingViewProtocol {
    func configureView() {
        view.backgroundColor = .systemBackground
        configureNavigationView()
        configureRefreshControl()
    }
    
    private func configureNavigationView() {
        let dateSelectBarButton = UIBarButtonItem(title: "날짜선택", image: nil, target: self, action: #selector(didTapDateSelectButton))
        dateSelectBarButton.tintColor = .black
        let serchBarButton = UIBarButtonItem(title: "검색", image: nil, target: self, action: #selector(didTapserchBarButton))
        serchBarButton.tintColor = .black
        let backBarButtonItem = UIBarButtonItem(title: "뒤로", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        navigationItem.leftBarButtonItem = serchBarButton
        navigationItem.rightBarButtonItem = dateSelectBarButton
        navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    @objc
    private func didTapserchBarButton() {
        coodinator?.showSearchMovie()
    }
    
    @objc
    private func didTapDateSelectButton() {
        coodinator?.showDateSelect(currentDate: viewModel.targetDate.value)
    }
    
    private func configureRefreshControl() {
        refreshControl.addTarget(self, action: #selector(didTapRefresh), for: .valueChanged)
        listView.listCollectionView.refreshControl = refreshControl
    }
    
    @objc
    private func didTapRefresh() {
        refreshControl.beginRefreshing()
        viewModel.input.refreshList()
    }
    
    func configureSubViews() {
        view.addSubview(tapBarView)
        view.addSubview(listView)
        configureLodingView(superView: view)
        configureTapView()
    }
    
    func configureTapView() {
        tapBarView.delegate = self
        tapBarView.tabMenuList = ["일별", "주간"]
        tapBarView.indicatorViewWidthConstraint.constant = view.frame.width / 2
    }
    
    func configureLayouts() {
        NSLayoutConstraint.activate([
            tapBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            tapBarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tapBarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tapBarView.heightAnchor.constraint(lessThanOrEqualToConstant: 32)])
        listView.listCollectionView.setCollectionViewLayout(createListLayout(), animated: true)
        listView.snp.makeConstraints { make in
            make.top.equalTo(tapBarView.snp.bottom).offset(8)
            make.bottom.equalTo(view.snp.bottom)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
        }
    }
    
    private func createListLayout() -> UICollectionViewCompositionalLayout {
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        item.contentInsets = .init(top: 8, leading: 16, bottom: 8, trailing: 16)
        let groupsize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(0.15))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupsize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}

extension BoxOfficeListViewController: CustomTapBarViewDelegate {
    func didTapCell(indexPath: IndexPath) {
        if indexPath.row == 1 {
            tapBarView.indicatorViewLeadingConstraint.constant = tapBarView.frame.maxX / 2
        } else {
            tapBarView.indicatorViewLeadingConstraint.constant = 0
        }
    }
}
