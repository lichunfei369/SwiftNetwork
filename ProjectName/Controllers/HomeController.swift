//
//  HomeController.swift
//  ProjectName
//
//  Created by 李春菲 on 2025/1/2.
//

import UIKit

class HomeController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let target:ApiTarget = .getCountries
        NetworkManager.shared.getCountries(target) { result in
            switch result {
            case .success(let countries):
                print(countries)
            case .failure(let error):
                print(error)
            }
        }
        
    }
}
