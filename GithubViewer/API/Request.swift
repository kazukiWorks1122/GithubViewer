//
//  Request.swift
//  GithubViewer
//
//  Created by 酒井一樹 on 2022/04/19.
//

import Alamofire
import Foundation

/*
 APIリクエスト定義
 */
protocol Request {
    associatedtype Response: Decodable

    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var headerFields: HTTPHeaders { get }
    var queryParameters: [String: String]? { get }
}

extension Request {
    var baseURL: String {
        return Constant.baseURL
    }

    var headerFields: HTTPHeaders {
        return ["Accept": "application/json"]
    }

    var queryParameters: [String: String]? {
        return nil
    }
}
