//
//  Recipe.swift
//  Appetite
//
//  Created by Kenny Meyers on 12/2/24.
//

import Foundation

struct Recipe: Codable {
    let cuisine: String
    let name: String
    let photo: URL?
    let thumbnail: URL?
    let uuid: String
    let sourceURL: URL?
    let youtubeURL: URL?

    enum CodingKeys: String, CodingKey {
        case cuisine
        case name
        case photo = "photo_url_large"
        case thumbnail = "photo_url_small"
        case uuid
        case sourceURL
        case youtubeURL
    }

    public var flag: String? {
        Cuisine(rawValue: cuisine.lowercased())?.flag
    }
}

extension Recipe: Identifiable, Hashable, Equatable {
    public var id: String {
        uuid
    }
}
