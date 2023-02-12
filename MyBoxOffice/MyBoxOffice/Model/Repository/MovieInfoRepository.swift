//
//  MovieInfoRepository.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/11.
//

import Foundation
import RxSwift

protocol MovieInfoRepository {
    func readMovieInfo(endPoint: BoxOfficeEndPoint) -> Observable<MovieInfoModel>
    func readPosterImage(moiveName: String) -> Observable<Data>
}

extension MovieInfoRepository {
    var netWorkManager: NetworkManager {
        NetworkManager()
    }
    
    func readMovieInfo(endPoint: BoxOfficeEndPoint) -> Observable<MovieInfoModel> {
        netWorkManager.requestGetAPI(url: endPoint.url, parameters: endPoint.parameters)
            .decode(type: MovieDTO.self, decoder: JSONDecoder())
            .map { $0.movieInfoResult.movieInfo.toDomain() }
    }
    
    func readPosterImage(moiveName: String) -> Observable<Data> {
        let endPoint = NaverSearchEndPoint.posterImage(NaverImageParameters(searchText: moiveName + " 영화 포스터"))
        return netWorkManager.requestGetAPI(url: endPoint.url, parameters: endPoint.parameters, headers: endPoint.headers)
            .decode(type: NaverImageDTO.self, decoder: JSONDecoder())
            .flatMap { naverImage -> Observable<Data> in
                netWorkManager.requestGetAPI(url: naverImage.items.first?.link ?? "")
            }
    }
}
