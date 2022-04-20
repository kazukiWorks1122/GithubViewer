//
//  UserSearchViewController.swift
//  GithubViewer
//
//  Created by 酒井一樹 on 2022/04/19.
//

import DZNEmptyDataSet
import UIKit

/*
 Githubユーザー検索画面コントローラ
 */
class UserSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, DZNEmptyDataSetSource, UserSearchPresenterOutput {

    // MARK: - IBOutlet

    // 検索バー
    @IBOutlet weak private var searchBar: UISearchBar!
    // テーブルビュー
    @IBOutlet weak private var tableView: UITableView!

    // MARK: - private

    // ユーザー検索画面Presenter
    private var presenter: UserSearchPresenterInput!

    // MARK: - viewLifeCycle

    // 画面の初期表示処理
    override func viewDidLoad() {
        super.viewDidLoad()
        // ユーザー検索画面Presenterを設定
        presenter = UserSearchPresenter(view: self, model: UserSearchModel())
        // カスタムテーブルビューセルを設定
        tableView.register(UserInfoListCell.self)
        // テーブルビューが空の時の設定
        self.tableView.emptyDataSetSource = self
    }

    // MARK: - UISearchBarDelegate

    // 編集開始時の処理
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // キャンセルボタンを表示
        searchBar.showsCancelButton = true
        return true
    }

    // キャンセルボタン選択時の処理
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // キャンセルボタンを非表示に変更
        searchBar.showsCancelButton = false
        // キーボードを下げる
        searchBar.resignFirstResponder()
    }

    // 検索実行時の処理
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // キーボードを下げる
        searchBar.resignFirstResponder()
        presenter.didSearchBarInput(text: searchBar.text)
    }

    // MARK: - UITableViewDataSource

    // テーブルビューセルの数を取得
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.userListCount
    }

    // テーブルビューセルを設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 取得したユーザー情報をセルに反映する
        let cell: UserInfoListCell = tableView.dequeueReusableCell(for: indexPath)
        guard let userInfo = presenter.getUserInfo(forRow: indexPath.row) else { return cell }
        cell.configure(user: userInfo)
        return cell
    }

    // MARK: - UITableViewDelegate

    // テーブルビューセルがタップされた時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelectRow(at: indexPath)
    }

    // MARK: - DZNEmptyDataSetSource

    // テーブルビューに何もない時
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "表示するデータがありません"
        let attributes: [NSAttributedString.Key: Any]
            = [.font: UIFont.boldSystemFont(ofSize: 19),
               .foregroundColor: UIColor.blue]

        return NSAttributedString(string: text, attributes: attributes)
    }

    // MARK: - UserSearchPresenterOutput

    // テーブルを更新
    func updateUserList(_ userList: [UserInfoModel]) {
        tableView.reloadData()
    }

    // ユーザー情報画面へ遷移
    func transitionToUserInfo(url: String) {
        let view = UserInfoViewController.instantiate(type: UserInfoViewController.self)
        let presenter = UserInfoPresenter(url: url, view: view)
        view.inject(presenter: presenter)
        navigationController?.pushViewController(view, animated: true)
    }
}
