//
//  BoxOfficeRepository.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/08.
//

import Foundation
import RxSwift

protocol BoxOfficeRepository {
    func readDailyBoxOffice(endPoint: BoxOfficeEndPoint) -> Observable<[DailyBoxOffice]>
}

extension BoxOfficeRepository {
    var netWorkManager: NetworkManager {
        NetworkManager()
    }
    
    func readDailyBoxOffice(endPoint: BoxOfficeEndPoint) -> Observable<[DailyBoxOffice]> {
        netWorkManager.requestGetAPI(url: endPoint.url, parameters: endPoint.parameters)
            .decode(type: BoxOfficeDTO.self, decoder: JSONDecoder())
            .map { boxOffice in
                boxOffice.boxOfficeResult.dailyBoxOfficeList
            }
    }
}
