//
//  NaverImageDTO.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/12.
//

struct NaverImageDTO: Decodable {
    let items: [NaverImageItem]
}

struct NaverImageItem: Decodable {
    let link: String
}
