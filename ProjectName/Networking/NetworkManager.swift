//
//  NetworkManager.swift
//  ProjectName
//
//  Created by 李春菲 on 2025/1/2.
//

import Foundation


final class NetworkManager {
    static let shared = NetworkManager()
    
    // （无带参数的请求示例）
    func getCountries(_ target: ApiTarget, completion: @escaping (Result<[Countries], NetworkError>) -> Void) {
        request(target, completion: completion)
    }
    
    // （带参数的请求示例）
    func submitForm(_ target: ApiTarget, completion: @escaping (Result<String, NetworkError>) -> Void) {
        request(target, completion: completion)
    }
    
    private func request<T: Codable>(_ target: ApiTarget, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: target.baseUrl)?.appendingPathComponent(target.path) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = target.httpMethod.rawValue
        
        switch target.task {
        case .requestPlain:
            break // 无参数请求
        case .requestParameters(let parameters):
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
                request.httpBody = jsonData
            } catch {
                completion(.failure(.parsingError))
                return
            }
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestError(error)))
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200..<299).contains(response.statusCode) else {
                completion(.failure(.responseError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noDataRecieved))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch let decodingError as DecodingError {
                completion(.failure(.decodingError(decodingError)))
            } catch {
                completion(.failure(.parsingError))
            }
        }
        task.resume()
    }
}
