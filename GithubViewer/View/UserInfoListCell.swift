//
//  UserInfoListCell.swift
//  GithubViewer
//
//  Created by 酒井一樹 on 2022/04/19.
//

import UIKit

/*
 ユーザー一覧テーブルビューセル
 */
@IBDesignable
class UserInfoListCell: UITableViewCell, NibRegistrable {
    // セッションタスク(アイコン画像取得用)
    private var task: URLSessionTask?

    @IBOutlet weak private var icon: UIImageView!   // アイコン画像
    @IBOutlet weak private var name: UILabel!       // ユーザー名
    @IBOutlet weak private var type: UILabel!       // ユーザー種別(USER:個人,Organization:組織)

    // セルの初期化処理
    override func prepareForReuse() {
        super.prepareForReuse()

        task?.cancel()
        task = nil
        imageView?.image = nil
    }

    // ユーザー情報をセルに反映する
    func configure(user: UserInfoModel) {
        // 画像URLからユーザー画像を取得して表示
        task = {
            let url = user.avatarURL
            // URLから画像を非同期で取得する
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let imageData = data else {
                    return
                }
                DispatchQueue.global().async { [weak self] in
                    guard let image = UIImage(data: imageData) else { return }
                    DispatchQueue.main.async {
                        // アイコン画像に反映
                        self?.icon?.image = image
                        self?.setNeedsLayout()
                    }
                }
            }
            task.resume()
            return task
        }()

        // ユーザー名とユーザー種別を設定
        name.text = user.login
        type.text = user.type
    }
}
