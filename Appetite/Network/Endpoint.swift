//
//  Endpoint.swift
//  Appetite
//
//  Created by Kenny Meyers on 12/2/24.
//

import Foundation


enum Endpoint {
    case all, malformed, empty

    var url: URL? {
        switch self {
        case .all:
            URL(
                string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")
        case .malformed:
            URL(
                string:
                    "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
            )
        case .empty:
            URL(
                string:
                    "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")
        }
    }
}
