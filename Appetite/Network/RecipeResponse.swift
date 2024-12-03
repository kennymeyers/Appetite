//
//  RecipeResponse.swift
//  Appetite
//
//  Created by Kenny Meyers on 12/2/24.
//

import Foundation

struct RecipeResponse: Codable {
    let recipes: [Recipe]

    // If we have malformed JSON, but still some valid recipes, we have to do some decoding crap
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        var recipeContainer = try container.nestedUnkeyedContainer(
            forKey: .recipes)
        var recipes: [Recipe] = []

        while !recipeContainer.isAtEnd {

            if let recipe = try? recipeContainer.decode(Recipe.self) {
                recipes.append(recipe)
            } else {
                _ = try? recipeContainer.superDecoder()
            }
        }

        self.recipes = recipes
    }
}
