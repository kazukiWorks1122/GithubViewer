//
//  UIViewController.swift
//  Github Viewer
//
//  Created by 酒井一樹 on 2022/04/20.
//

import UIKit

extension UIViewController {
    static func instantiate<T: UIViewController>(type: T.Type) -> T {
        let className = String(describing: T.self)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: className) as! T
    }
}
