//
//  RecipeState.swift
//  Appetite
//
//  Created by Kenny Meyers on 12/2/24.
//

@frozen
public enum RecipeResponseState: CaseIterable {
    case empty, error, normal, unknown
}
