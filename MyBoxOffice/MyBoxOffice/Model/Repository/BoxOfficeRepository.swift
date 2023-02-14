//
//  BoxOfficeRepository.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/08.
//

import Foundation
import RxSwift

protocol BoxOfficeRepository {
    func readDailyBoxOffice(endPoint: BoxOfficeEndPoint) -> Observable<[BoxOfficeModel]>
    func readMovieInfo(endPoint: BoxOfficeEndPoint) -> Observable<MovieInfoModel>
    func readMovieCode(movieName: String) -> Observable<String>
}

extension BoxOfficeRepository {
    var netWorkManager: NetworkManager {
        NetworkManager()
    }
    
    func readDailyBoxOffice(endPoint: BoxOfficeEndPoint) -> Observable<[BoxOfficeModel]> {
        netWorkManager.requestGetAPI(url: endPoint.url, parameters: endPoint.parameters)
            .decode(type: BoxOfficeDTO.self, decoder: JSONDecoder())
            .map { $0.boxOfficeResult.dailyBoxOfficeList.map { $0.toDomain() } }
    }
    
    func readMovieInfo(endPoint: BoxOfficeEndPoint) -> Observable<MovieInfoModel> {
        netWorkManager.requestGetAPI(url: endPoint.url, parameters: endPoint.parameters)
            .decode(type: MovieDTO.self, decoder: JSONDecoder())
            .map { $0.movieInfoResult.movieInfo.toDomain() }
    }
    
    func readMovieCode(movieName: String) -> Observable<String> {
        let endPoint = BoxOfficeEndPoint.movieList(MovieListParameters(movieNm: movieName))
        
        return netWorkManager.requestGetAPI(url: endPoint.url, parameters: endPoint.parameters)
            .decode(type: MovieSearchListDTO.self, decoder: JSONDecoder())
            .compactMap { $0.movieListResult.movieList.first?.movieCd }
    }
}
