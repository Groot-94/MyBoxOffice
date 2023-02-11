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
    let typeName: String
    let nations: [NationModel]
    let genresName: [GenreModel]
    let directors: [DirectorModel]
    let actors: [ActorModel]
}

struct NationModel {
    let nationName: String
}

struct GenreModel {
    let genreName: String
}

struct DirectorModel {
    let peopleNm: String
}

struct ActorModel {
    let peopleNm: String
}
