//
//  NaverMovieDTO.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/13.
//

struct NaverMovieDTO: Decodable {
    let items: [MovieItemDTO]
}

struct MovieItemDTO: Decodable {
    let title: String
    let image: String
    let director: String
    let userRating: String
}

extension MovieItemDTO {
    func toDomain() -> NaverMovieModel {
        NaverMovieModel(title: self.title,
                        imageUrl: self.image,
                        director: self.director,
                        userRating: self.userRating)
    }
}
