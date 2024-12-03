//
//  RecipeListingViewModelTests.swift
//  Appetite
//
//  Created by Kenny Meyers on 12/2/24.
//
import Testing
@testable import Appetite

@MainActor
struct RecipeListingViewModelTests {

    @Test(
        "shows the correct title based on the response state",
        arguments: RecipeResponseState.allCases
    )

    func titleTest(type: RecipeResponseState) async {
        let viewModel = RecipeListingViewModel()

        viewModel.recipeState = type
        let text = viewModel.textForContentUnvailable
        switch  type {
        case .empty:
            #expect(text == "No Recipes Found")
        case .error:
            #expect(text == "Error Fetching Recipes")
        default:
            #expect(text == "Loading Recipes...")

        }
    }

    @Test("shows the correct image based on the response state",
          arguments: RecipeResponseState.allCases
    )
    func imageTest(type: RecipeResponseState) async {
        let viewModel = RecipeListingViewModel()
        viewModel.recipeState = type
        let text = viewModel.imageForContentUnavailable

        switch type {
        case .normal:
            #expect(text == "list.bullet.rectangle")
        case .empty:
            #expect(text == "list.bullet.rectangle.fill")
        case .error:
            #expect(text == "exclamationmark.triangle")
        case .unknown:
            #expect(text == "questionmark.circle")
        }
    }

    @Test("if it fails to get the recipes it changes the state to error")
    func errorStateTest() async throws {
        
        let viewModel = RecipeListingViewModel(
            recipeFetcher: MockRecipeFetcher(endpoint: .malformed)
        )
        await viewModel.fetchRecipes()
        #expect(viewModel.recipeState == .empty)
    }

    @Test("if it grabs the receipes it changes the state to normal")
    func normalStateTest() async throws {
        let viewModel = RecipeListingViewModel(
            recipeFetcher: MockRecipeFetcher(endpoint: .all)
        )
        await viewModel.fetchRecipes()
        #expect(viewModel.recipeState == .normal)
    }

    @Test("if it grabs the receipes, and they're malformed, it still takes what it can get")
    func malformedStateTest() async throws {
        let viewModel = RecipeListingViewModel(
            recipeFetcher: MockRecipeFetcher(endpoint: .malformed)
        )
        await viewModel.fetchRecipes()
        #expect(viewModel.recipeState == .normal)
    }
}
