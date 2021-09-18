//
//  ViewController.swift
//  FireBoard
//
//  Created by shm on 2021/09/19.
//

import UIKit
import FirebaseAuthUI
import FirebaseEmailAuthUI

class ViewController: UIViewController, FUIAuthDelegate {
    
    let providers: [FUIAuthProvider] = [
      FUIEmailAuth()
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func loginPressed(_ sender: UIButton) {
        
        // Get the default auth UI object
        guard let authUI = FUIAuth.defaultAuthUI() else {
            fatalError("Fail to get the default auth UI object")
        }

        // Set ourselves as the delegate
        authUI.delegate = self
        authUI.providers = providers
        
        // Get a reference to the auth UI view controller
        let authViewController = authUI.authViewController()
        
        // Show it
        present(authViewController, animated: true, completion: nil)
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
      // handle user (`authDataResult.user`) and error as necessary
        if error != nil {
            return
        }
        
        performSegue(withIdentifier: "goHome", sender: self)
    }
}

