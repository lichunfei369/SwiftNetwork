//
//  ApiTarget.swift
//  ProjectName
//
//  Created by 李春菲 on 2025/1/2.
//

import Foundation

protocol ApiTargetType {
    var baseUrl: String { get }
    var path: String { get }
    var httpMethod: HttpMethod { get }
    var headers: [String:String]? { get }
    var task: Task { get }
}

enum Task {
    // 无参数的请求
    case requestPlain
    // 带参数的请求
    case requestParameters([String: Any])
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put =  "PUT"
    case delete = "DELETE"
}

enum ApiTarget: ApiTargetType {

    case getCountries
    case submitForm(parameters: [String: Any])
    
    var baseUrl: String {
        switch self {
        case .getCountries:
            return "https://restcountries.eu/rest/v2/"
        case .submitForm:
            return "https://example.com/api/"
        
        }
    }
    
    var path: String {
        switch self {
        case .getCountries:
            return "all"
        case .submitForm:
            return "submit"
        }
    }
    
    var httpMethod: HttpMethod {
        switch self {
        case .getCountries:
            return .get
        case .submitForm:
            return .post 
            
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getCountries:
            return nil
        case .submitForm:
             return ["Content-Type": "application/json"]
        }
    }


    var task: Task {
    switch self {
    case .getCountries:
        return .requestPlain
    case .submitForm(let parameters):
        return .requestParameters(parameters)
    }
}
    
}
