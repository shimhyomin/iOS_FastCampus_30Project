//
//  SeguePushViewController.swift
//  UINavigationController_EX
//
//  Created by shm on 2021/09/24.
//

import UIKit

class SeguePushViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let name = name {
            nameLabel.text = name
            nameLabel.sizeToFit()
        }
    }
    
    @IBAction func pressedBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
