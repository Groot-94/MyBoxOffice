//
//  NetworkManager.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/06.
//

import Foundation
import Alamofire
import RxSwift

struct NetworkManager {
    private let session: Session
        
    init(session: Session = Session.default) {
            self.session = session
    }
    
    func requestGetAPI(url: String, parameters: Parameters? = nil, headers: HTTPHeaders? = nil) -> Observable<Data> {
        return Observable<Data>.create { observer in
            session
                .request(url, method: .get, parameters: parameters, headers: headers)
                .validate(statusCode: 200...299)
                .response { (response) in
                    guard let optionalData = response.value,
                          let data = optionalData else { return }
                    
                    observer.onNext(data)
                    observer.onCompleted()
                }
            
            return Disposables.create()
        }
    }
}


