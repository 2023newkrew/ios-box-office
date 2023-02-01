//
//  ViewController.swift
//  BoxOffice
//
//  Created by kakao on 2023/01/19.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let networkManager = NetworkManager()
        let url = networkManager.apiURL(api: .dailyBoxOffice, yyyyMMdd: "20230130")
        networkManager.load(url: url) { data in
            dump(data)
        }
        // Do any additional setup after loading the view.
    }
    
}
