//
//  SearchMovieViewController.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/13.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class SearchMovieViewController: UIViewController {
    var coodinator: SearchMovieCoodinator?
    private let viewModel: SearchMovieViewModelable
    private let disposeBag = DisposeBag()
    private let searchController = UISearchController()
    private let listView = UITableView()
    private var isSelectedCell = false
    
    init(coodinator: SearchMovieCoodinator? = nil, viewModel: SearchMovieViewModelable) {
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
        bind()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        coodinator?.parentCoordinator?.childDidFinish(coodinator)
    }
    
    private func bind() {
        viewModel.output.postMovieSearchResult
            .skip(1)
            .bind(to: listView.rx.items(cellIdentifier: "MovieTableViewCell",
                                        cellType: SearMovieResultTableViewCell.self)) { (row, model, cell) in
                cell.configureItems(model)
            }.disposed(by: disposeBag)
        
        viewModel.output.postMovieCodeSearchResult
            .subscribe(onNext: { [weak self] movieCode in
                self?.coodinator?.showMovieInfo(movieCode: movieCode)
                self?.isSelectedCell = false
            }).disposed(by: disposeBag)
        
        listView.rx.modelSelected(NaverMovieModel.self)
            .subscribe(onNext: { [weak self] model in
                guard let self = self,
                self.isSelectedCell == false else { return }
                
                self.viewModel.input.didTapCell(model: model)
                self.isSelectedCell = true
            }).disposed(by: disposeBag)
        
        listView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.listView.deselectRow(at: indexPath, animated: true)
            }).disposed(by: disposeBag)
    }
}

extension SearchMovieViewController: ViewSettingProtocol {
    func configureView() {
        view.backgroundColor = .systemBackground
        configureSearchController()
        configureNavigationView()
    }
    
    private func configureSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "????????? ??????"
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.automaticallyShowsCancelButton = false
        navigationItem.searchController = searchController
    }
    
    private func configureNavigationView() {
        let backBarButtonItem = UIBarButtonItem(title: "??????", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        navigationItem.title = "????????????"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    func configureSubViews() {
        view.addSubview(listView)
        configureListView()
    }
    
    private func configureListView() {
        listView.showsVerticalScrollIndicator = false
        listView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        listView.register(SearMovieResultTableViewCell.self, forCellReuseIdentifier: "MovieTableViewCell")
    }
    
    func configureLayouts() {
        listView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).offset(8)
        }
    }
}

extension SearchMovieViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        
        viewModel.input.searchMovie(name: text)
    }
}
