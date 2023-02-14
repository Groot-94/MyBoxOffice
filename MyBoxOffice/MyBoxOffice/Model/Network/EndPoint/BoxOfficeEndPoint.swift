//
//  BoxOfficeEndPoint.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/07.
//

import Foundation
import Alamofire

enum BoxOfficeEndPoint {
    case dailyBoxOfficeList(BoxOfficeListParameters)
    case movieInfo(MovieParameters)
    case movieList(MovieListParameters)
    
    private var baseURL: String {
        return "https://www.kobis.or.kr/kobisopenapi/webservice/rest/"
    }
    
    private var path: String {
        switch self {
        case .dailyBoxOfficeList:
            return "boxoffice/searchDailyBoxOfficeList.json"
        case .movieInfo:
            return "movie/searchMovieInfo.json"
        case .movieList:
            return "movie/searchMovieList.json"
        }
    }
    
    var url: String {
        return baseURL + path
    }
    
    var parameters: Parameters {
        switch self {
        case .dailyBoxOfficeList(let boxOfficeListParameters):
            return boxOfficeListParameters.parameters
        case .movieInfo(let movieParameters):
            return movieParameters.parameters
        case .movieList(let movieListParameters):
            return movieListParameters.parameters
        }
    }
}

struct BoxOfficeListParameters {
    private let key: String
    private let targetDate: String
    private var itemPerPage: String?
    private var multiMovieYn: MultiMovieYn?
    private var repNationCd: RepNationCd?
    private var wideAreaCd: String?
    
    init(key: String = BoxOfficePrivateKey.value ,
         targetDate: String,
         itemPerPage: String? = nil,
         multiMovieYn: MultiMovieYn? = nil,
         repNationCd: RepNationCd? = nil,
         wideAreaCd: String? = nil) {
        self.key = key
        self.targetDate = targetDate
        self.itemPerPage = itemPerPage
        self.multiMovieYn = multiMovieYn
        self.repNationCd = repNationCd
        self.wideAreaCd = wideAreaCd
    }
    
    var parameters: [String: String] {
        [
            "key": key,
            "targetDt": targetDate,
            "itemPerPage": itemPerPage ?? "",
            "multiMovieYn": multiMovieYn?.value ?? "",
            "repNationCd": repNationCd?.value ?? "",
            "wideAreaCd": wideAreaCd ?? ""
        ]
    }
    
    enum MultiMovieYn {
        case yes
        case no
        
        var value: String {
            switch self {
            case .yes:
                return "Y"
            case .no:
                return "N"
            }
        }
    }
    
    enum RepNationCd {
        case korea
        case foreign
        
        var value: String {
            switch self {
            case .korea:
                return "K"
            case .foreign:
                return "F"
            }
        }
    }
}

struct MovieParameters {
    private let key: String
    private let movieCd: String
    
    init(key: String = BoxOfficePrivateKey.value, movieCd: String) {
        self.key = key
        self.movieCd = movieCd
    }
    
    var parameters: [String: String] {
        [
            "key": key,
            "movieCd": movieCd
        ]
    }
}

struct MovieListParameters {
    private let key: String
    private let movieNm: String
    
    init(key: String = BoxOfficePrivateKey.value, movieNm: String) {
        self.key = key
        self.movieNm = movieNm
    }
    
    var parameters: [String: String] {
        [
            "key": key,
            "movieNm": movieNm
        ]
    }
}

enum BoxOfficePrivateKey {
    static var value: String {
        guard let url = Bundle.main.url(forResource: "Info", withExtension: "plist"),
              let dictionary = NSDictionary(contentsOf: url) else { return "" }
        
        return dictionary["BoxOfficeAPIPrivateKey"] as? String ?? ""
    }
}
