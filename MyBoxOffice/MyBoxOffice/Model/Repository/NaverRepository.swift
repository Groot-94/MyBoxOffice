//
//  NaverRepository.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/11.
//

import Foundation
import RxSwift

protocol NaverRepository {
    func requestMoviePosterImage(moiveName: String) -> Observable<Data>
    func requestMovieInfo(moiveName: String) -> Observable<[NaverMovieModel]>
}

extension NaverRepository {
    var netWorkManager: NetworkManager {
        NetworkManager()
    }
    
    func requestMoviePosterImage(moiveName: String) -> Observable<Data> {
        let endPoint = NaverSearchEndPoint.posterImage(NaverImageParameters(searchText: moiveName + " 영화 포스터"))
        
        return netWorkManager.requestGetAPI(url: endPoint.url, parameters: endPoint.parameters, headers: endPoint.headers)
            .decode(type: NaverImageDTO.self, decoder: JSONDecoder())
            .flatMap { naverImage -> Observable<Data> in
                netWorkManager.requestGetAPI(url: naverImage.items.first?.link ?? "")
            }
    }
    
    func requestMovieInfo(moiveName: String) -> Observable<[NaverMovieModel]> {
        let endPoint = NaverSearchEndPoint.movieInfo(NaverMovieParameters(searchText: moiveName))
        
        return netWorkManager.requestGetAPI(url: endPoint.url, parameters: endPoint.parameters, headers: endPoint.headers)
            .decode(type: NaverMovieDTO.self, decoder: JSONDecoder())
            .map { naverMovieDTO in
                naverMovieDTO.items.map { $0.toDomain() }
            }
    }
}
