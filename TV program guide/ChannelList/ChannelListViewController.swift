//
//  ChannelListViewController.swift
//  TV program guide
//
//  Created by Александр on 18.01.2022.
//

import UIKit

class ChannelListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.shared.fetchData { response in
            switch response {
            case .success(let tvProram):
                print(tvProram)
            case .failure(let error):
                print(error)
            }
        }
        // Do any additional setup after loading the view.
    }
}

