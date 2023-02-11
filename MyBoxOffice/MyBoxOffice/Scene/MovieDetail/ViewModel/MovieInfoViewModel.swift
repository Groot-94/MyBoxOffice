//
//  MovieInfoViewModel.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/09.
//

import RxSwift

protocol MovieInfoViewModelable {
    var input: MovieInfoViewModelInput { get }
    var output: MovieInfoViewModelOutput { get }
    var movieCode: String { get }
}

protocol MovieInfoViewModelInput {
    func viewDidLoad()
}

protocol MovieInfoViewModelOutput {
    var postMovieInfo: Observable<MovieInfoModel> { get }
}

struct MovieInfoViewModel: MovieInfoViewModelable {
    private let disposeBag = DisposeBag()
    private let movieInfo = PublishSubject<MovieInfoModel>()
    let movieCode: String
    var input: MovieInfoViewModelInput { self }
    var output: MovieInfoViewModelOutput { self }
}

extension MovieInfoViewModel: MovieInfoRepository {
    private func fetchData() {
        let endPoint = BoxOfficeEndPoint.movieInfo(MovieParameters(movieCd: movieCode))
        readMovieInfo(endPoint: endPoint)
            .subscribe { model in
                movieInfo.onNext(model)
            }.disposed(by: disposeBag)
    }
}

extension MovieInfoViewModel: MovieInfoViewModelInput {
    func viewDidLoad() {
        fetchData()
    }
}

extension MovieInfoViewModel: MovieInfoViewModelOutput {
    var postMovieInfo: Observable<MovieInfoModel> {
        movieInfo.asObserver()
    }
}
