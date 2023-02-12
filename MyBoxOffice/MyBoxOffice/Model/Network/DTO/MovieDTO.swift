//
//  MovieDTO.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/06.
//

struct MovieDTO: Decodable {
    let movieInfoResult: MovieInfoResultDTO
}

struct MovieInfoResultDTO: Decodable {
    let movieInfo: MovieInfoDTO
    let source: String
}

struct MovieInfoDTO: Decodable {
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

extension MovieInfoDTO {
    func toDomain() -> MovieInfoModel {
        MovieInfoModel(movieCode: self.movieCd,
                       movieName: self.movieNm,
                       showTime: self.showTm,
                       productYear: self.prdtYear,
                       openDate: self.openDt,
                       nations: self.nations.map { $0.toDomain() },
                       genres: self.genres.map { $0.toDomain() },
                       directors: self.directors.map { $0.toDomain() },
                       audits: self.audits.map { $0.toDomain() },
                       actors: self.actors.map { $0.toDomain() })
    }
}

struct NationDTO: Decodable {
    let nationNm: String
}

extension NationDTO {
    func toDomain() -> NationModel {
        NationModel(nationName: self.nationNm)
    }
}

struct GenreDTO: Decodable {
    let genreNm: String
}

extension GenreDTO {
    func toDomain() -> GenreModel {
        GenreModel(genreName: self.genreNm)
    }
}

struct DirectorDTO: Decodable {
    let peopleNm: String
}

extension DirectorDTO {
    func toDomain() -> DirectorModel {
        DirectorModel(peopleName: self.peopleNm)
    }
}

struct ActorDTO: Decodable {
    let peopleNm: String
}

extension ActorDTO {
    func toDomain() -> ActorModel {
        ActorModel(peopleName: self.peopleNm)
    }
}

struct AuditDTO: Decodable {
    let watchGradeNm: String
}

extension AuditDTO {
    func toDomain() -> AuditModel {
        AuditModel(watchGradeName: self.watchGradeNm)
    }
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
