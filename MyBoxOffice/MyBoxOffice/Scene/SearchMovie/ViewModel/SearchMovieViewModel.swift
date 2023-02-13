//
//  SearchMovieViewModel.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/13.
//

import Foundation
import RxSwift

protocol SearchMovieViewModelable {
    var input: SearchMovieViewModelInput { get }
    var output: SearchMovieViewModelOutput { get }
}

protocol SearchMovieViewModelInput {
}

protocol SearchMovieViewModelOutput {
}

struct SearchMovieViewModel: SearchMovieViewModelable {
    private let disposeBag = DisposeBag()
    var input: SearchMovieViewModelInput { self }
    var output: SearchMovieViewModelOutput { self }
}

extension SearchMovieViewModel: SearchMovieViewModelInput {
    
}

extension SearchMovieViewModel: SearchMovieViewModelOutput {
    
}
