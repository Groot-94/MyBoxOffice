//
//  BoxOfficeDTO.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/06.
//

struct BoxOfficeDTO: Decodable {
    let boxOfficeResult: BoxOfficeResultDTO
}

struct BoxOfficeResultDTO: Decodable {
    let boxofficeType: String
    let showRange: String
    let dailyBoxOfficeList: [DailyBoxOffice]
}

struct DailyBoxOffice: Decodable{
    let rnum: String
    let rank: String
    let rankInten: String
    let rankOldAndNew: RankOldAndNew
    let movieCd: String
    let movieNm: String
    let openDt: String
    let salesAmt: String
    let salesShare: String
    let salesInten: String
    let salesChange: String
    let salesAcc: String
    let audiCnt: String
    let audiInten: String
    let audiChange: String
    let audiAcc: String
    let scrnCnt: String
    let showCnt: String
}

enum RankOldAndNew: String, Decodable {
    case new = "NEW"
    case old = "OLD"
}
