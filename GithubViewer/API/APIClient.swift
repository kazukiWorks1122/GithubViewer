//
//  APIClient.swift
//  GithubViewer
//
//  Created by 酒井一樹 on 2022/04/21.
//

import Alamofire
import Foundation

struct APIClient {
    // シングルトン
    static var shared = APIClient()

    // API実行
    func call<T: Request>(_ request: T, completion: @escaping (Result<T.Response>) -> Void) {
        let url = request.baseURL + request.path
        let method = request.method
        let parameters = request.queryParameters
        let headerFields = request.headerFields

        // AlamofireでAPIを実行
        AF.request(url, method: method, parameters: parameters, encoding: URLEncoding.default, headers: headerFields)
            .validate(statusCode: 200..<300)    // HTTPステータスコードが200番台はOK
            .responseDecodable(of: T.Response.self) { response in   // 自動でデコードしてくれる
                switch response.result {
                // 成功
                case .success(let data):
                    completion(.success(data))
                // 失敗
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
