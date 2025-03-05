//
//  RAndMModel.swift
//  testApi
//
//  Created by Михаил Ганин on 19.02.2025.
//

import Foundation

struct RAndMModel : Codable {
    let info : Info?
    let results : [Results]?

    enum CodingKeys: String, CodingKey {

        case info = "info"
        case results = "results"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        info = try values.decodeIfPresent(Info.self, forKey: .info)
        results = try values.decodeIfPresent([Results].self, forKey: .results)
    }


}
