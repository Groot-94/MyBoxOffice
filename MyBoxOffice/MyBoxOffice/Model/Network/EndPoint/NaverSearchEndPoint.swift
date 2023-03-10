//
//  NaverSerchEndPoint.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/12.
//

import Foundation
import Alamofire

enum NaverSearchEndPoint {
    case posterImage(NaverImageParameters)
    case movieInfo(NaverMovieParameters)
    
    private var baseURL: String {
        return "https://openapi.naver.com/v1/search/"
    }
    
    private var path: String {
        switch self {
        case .posterImage:
            return "image"
        case .movieInfo:
            return "movie.json"
        }
    }
    
    var url: String {
        return baseURL + path
    }
    
    var parameters: Parameters {
        switch self {
        case .posterImage(let naverImageParameters):
            return naverImageParameters.parameters
        case .movieInfo(let naverMovieParameters):
            return naverMovieParameters.parameters
        }
    }
    
    var headers: HTTPHeaders {
        HTTPHeaders(["X-Naver-Client-Id": NaverSearchPrivateKeys.ID,
                     "X-Naver-Client-Secret": NaverSearchPrivateKeys.secret])
    }
}

struct NaverImageParameters {
    private let searchText: String
    private let display: String?
    private var start: String?
    private var sort: String?
    private var filter: String?
    
    init(searchText: String,
         display: String? = nil,
         start: String? = nil,
         sort: String? = nil,
         filter: String? = nil) {
        self.searchText = searchText
        self.display = display
        self.start = start
        self.sort = sort
        self.filter = filter
    }
    
    var parameters: [String: String] {
        [
            "query": searchText,
            "display": display ?? "1",
            "start": start ?? "1",
            "sort": sort ?? "sim",
            "filter": filter ?? "all"
        ]
    }
}

struct NaverMovieParameters {
    private let searchText: String
    private let display: String?
    private var start: String?
    private var genre: String?
    private var country: String?
    private var yearFrom: Int?
    private var yearTo: Int?
    
    init(searchText: String,
         display: String? = nil,
         start: String? = nil,
         genre: String? = nil,
         country: String? = nil,
         yearFrom: Int? = nil,
         yearTo: Int? = nil) {
        self.searchText = searchText
        self.display = display
        self.start = start
        self.genre = genre
        self.country = country
        self.yearFrom = yearFrom
        self.yearTo = yearTo
    }
    
    var parameters: [String: Any] {
        [
            "query": searchText,
            "display": display ?? "10",
            "start": start ?? "1",
            "genre": genre ?? "",
            "country": country ?? "",
            "yearfrom": yearFrom ?? 1900,
            "yearto": yearTo ?? 2023
        ]
    }
}

enum NaverSearchPrivateKeys {
    static var ID: String {
        guard let url = Bundle.main.url(forResource: "Info", withExtension: "plist"),
              let dictionary = NSDictionary(contentsOf: url) else { return "" }
        
        return dictionary["NaverSearchID"] as? String ?? ""
    }
    
    static var secret: String {
        guard let url = Bundle.main.url(forResource: "Info", withExtension: "plist"),
              let dictionary = NSDictionary(contentsOf: url) else { return "" }
        
        return dictionary["NaverSerchSecret"] as? String ?? ""
    }
}
