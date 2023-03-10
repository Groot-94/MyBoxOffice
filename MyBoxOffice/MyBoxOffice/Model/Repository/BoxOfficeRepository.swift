//
//  BoxOfficeRepository.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/08.
//

import Foundation
import RxSwift

protocol BoxOfficeRepository {
    func readDailyBoxOffice(date: Date, itemPerPage: String?) -> Observable<[BoxOfficeModel]>
    func readWeeklyBoxOffice(date: Date, standard: String, itemPerPage: String?) -> Observable<[BoxOfficeModel]>
    func readMovieInfo(endPoint: BoxOfficeEndPoint) -> Observable<MovieInfoModel>
    func readMovieCode(movieName: String) -> Observable<String>
}

extension BoxOfficeRepository {
    var netWorkManager: NetworkManager {
        NetworkManager()
    }
    
    func readDailyBoxOffice(date: Date, itemPerPage: String? = nil) -> Observable<[BoxOfficeModel]> {
        let yesterdayDate = date.yesterday
        let endPoint = BoxOfficeEndPoint.dailyBoxOfficeList(BoxOfficeListParameters(targetDate: yesterdayDate,
                                                                                    itemPerPage: itemPerPage))
        
        return netWorkManager.requestGetAPI(url: endPoint.url, parameters: endPoint.parameters)
            .decode(type: DailyBoxOfficeDTO.self, decoder: JSONDecoder())
            .map { $0.boxOfficeResult.dailyBoxOfficeList.map { $0.toDomain() } }
    }
    
    func readWeeklyBoxOffice(date: Date, standard: String ,itemPerPage: String? = nil) -> Observable<[BoxOfficeModel]> {
        let yesterdayDate = date.yesterday
        let weekGroup: BoxOfficeListParameters.WeekGb? = BoxOfficeListParameters.WeekGb(rawValue: standard)
        let parameters = BoxOfficeListParameters(targetDate: yesterdayDate,
                                                 weekGb: weekGroup,
                                                 itemPerPage: itemPerPage)
        let endPoint: BoxOfficeEndPoint = .weeklyBoxOfficeList(parameters)
        
        return netWorkManager.requestGetAPI(url: endPoint.url, parameters: endPoint.parameters)
            .decode(type: WeeklyBoxOfficeDTO.self, decoder: JSONDecoder())
            .map { $0.boxOfficeResult.weeklyBoxOfficeList.map { $0.toDomain() } }
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
