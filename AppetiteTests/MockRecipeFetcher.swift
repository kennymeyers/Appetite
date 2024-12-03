//
//  MockRecipeTest.swift
//  Appetite
//
//  Created by Kenny Meyers on 12/2/24.
//

@testable import Appetite
import Foundation

struct MockRecipeFetcher: RecipeFetcher {
    var endpoint: Endpoint
    func fetchRecipes() async throws -> [Appetite.Recipe] {
        switch endpoint {
        case .all:
            return [
                Recipe(
                    cuisine: "Bill",
                    name: "Bill",
                    photo: nil,
                    thumbnail: nil,
                    uuid: UUID().uuidString,
                    sourceURL: nil,
                    youtubeURL: nil
                )]
        default:
            return []
        }
    }


}
