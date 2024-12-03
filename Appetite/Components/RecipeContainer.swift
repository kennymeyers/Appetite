//
//  RecipeContainer.swift
//  Appetite
//
//  Created by Kenny Meyers on 12/2/24.
//
import SwiftUI
import NukeUI

struct RecipeContainer: View {
    @State private var showPopover = false
    let recipe: Recipe
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            if let image = recipe.photo {
                GeometryReader { geo in
                    LazyImage(
                        url: image,
                        transaction: Transaction(animation: .spring)
                    ) { state in
                        if let image = state.image {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: geo.size.width, height: geo.size.height)

                        } else {
                            Rectangle()
                                .foregroundStyle(.regularMaterial)
                        }
                    }

                    .overlay {
                        HStack(spacing: 4) {
                            Text(recipe.name)
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text(recipe.flag ?? recipe.cuisine)
                                .font(.system(size: recipe.flag == nil ? 12 : 40))
                                .frame(alignment: .trailing)
                                .onTapGesture {
                                    // We are showing the text anyway
                                    guard recipe.flag != nil else { return }
                                    showPopover.toggle()
                                }
                                .popover(isPresented: $showPopover) {
                                    Text(recipe.cuisine)
                                        .font(.body)
                                        .padding()
                                        .presentationCompactAdaptation(.popover)
                                        .presentationBackground(.regularMaterial)
                                }
                        }

                        .padding()
                        .background(.regularMaterial)
                        .frame(
                            maxHeight: .infinity,
                            alignment: .bottomLeading
                        )
                    }

                }
                .aspectRatio(1, contentMode: .fill)
            }
        }
        .clipShape(.rect(cornerRadius: 4))
        .shadow(radius: 6)
    }
}
