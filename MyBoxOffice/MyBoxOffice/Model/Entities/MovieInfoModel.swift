//
//  MovieInfoModel.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/11.
//

struct MovieInfoModel {
    let movieCode: String
    let movieName: String
    let showTime: String
    let productYear: String
    let openDate: String
    let nations: [NationModel]
    let genres: [GenreModel]
    let directors: [DirectorModel]
    let audits: [AuditModel]
    let actors: [ActorModel]
    
    var nationsNames: String {
        nations
            .map { $0.nationName }
            .joined(separator: ",")
    }
    
    var genresNames: String {
        genres
            .map { $0.genreName }
            .joined(separator: ",")
    }
    
    var directorsNames: String {
        directors
            .map { $0.peopleName }
            .joined(separator: ",")
    }
    
    var watchGradeNames: String {
        audits
            .map { $0.watchGradeName }
            .joined(separator: ",")
    }
    
    var actorsNames: String {
        actors
            .map { $0.peopleName }
            .joined(separator: ",")
    }
}

struct NationModel {
    let nationName: String
}

struct GenreModel {
    let genreName: String
}

struct DirectorModel {
    let peopleName: String
}

struct AuditModel {
    let watchGradeName: String
}

struct ActorModel {
    let peopleName: String
}
