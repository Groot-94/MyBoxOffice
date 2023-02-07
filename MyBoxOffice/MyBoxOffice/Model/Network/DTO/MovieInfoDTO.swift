//
//  MovieInfoDTO.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/06.
//

struct MovieInfoDTO: Decodable {
    let movieInfoResult: MovieInfoResultDTO
}

struct MovieInfoResultDTO: Decodable {
    let movieInfo: MovieDetailDTO
    let source: String
}

struct MovieDetailDTO: Decodable {
    let movieCd: String
        let movieNm: String
        let movieNmEn: String
        let movieNmOg: String
        let showTm: String
        let prdtYear: String
        let openDt: String
        let prdtStatNm: String
        let typeNm: String
        let nations: [Nation]
        let genres: [Genre]
        let directors: [Director]
        let actors: [Actor]
        let showTypes: [ShowType]
        let companys: [Company]
        let audits: [Audit]
}

struct Nation: Decodable {
    let nationNm: String
}

struct Genre: Decodable {
    let genreNm: String
}

struct Director: Decodable {
    let peopleNm: String
}

struct Actor: Decodable {
    let peopleNm: String
}

struct Audit: Decodable {
    let watchGradeNm: String
}

struct ShowType: Decodable {
    let showTypeGroupNm: String
    let showTypeNm: String
}

struct Company: Decodable {
    let companyCd: String
    let companyNm: String
    let companyNmEn: String
    let companyPartNm: String
}
