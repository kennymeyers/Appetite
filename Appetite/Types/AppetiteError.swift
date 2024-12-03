//
//  AppetiteError.swift
//  Appetite
//
//  Created by Kenny Meyers on 12/2/24.
//


enum AppetiteDataError: Error {
    case invalidURL
    case httpRequestError
    case httpError(statusCode: Int, url: String)
}
