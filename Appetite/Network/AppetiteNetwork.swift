//
//  AppetiteNetwork.swift
//  Appetite
//
//  Created by Kenny Meyers on 12/2/24.
//

import Foundation
import OSLog


actor AppetiteNetwork {
    private let logger = Logger(subsystem: "com.kennymeyers.AppetiteData", category: "NetworkFetcher")
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetch<T: Decodable>(endpoint: Endpoint) async throws -> T {
        logger.trace("Fetching data from \(endpoint.url?.absoluteString ?? "")")

        guard let url = endpoint.url else {
            logger.error("URL for fetch is invalid")
            throw AppetiteDataError.invalidURL
        }

        async let (data, urlResponse) = try await session.data(from: url)

        guard let response = try await urlResponse as? HTTPURLResponse else {
            throw AppetiteDataError.httpRequestError
        }

        // Should be its own class for reuse but for expediency capture
        // it here
        switch response.statusCode  {
        case 200..<300:
            return try await JSONDecoder().decode(T.self, from: data)
        default:
            logger.error("Failed to fetch data from \(url.absoluteString)")
            throw AppetiteDataError
                .httpError(
                    statusCode: response.statusCode,
                    url: response.url?.absoluteString ?? ""
                )
        }
    }
}
