//
//  ViewController.swift
//  UINavigationController_EX
//
//  Created by shm on 2021/09/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? SeguePresentViewController {
            viewController.name = "SeguePresentViewController"
        }
        
        if let viewController = segue.destination as? SeguePushViewController {
            viewController.name = "SeguePushViewController"
        }
    }
    
    @IBAction func pressedCodePresent(_ sender: UIButton) {
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "CodePresentViewController") as? CodePresentViewController else {
            fatalError()
        }
        
        //data 전달
        viewController.name = "pressedCodePresent"
        
        self.present(viewController, animated: true, completion: nil)
    }

    
    @IBAction func pressedCodePush(_ sender: UIButton) {
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "CodePushViewController") as? CodePushViewController else { return }
        
        //data 전달
        viewController.name = "pressedCodePush"
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

