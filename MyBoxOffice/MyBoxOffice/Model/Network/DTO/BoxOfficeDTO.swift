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
    let dailyBoxOfficeList: [DailyBoxOfficeDTO]
}

struct DailyBoxOfficeDTO: Decodable{
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

extension DailyBoxOfficeDTO {
    func toDomain() -> BoxOfficeModel {
        BoxOfficeModel(rank: self.rank,
                            rankIncrement: self.rankInten,
                            rankOldAndNew: self.rankOldAndNew,
                            movieCode: self.movieCd,
                            movieName: self.movieNm,
                            audienceCount: self.audiCnt,
                            audienceAccumulate: self.audiAcc)
    }
}

enum RankOldAndNew: String, Decodable {
    case new = "NEW"
    case old = "OLD"
}
