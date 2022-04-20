//
//  Result.swift
//  GithubViewer
//
//  Created by 酒井一樹 on 2022/04/19.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}
