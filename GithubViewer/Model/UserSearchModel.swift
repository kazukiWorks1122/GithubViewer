//
//  UserSearchModel.swift
//  GithubViewer
//
//  Created by 酒井一樹 on 2022/04/20.
//

import Foundation

protocol UserSearchModelInput {
    // ユーザー一覧取得
    func fetchUserList(query: String, completion: @escaping (Result<[UserInfoModel]>) -> Void)
}

/*
 ユーザー検索画面モデル
 */
final class UserSearchModel: UserSearchModelInput {
    // Githubからユーザー一覧を取得
    func fetchUserList(query: String, completion: @escaping (Result<[UserInfoModel]>) -> Void) {
        let request = SearchUsersRequest(query: query)

        // APIを実行
        APIClient.shared.call(request) { result in
            switch result {
            // 成功
            case .success(let response):
                completion(.success(response.items))
            // 失敗
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
