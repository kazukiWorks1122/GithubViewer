//
//  UserInfoModel.swift
//  GithubViewer
//
//  Created by 酒井一樹 on 2022/04/19.
//

import Foundation

/*
 ユーザー情報モデル
 */
struct UserInfoModel: Codable {
    let login: String      // ユーザー名
    let id: Int            // ID
    let avatarURL: URL     // アイコン画像
    let htmlUrl: String    // ユーザーページURL
    let type: String       // ユーザー種別

    // JSONのキーを定義
    private enum CodingKeys: String, CodingKey {
        case login
        case id
        case avatarURL = "avatar_url"
        case htmlUrl = "html_url"
        case type
    }

    // 初期設定
    init(login: String, id: Int, avatarURL: URL, htmlUrl: String, type: String) {
        self.login = login
        self.id = id
        self.avatarURL = avatarURL
        self.htmlUrl = htmlUrl
        self.type = type
    }
}
