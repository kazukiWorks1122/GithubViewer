//
//  UITableView+Registrable.swift
//  GithubViewer
//
//  Created by 酒井一樹 on 2022/04/21.
//
// powered by https://qiita.com/gonsee/items/9ab89581996ad950b436

import Foundation
import UIKit

public protocol Registrable: AnyObject {
    // reuseIdentifierはデフォルトでクラス名を返すようにする
    static var reuseIdentifier: String { get }
}

public extension Registrable {
    /// NibのIDを取得する
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

public protocol ClassRegistrable: Registrable { }

public protocol NibRegistrable: Registrable {
    static var nib: UINib { get }
}

public extension NibRegistrable where Self: UIView {
    /// UINibを生成する
    static var nib: UINib {
        return Self.createNib()
    }
}

public extension UITableView {
    /// テーブルビューにカスタムセルを登録する
    func register<T: Registrable>(_ registrableType: T.Type) where T: UITableViewCell {
        switch registrableType {
        case let nibRegistrableType as NibRegistrable.Type:
            register(nibRegistrableType.nib, forCellReuseIdentifier: nibRegistrableType.reuseIdentifier)
        case let classRegistrableType as ClassRegistrable.Type:
            register(classRegistrableType, forCellReuseIdentifier: classRegistrableType.reuseIdentifier)
        default:
            assertionFailure("\(registrableType) is unknown type")
        }
    }
    /// テーブルビューに登録されたカスタムセルを取得する
    func dequeueReusableCell<T: Registrable>(for indexPath: IndexPath) -> T where T: UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with type \(T.self)")
        }
        return cell
    }
}
