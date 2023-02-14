//
//  SearchMovieViewModel.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/13.
//

import Foundation
import RxSwift
import RxRelay

protocol SearchMovieViewModelable {
    var input: SearchMovieViewModelInput { get }
    var output: SearchMovieViewModelOutput { get }
}

protocol SearchMovieViewModelInput {
    func searchMovie(name: String)
    func didTapCell(model: NaverMovieModel)
}

protocol SearchMovieViewModelOutput {
    var postMovieSearchResult: Observable<[NaverMovieModel]> { get }
    var postMovieCodeSearchResult: Observable<String> { get }
}

struct SearchMovieViewModel: SearchMovieViewModelable {
    private let disposeBag = DisposeBag()
    private let movieSearchResult = BehaviorRelay<[NaverMovieModel]>(value: [])
    private let movieCodeSearchResult = PublishSubject<String>()
    var input: SearchMovieViewModelInput { self }
    var output: SearchMovieViewModelOutput { self }
}

extension SearchMovieViewModel: NaverRepository {
    private func searchData(name: String) {
        requestMovieInfo(moiveName: name)
            .subscribe { movies in
                movieSearchResult.accept(movies)
            }.disposed(by: disposeBag)
    }
}

extension SearchMovieViewModel: BoxOfficeRepository {
    private func searchMovieCode(name: String) {
        readMovieCode(movieName: name)
            .subscribe { movieCode in
                movieCodeSearchResult.onNext(movieCode)
            }.disposed(by: disposeBag)
    }
}

extension SearchMovieViewModel: SearchMovieViewModelInput {
    func searchMovie(name: String) {
        searchData(name: name)
    }
    
    func didTapCell(model: NaverMovieModel) {
        searchMovieCode(name: model.movieName)
    }
}

extension SearchMovieViewModel: SearchMovieViewModelOutput {
    var postMovieSearchResult: Observable<[NaverMovieModel]> {
        movieSearchResult.asObservable()
    }
    
    var postMovieCodeSearchResult: Observable<String> {
        movieCodeSearchResult.asObserver()
    }
}
