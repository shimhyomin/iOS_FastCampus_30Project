//
//  DiaryDetailViewController.swift
//  Diary
//
//  Created by shm on 2021/10/03.
//

import UIKit

protocol DiaryDetailViewDelegate: AnyObject {
    func didSelectDelete(indexPath: IndexPath)
}

class DiaryDetailViewController: UIViewController {

    weak var delegate: DiaryDetailViewDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    
    var diary: Diary?
    var indexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()
    }
    
    private func configureView() {
        guard let diary = self.diary else { return }
        self.titleLabel.text = diary.title
        self.contentLabel.text = diary.content
        self.dateLabel.text = self.dateToString(date: diary.date)
    }
    
    //Date를 받아오면 String으로 변환하여 return 하는 함수
    private func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    
    @IBAction func editButtonPressed(_ sender: UIButton) {
        guard let editViewController = self.storyboard?.instantiateViewController(withIdentifier: "WriteDiaryViewController") as? WriteDiaryViewController else { return }
        
        guard let indexPath = self.indexPath else { return }
        guard let diary = self.diary else { return }
        
        editViewController.diaryEditorMode = .edit(indexPath, diary)
        
        NotificationCenter.default.addObserver(self, selector: #selector(editDiaryNofitication(_:)), name: NSNotification.Name("editDiary"), object: nil)
        
        self.navigationController?.pushViewController(editViewController, animated: true)
    }
    
    @objc func editDiaryNofitication(_ notification: Notification) {
        guard let diary = notification.object as? Diary else { return }
        guard let row = notification.userInfo?["indexPath.row"] as? Int else { return }
        self.diary = diary
        self.configureView()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        guard let indexPath = self.indexPath else { return }
        self.delegate?.didSelectDelete(indexPath: indexPath)
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
