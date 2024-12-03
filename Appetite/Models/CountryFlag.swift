//
//  Flags.swift
//  Appetite
//
//  Created by Kenny Meyers on 12/2/24.
//

enum Cuisine: String, Codable {
    case american,
        british,
        french,
        italian,
        german,
        spanish,
        thai,
        japanese,
        canadian,
        chinese,
        indian,
        malaysian,
         tunisian,
         greek

    var flag: String {
        switch self {
        case .american: "🇺🇸"
        case .british: "🇬🇧"
        case .french: "🇫🇷"
        case .italian: "🇮🇹"
        case .german: "🇩🇪"
        case .spanish: "🇪🇸"
        case .thai: "🇹🇭"
        case .japanese: "🇯🇵"
        case .canadian: "🇨🇦"
        case .chinese: "🇨🇳"
        case .indian: "🇮🇳"
        case .malaysian: "🇲🇾"
        case .greek: "🇬🇷"
        case .tunisian: "🇹🇳"
        }
    }

}
