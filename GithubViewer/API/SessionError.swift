//
//  SessionError.swift
//  GithubViewer
//
//  Created by 酒井一樹 on 2022/04/21.
//

import Foundation

enum SessionError: Error {
    case noData(HTTPURLResponse)
    case noResponse
    case unacceptableStatusCode(Int, Message?)
    case failedToCreateComponents(URL)
    case failedToCreateURL(URLComponents)
}

extension SessionError {
    struct Message: Decodable {
        let documentationURL: URL
        let message: String

        private enum CodingKeys: String, CodingKey {
            case documentationURL = "documentation_url"
            case message
        }
    }
}
