//
//  MovieSearchListDTO.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/14.
//

struct MovieSearchListDTO: Decodable {
    let movieListResult: MovieListResultDTO
}

struct MovieListResultDTO: Decodable {
    let movieList: [MovieListDTO]
}

struct MovieListDTO: Decodable {
    let movieCd: String
}
