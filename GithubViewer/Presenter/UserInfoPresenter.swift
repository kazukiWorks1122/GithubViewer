//
//  UserInfoPresenter.swift
//  GithubViewer
//
//  Created by 酒井一樹 on 2022/04/20.
//

import Foundation

/*
 ユーザー情報表示画面Presenter - 入力
 */
protocol UserInfoPresenterInput {
    // Webビューロード呼び出し
    func loadWebView()
}
/*
 ユーザー情報表示画面Presenter - 出力
 */
protocol UserInfoPresenterOutput: AnyObject {
    // Webビューロード
    func loadWebView(_ url: String)
}

/*
 ユーザー情報表示画面Presenter
 */
final class UserInfoPresenter: UserInfoPresenterInput {
    private var view: UserInfoPresenterOutput
    private var url: String

    // 初期設定
    init(url: String, view: UserInfoPresenterOutput) {
        self.url = url
        self.view = view
    }

    // Webビューをロードする
    func loadWebView() {
        view.loadWebView(url)
    }
}
