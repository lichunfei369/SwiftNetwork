//
//  HomeMdeols.swift
//  ProjectName
//
//  Created by 李春菲 on 2025/1/2.
//

import Foundation

struct Countries: Codable {
    let name: HomeResult
    let population: Int
}

struct HomeResult: Codable {
    let commonName: String
    let officailName: String
}
