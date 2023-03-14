//
//  ViewController.swift
//  Countries
//
//  Created by Kristiyan Kornazov on 14.03.23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        APIClient.shared.getCharacters { [weak self] result in
            print(result)
        }
        // Do any additional setup after loading the view.
    }


}

