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
}
