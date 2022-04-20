//
//  UserInfoViewController.swift
//  GithubViewer
//
//  Created by 酒井一樹 on 2022/04/19.
//

import UIKit
import WebKit

/*
 Githubユーザー情報表示画面コントローラ
 */
final class UserInfoViewController: UIViewController, UserInfoPresenterOutput {

    // MARK: - private

    // ユーザー情報画面Presenter
    private var presenter: UserInfoPresenterInput?

    // WKWebViewを定義
    private let webView = WKWebView()

    // MARK: - public func

    // Presenterの挿入
    func inject(presenter: UserInfoPresenter) {
        self.presenter = presenter
    }

    // MARK: - viewLifeCycle

    // 画面表示時の処理
    override func viewDidLoad() {
        super.viewDidLoad()
        // 画面の初期表示時にWebビューをロード
        if let presenter = self.presenter {
            presenter.loadWebView()
        }
    }

    // MARK: - UserInfoPresenterOutput

    // Webビューをロードする
    func loadWebView(_ url: String) {
        // webViewの大きさを画面全体にして表示
        webView.frame = view.frame
        view.addSubview(webView)
        // URLを指定してロードする
        guard let url = URL(string: url) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
