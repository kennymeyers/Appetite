//
//  RecipeListing.swift
//  Appetite
//
//  Created by Kenny Meyers on 12/2/24.
//

import NukeUI
import OSLog
import SwiftUI

@MainActor
class RecipeListingViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var recipeState: RecipeResponseState = .unknown
    private let recipeFetcher: RecipeFetcher
    private let logger = Logger()

    init(recipeFetcher: RecipeFetcher = AppetiteRecipeFetcher()) {
        self.recipeFetcher = recipeFetcher
    }


    func fetchRecipes() async {
        async let recipes: [Recipe] = recipeFetcher.fetchRecipes()

        do {
            let recipes = try await recipes
            self.recipes = recipes
            recipeState = recipes.count > 0 ? .normal : .empty
        } catch let error {
            logger.error("\(error)")
            recipeState = .error
        }
    }

    var textForContentUnvailable: String {
        switch recipeState {
        case .empty:
            "No Recipes Found"
        case .error:
            "Error Fetching Recipes"
        default:
            "Loading Recipes..."
        }
    }

    var imageForContentUnavailable: String {
        switch recipeState {
        case .normal:
            "list.bullet.rectangle"
        case .empty:
            "list.bullet.rectangle.fill"
        case .error:
            "exclamationmark.triangle"
        case .unknown:
            "questionmark.circle"
        }
    }
}

struct RecipeListing: View {
    @ObservedObject var viewModel = RecipeListingViewModel()

    var body: some View {
        NavigationStack {
            if viewModel.recipeState != .normal,
                viewModel.recipeState != .unknown
            {
                if #available(iOS 17.0, *) {
                    ContentUnavailableView(
                        viewModel.textForContentUnvailable,
                        image: viewModel.textForContentUnvailable
                    )

                    .transition(.move(edge: .bottom))
                } else {
                    VStack(spacing: 0) {
                        Image(systemName: viewModel.imageForContentUnavailable)
                        Text(viewModel.textForContentUnvailable)
                    }
                    .transition(.opacity)
                }

            } else {
                List {
                    ForEach(viewModel.recipes) {
                        RecipeContainer(recipe: $0)
                    }
                    .listRowSeparator(.hidden)
                    .listRowInsets(
                        .init(top: 8, leading: 16, bottom: 8, trailing: 16)
                    )
                }
                .scrollContentBackground(.hidden)
                .transition(.opacity)

            }
        }
        .animation(.spring, value: viewModel.recipeState)
        .refreshable {
            viewModel.recipes.removeAll()
            await viewModel.fetchRecipes()
        }
        .task {
            await viewModel.fetchRecipes()
        }
    }
}

#Preview {
    RecipeListing()
}
