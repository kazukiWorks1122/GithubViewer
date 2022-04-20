//
//  NibFactory.swift
//  GithubViewer
//
//  Created by 酒井一樹 on 2022/04/21.
//
// powered by https://qiita.com/gonsee/items/9ab89581996ad950b436

import Foundation
import UIKit

/// UINibのファクトリー
public protocol NibFactory { }

public extension NibFactory where Self: UIViewController {
    /// UIViewController用のUINibを生成する
    static func createWithNib() -> Self {
        return Self(nibName: String(describing: self), bundle: Bundle(for: self))
    }
}

public extension NibFactory where Self: UIView {
    /// UIView用のUINibを生成する
    static func createNib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
    /// UIView用のUINibを生成する
    static func createWithNib() -> Self {
        return createNib().instantiate(withOwner: self, options: nil).first as! Self
    }
}

extension UIViewController: NibFactory { }
extension UIView: NibFactory { }
