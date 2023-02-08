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
        let nations: [NationDTO]
        let genres: [GenreDTO]
        let directors: [DirectorDTO]
        let actors: [ActorDTO]
        let showTypes: [ShowTypeDTO]
        let companys: [CompanyDTO]
        let audits: [AuditDTO]
}

struct NationDTO: Decodable {
    let nationNm: String
}

struct GenreDTO: Decodable {
    let genreNm: String
}

struct DirectorDTO: Decodable {
    let peopleNm: String
}

struct ActorDTO: Decodable {
    let peopleNm: String
}

struct AuditDTO: Decodable {
    let watchGradeNm: String
}

struct ShowTypeDTO: Decodable {
    let showTypeGroupNm: String
    let showTypeNm: String
}

struct CompanyDTO: Decodable {
    let companyCd: String
    let companyNm: String
    let companyNmEn: String
    let companyPartNm: String
}
