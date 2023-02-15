//
//  MovieInfoViewController.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/09.
//

import UIKit
import RxSwift
import SnapKit

final class MovieInfoViewController: UIViewController {
    weak var coodinator: Coordinator?
    private let viewModel: MovieInfoViewModelable
    private let disposeBag = DisposeBag()
    private let movieInfoView = MovieInfoView()
    private let refreshControl = UIRefreshControl()
    let backgroundView = UIView()
    let activityIndicatorView = UIActivityIndicatorView(style: .large)
    
    init(coodinator: Coordinator? = nil, viewModel: MovieInfoViewModelable) {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startLodingView(hideView: movieInfoView)
        viewModel.input.viewWillAppear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        coodinator?.parentCoordinator?.childDidFinish(coodinator)
    }
    
    private func bind() {
        viewModel.output.postMovieInfo
            .observe(on: MainScheduler.instance)
            .subscribe (onNext: { [weak self] model in
                guard let self = self else { return }
                
                self.movieInfoView.configureItems(movieInfoModel: model)
                self.configureNavigationTitle(model.movieName)
                self.endLodingView(showView: self.movieInfoView)
            }).disposed(by: disposeBag)
        
        viewModel.output.postMoviePoster
            .flatMap { url -> Observable<UIImage> in
                ImageCacheManager.default.requestImage(url: url)
            }
            .subscribe (onNext: { [weak self] image in
                self?.movieInfoView.configureImage(image: image)
            }).disposed(by: disposeBag)
    }
    
    private func configureNavigationTitle(_ text: String) {
        navigationController?.navigationBar.topItem?.title = text
    }
}

extension MovieInfoViewController: ViewSettingProtocol, LodingViewProtocol {
    func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    func configureSubViews() {
        view.addSubview(movieInfoView)
        configureLodingView(superView: view)
    }
    
    func configureLayouts() {
        movieInfoView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
