//
//  WriteDiaryViewController.swift
//  Diary
//
//  Created by shm on 2021/10/03.
//

import UIKit

class WriteDiaryViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var confirmButton: UIBarButtonItem!
    
    //dateTextField에서 날짜 선택 창이 뜨게 하기 위한 변수 정의
    private let datePicker = UIDatePicker()
    private var diaryDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureContentsTextView()
        self.configureDatePicker()
        
        self.configureInputField()
        
        self.confirmButton.isEnabled = false
    }
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        
    }
}
//MARK: -contentTextView의 border 설정
extension WriteDiaryViewController {
    //contentTextView에 테두리가 없어서 테두리를 그리는 함수
    private func configureContentsTextView() {
        let borderColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
        self.contentTextView.layer.borderColor = borderColor.cgColor
        self.contentTextView.layer.borderWidth = 0.5
        self.contentTextView.layer.cornerRadius = 5.0
    }
}

//MARK: -dateTextField의 input type을 date로 변경
extension WriteDiaryViewController {
    
    //dateTextField에서 날짜 선택 창이 뜨게 하기 위한 함수
    private func configureDatePicker() {
        self.datePicker.datePickerMode = .date
        self.datePicker.preferredDatePickerStyle = .wheels
        self.datePicker.addTarget(self, action: #selector(datePickerValueDidChange(_:)), for: .valueChanged)
        self.datePicker.locale = Locale(identifier: "ko_KR")
        self.dateTextField.inputView = self.datePicker
    }
    
    @objc private func datePickerValueDidChange(_ datePicker: UIDatePicker) {
        let formater = DateFormatter()
        formater.dateFormat = "yyyy년 MM월 dd일(EEEE)"
        formater.locale = Locale(identifier: "ko_KR")
        self.diaryDate = datePicker.date
        self.dateTextField.text = formater.string(from: datePicker.date)
        
        //dateTextField는 date type이기 때문에 editingChanged에 대하여 반응하지 않기 때문에 아래 코드 필요
        self.dateTextField.sendActions(for: .editingChanged)
    }
    
    //화면 아무데나 터치하면 datePicker 사라지도록 하는 함수
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

//MARK: -titleTextField, contentTextField, dateTextView 모두 작성되면 confirm Button 활성화
extension WriteDiaryViewController {
    private func configureInputField() {
        self.contentTextView.delegate = self
        self.titleTextField.addTarget(self, action: #selector(titleTextFieldDidChange(_:)), for: .editingChanged)
        self.dateTextField.addTarget(self, action: #selector(dateTextFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc private func titleTextFieldDidChange(_ textField: UITextField) {
        self.validateInputField()
    }
    
    @objc private func dateTextFieldDidChange(_ textField: UITextField) {
        self.validateInputField()
    }
    
    private func validateInputField() {
        self.confirmButton.isEnabled = !(self.titleTextField.text?.isEmpty ?? true) && !(self.dateTextField.text?.isEmpty ?? true) && !(self.contentTextView.text.isEmpty)
    }
}

//MARK: - UITextViewDelegate
extension WriteDiaryViewController: UITextViewDelegate {
    //TextView에 text가 입력될 때마다 호출되는 method
    func textViewDidChange(_ textView: UITextView) {
        self.validateInputField()
    }
}
