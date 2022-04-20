//
//  UserSearchPresenter.swift
//  GithubViewer
//
//  Created by 酒井一樹 on 2022/04/20.
//

import Foundation

/*
 ユーザー検索画面Presenter - 入力
 */
protocol UserSearchPresenterInput {
    // ユーザー数取得
    var userListCount: Int { get }
    // ユーザー情報取得
    func getUserInfo(forRow row: Int) -> UserInfoModel?
    // テーブルセルタップ時の処理
    func didSelectRow(at indexPath: IndexPath)
    // 検索バーで検索実行時の処理
    func didSearchBarInput(text: String?)
}
/*
 ユーザー検索画面Presenter - 出力
 */
protocol UserSearchPresenterOutput: AnyObject {
    func updateUserList(_ userList: [UserInfoModel])
    func transitionToUserInfo(url: String)
}

/*
 ユーザー検索画面Presenter
 */
final class UserSearchPresenter: UserSearchPresenterInput {
    private(set) var userList: [UserInfoModel] = []
    private var view: UserSearchPresenterOutput
    private var model: UserSearchModelInput

    // 初期設定
    init(view: UserSearchPresenterOutput, model: UserSearchModelInput) {
        self.view = view
        self.model = model
    }

    // 一覧のユーザー数を取得
    var userListCount: Int {
        return userList.count
    }

    // ユーザー情報を取得
    func getUserInfo(forRow row: Int) -> UserInfoModel? {
        guard row < userList.count else { return nil }
        return userList[row]
    }

    // テーブルセルタップ時の処理
    func didSelectRow(at indexPath: IndexPath) {
        guard let user = getUserInfo(forRow: indexPath.row) else { return }
        view.transitionToUserInfo(url: user.htmlUrl)
    }

    // 検索バーで検索実行時の処理
    func didSearchBarInput(text: String?) {
        guard let query = text else { return }
        guard !query.isEmpty else { return }

        // Githubからユーザー一覧を取得
        model.fetchUserList(query: query) { [weak self] result in
            switch result {
            // 成功
            case .success(let users):
                self?.userList = users
                // 非同期で設定する
                DispatchQueue.main.async {
                    self?.view.updateUserList(users)
                }
            // 失敗
            case .failure(let error):
                print(error)
                ()
            }
        }
    }
}
