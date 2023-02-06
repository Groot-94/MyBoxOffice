//
//  MockNetworkData.swift
//  BoxOfficeDecodeTests
//
//  Created by Groot on 2023/02/06.
//

import Foundation

struct MockNetworkData {
    let data: Data?
    
    init(fileName: String) {
        let location = Bundle.main.url(forResource: fileName, withExtension: "json")
        self.data = try? Data(contentsOf: location!)
    }
}
