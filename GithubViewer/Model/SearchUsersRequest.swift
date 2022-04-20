//
//  SearchUsersRequest.swift
//  GithubViewer
//
//  Created by 酒井一樹 on 2022/04/19.
//

import Alamofire
import Foundation

/*
 Githubユーザー検索API用リクエスト
 */
struct SearchUsersRequest: Request {
    typealias Response = SearchUsersResponse<UserInfoModel>

    let method: HTTPMethod = .get
    let path = "/search/users"

    var queryParameters: [String: String]? {
        let params: [String: String] = ["q": query]
        return params
    }

    let query: String

    init(query: String) {
        self.query = query
    }
}
