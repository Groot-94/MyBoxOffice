//
//  NaverMovieModel.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/13.
//

import UIKit

struct NaverMovieModel {
    let title: String
    let imageUrl: String
    let director: String
    let userRating: String
    
    var movieName: String {
        title.replacingOccurrences(of: "<b>", with: "")
            .replacingOccurrences(of: "</b>", with: "")
    }
}
