//
//  RecipeFetcher.swift
//  Appetite
//
//  Created by Kenny Meyers on 12/2/24.
//

import Foundation
import OSLog

protocol RecipeFetcher {
    func fetchRecipes() async throws -> [Recipe]
}


final class AppetiteRecipeFetcher: RecipeFetcher {
    let network = AppetiteNetwork()
    private let logger = Logger(
        subsystem: "RecipeFetcher",
        category: "com.kennymeyers.Appetite"
    )

    func fetchRecipes() async throws -> [Recipe]  {
        async let recipeResponse: RecipeResponse = network.fetch(
            endpoint: .all
        )
        do {
            return try await recipeResponse.recipes
        } catch let error {
            logger.error("\(error)")
            return []
        }
    }
}
