//
//  AppetiteTests.swift
//  AppetiteTests
//
//  Created by Kenny Meyers on 12/2/24.
//

import Testing
@testable import Appetite

struct AppetiteDataNetworkTests {
    let network = AppetiteNetwork()

    @Test("Correctly fetches recipes") func fetchRecipes() async throws {
        let recipeResponse: RecipeResponse = try await network.fetch(endpoint: .all)
        #expect(recipeResponse.recipes.count > 0)
    }

    @Test("Throws a decodable error with malformed data") func malformedData() async throws {
        await #expect(throws: DecodingError.self) {
           let _: [Recipe] = try await network.fetch(endpoint: .malformed)
        }
    }

    @Test("Handles empty recipes just fine") func fetchEmptyRecipe() async throws {
        await #expect(throws: DecodingError.self) {
            let _: [Recipe] = try await network.fetch(endpoint: .empty)
        }
    }
}
