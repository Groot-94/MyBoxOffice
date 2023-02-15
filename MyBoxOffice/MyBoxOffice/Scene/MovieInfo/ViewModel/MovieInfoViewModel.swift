//
//  MovieInfoViewModel.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/09.
//

import Foundation
import RxSwift

protocol MovieInfoViewModelable {
    var input: MovieInfoViewModelInput { get }
    var output: MovieInfoViewModelOutput { get }
    var movieCode: String { get }
}

protocol MovieInfoViewModelInput {
    func viewWillAppear()
}

protocol MovieInfoViewModelOutput {
    var postMovieInfo: Observable<MovieInfoModel> { get }
    var postMoviePoster: Observable<String> { get }
}

struct MovieInfoViewModel: MovieInfoViewModelable {
    private let disposeBag = DisposeBag()
    private let movieInfo = PublishSubject<MovieInfoModel>()
    private let moviePoster = PublishSubject<String>()
    let movieCode: String
    var input: MovieInfoViewModelInput { self }
    var output: MovieInfoViewModelOutput { self }
}

extension MovieInfoViewModel: BoxOfficeRepository, NaverRepository {
    private func fetchData() {
        let endPoint = BoxOfficeEndPoint.movieInfo(MovieParameters(movieCd: movieCode))
        readMovieInfo(endPoint: endPoint)
            .subscribe(onNext: { model in
                movieInfo.onNext(model)
                fetchPosterImage(moiveName: model.movieName)
            }).disposed(by: disposeBag)
    }
    
    private func fetchPosterImage(moiveName: String) {
        readMoviePosterImage(moiveName: moiveName)
            .subscribe(onNext: { url in
                moviePoster.onNext(url)
            }).disposed(by: disposeBag)
    }
}

extension MovieInfoViewModel: MovieInfoViewModelInput {
    func viewWillAppear() {
        fetchData()
    }
}

extension MovieInfoViewModel: MovieInfoViewModelOutput {
    var postMovieInfo: Observable<MovieInfoModel> {
        movieInfo.asObserver()
    }
    
    var postMoviePoster: Observable<String> {
        moviePoster.asObservable()
    }
}
