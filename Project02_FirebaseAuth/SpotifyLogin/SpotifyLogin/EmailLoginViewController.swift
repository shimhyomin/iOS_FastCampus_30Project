//
//  EmailLoginViewController.swift
//  SpotifyLogin
//
//  Created by shm on 2021/09/25.
//

import UIKit
import FirebaseAuth

class EmailLoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.layer.cornerRadius = 30
        nextButton.isEnabled = false
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        //커서가 처음에 emailTextField에 가있도록 한다.
        emailTextField.becomeFirstResponder()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Navigation bar 나타내기
        navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func pressedNextButton(_ sender: UIButton) {
        //Firebase 이메일/비밀번호인증
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                //error code를 통해 이미 가입한 이메일로 createUser하려다 error난 경우 login
                let code = (error as NSError).code
                switch code {
                case 17007: //이미 가입한 이메일로 로그인하는 경우
                    self.loginUser(withEmail: email, password: password)
                default:
                    self.errorMessageLabel.text = error.localizedDescription
                }
            }else {
                self.showMainViewController()
            }
        }
    }
    
    private func showMainViewController() {
        guard let mainViewController = storyboard?.instantiateViewController(withIdentifier: "MainViewController") else { return }
        
        mainViewController.modalPresentationStyle = .fullScreen
        //self.present(mainViewController, animated: true, completion: nil)
        self.navigationController?.pushViewController(mainViewController, animated: true)
    }
    
    private func loginUser(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
            guard let self = self else { return }
            
            if let error = error {
                self.errorMessageLabel.text = error.localizedDescription
            } else {
                self.showMainViewController()
            }
        }
    }
}

// MARK: - UITextFieldDelegate

extension EmailLoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //return 누르면 keyboard 내리기
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let isEmailEmpty = emailTextField.text == ""
        let isPasswordEmpty = passwordTextField.text == ""
        nextButton.isEnabled = !isEmailEmpty && !isPasswordEmpty
    }
}
