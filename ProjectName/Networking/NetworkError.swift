//
//  NetworkError.swift
//  ProjectName
//
//  Created by 李春菲 on 2025/1/2.
//

import Foundation

enum NetworkError: Error {
    // 无效 URL
    case invalidURL
    // 没有数据返回
    case noDataRecieved
    // 参数序列化失败
    case parsingError
    // JSON 解码失败
    case decodingError(DecodingError)
    //HTTP 响应码不正确
    case responseError
    // 网络请求错误
    case requestError(Error)
}
