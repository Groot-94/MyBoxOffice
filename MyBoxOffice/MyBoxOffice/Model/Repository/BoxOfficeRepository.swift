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
}
