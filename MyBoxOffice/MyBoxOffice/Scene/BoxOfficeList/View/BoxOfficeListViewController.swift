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
        
        viewModel.output.viewWillApperLoading
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                
                self.endLodingView(showView: self.listView)
            }.disposed(by: disposeBag)
        
        viewModel.output.refreshListLoading
            .skip(1)
            .bind(to: refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        listView.listCollectionView.rx.modelSelected(BoxOfficeModel.self)
            .bind(onNext: { [weak self] model in
                guard let self = self else { return }
                
                self.coodinator?.showMovieInfo(movieCode: model.movieCode)
            })
            .disposed(by: disposeBag)
    }
}

extension BoxOfficeListViewController: ViewSettingProtocol, LodingViewProtocol {
    func configureView() {
        view.backgroundColor = .systemBackground
        configureNavigationView()
        configureRefreshControl()
    }
    
    private func configureNavigationView() {
        navigationController?.navigationBar.topItem?.title = viewModel.targetDate.toString(form: "yyyy-MM-dd")
        let backBarButtonItem = UIBarButtonItem(title: "back", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButtonItem
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
        view.addSubview(listView)
        configureLodingView(superView: view)
    }
    
    func configureLayouts() {
        listView.listCollectionView.setCollectionViewLayout(createListLayout(), animated: true)
        listView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func createListLayout() -> UICollectionViewCompositionalLayout {
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        item.contentInsets = .init(top: 16, leading: 16, bottom: 16, trailing: 16)
        let groupsize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(0.15))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupsize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}
