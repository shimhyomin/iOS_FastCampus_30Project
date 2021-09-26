//
//  MainViewController.swift
//  SpotifyLogin
//
//  Created by shm on 2021/09/25.
//

import UIKit
import FirebaseAuth

class MainViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Navigation bar 숨기기
        navigationController?.navigationBar.isHidden = true
        
        let email = Auth.auth().currentUser?.email ?? "no user"
        
        welcomeLabel.text = "\(email)님\n 환영합니다."
    }

    @IBAction func pressedLogoutButton(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
            self.navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error: signout \(signOutError.localizedDescription)")
        }
    }
    
    
}
