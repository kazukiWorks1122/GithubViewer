//
//  SearchUsersResponse.swift
//  GithubViewer
//
//  Created by 酒井一樹 on 2022/04/21.
//

import Foundation

/*
 Githubユーザー検索API用レスポンス
 */
struct SearchUsersResponse<Item: Decodable>: Decodable {
    let items: [Item]

    init(items: [Item]) {
        self.items = items
    }
}
