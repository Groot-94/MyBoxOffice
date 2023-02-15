//
//  NaverRepository.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/11.
//

import Foundation
import RxSwift

protocol NaverRepository {
    func readMoviePosterImage(moiveName: String) -> Observable<String>
    func readMovieInfo(moiveName: String) -> Observable<[NaverMovieModel]>
}

extension NaverRepository {
    var netWorkManager: NetworkManager {
        NetworkManager()
    }
    
    func readMoviePosterImage(moiveName: String) -> Observable<String> {
        let endPoint = NaverSearchEndPoint.posterImage(NaverImageParameters(searchText: moiveName + " 영화 포스터"))
        
        return netWorkManager.requestGetAPI(url: endPoint.url, parameters: endPoint.parameters, headers: endPoint.headers)
            .decode(type: NaverImageDTO.self, decoder: JSONDecoder())
            .map { naverImage in
                naverImage.items.first?.link ?? ""
            }
    }
    
    func readMovieInfo(moiveName: String) -> Observable<[NaverMovieModel]> {
        let endPoint = NaverSearchEndPoint.movieInfo(NaverMovieParameters(searchText: moiveName))
        
        return netWorkManager.requestGetAPI(url: endPoint.url, parameters: endPoint.parameters, headers: endPoint.headers)
            .decode(type: NaverMovieDTO.self, decoder: JSONDecoder())
            .map { naverMovieDTO in
                naverMovieDTO.items.map { $0.toDomain() }
            }
    }
}
