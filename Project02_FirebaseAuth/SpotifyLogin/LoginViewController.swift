//
//  LoginViewController.swift
//  SpotifyLogin
//
//  Created by shm on 2021/09/25.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailLoginButton: UIButton!
    @IBOutlet weak var googleLoginButton: UIButton!
    @IBOutlet weak var appleLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [emailLoginButton, googleLoginButton, appleLoginButton].forEach {
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.white.cgColor
            $0?.layer.cornerRadius = 30
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Navigation bar 숨기기
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func pressedEmailLoginButton(_ sender: UIButton) {
    }

    @IBAction func pressedGoogleLoginButton(_ sender: UIButton) {
    }
    
    @IBAction func pressedAppleLoginButton(_ sender: UIButton) {
    }
    
}
