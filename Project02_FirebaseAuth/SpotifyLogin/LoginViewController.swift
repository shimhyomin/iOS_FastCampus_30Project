//
//  LoginViewController.swift
//  SpotifyLogin
//
//  Created by shm on 2021/09/25.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

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
        print("pressedEmailLoginButton")
    }
    
    @IBAction func pressedGoogleLoginButton(_ sender: UIButton) {
        print("pressedGoogleLoginButton")
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in
            
            if let error = error {
                print("Fail to Signin for GIDSignIn \(error)")
                return
            }
            
            guard let authentication = user?.authentication,
                  let idToken = authentication.idToken
            else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)
            
            // Google에서 받은 token으로 firebase에 사용자 등록하기
            Auth.auth().signIn(with: credential) { [weak self] _, error in
                guard let self = self else { return }
                
                if let error = error {
                    print("Fail to Firebase Sign in with Google credential, \(error)")
                } else {
                    self.showMainViewController()
                }
            }
        }
    }
    
    private func showMainViewController() {
        guard let mainViewController = storyboard?.instantiateViewController(withIdentifier: "MainViewController") else { return }
        
        mainViewController.modalPresentationStyle = .fullScreen
        //self.present(mainViewController, animated: true, completion: nil)
        self.navigationController?.pushViewController(mainViewController, animated: true)
    }
    
    @IBAction func pressedAppleLoginButton(_ sender: UIButton) {
        print("pressedAppleLoginButton")
    }
    
}
