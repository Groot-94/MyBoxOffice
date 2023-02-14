//
//  ImageCacheManager.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/14.
//

import UIKit
import RxSwift
import Alamofire

final class ImageCacheManager {
    static let `default` = ImageCacheManager()
    private var imageCache = NSCache<NSString, UIImage>()
    private var requests = [String: DataRequest]()
    
    private init () {}
    
    func requestImage(url: String) -> Observable<UIImage> {
        if let image = imageCache.object(forKey: url as NSString) {
            return Observable.of(image)
        }
        
        return Observable<UIImage>.create { [weak self] observer in
            let request = AF.request(url)
            self?.requests[url] = request
            request
                .validate(statusCode: 200...299)
                .response { (response) in
                    guard let optionalData = response.value,
                          let data = optionalData,
                          let image = UIImage(data: data) else { return }
                    
                    self?.imageCache.setObject(image, forKey: url as NSString)
                    observer.onNext(image)
                    observer.onCompleted()
                }
            
            return Disposables.create()
        }.observe(on: MainScheduler.instance)
    }
    
    func cancel(url: String) {
        requests[url]?.cancel()
    }
}
