//
//  ViewController.swift
//  Diary
//
//  Created by shm on 2021/10/03.
//

import UIKit

class ViewController: UIViewController {

    private var diaryList: [Diary] = [] {
        didSet {
            self.saveDiaryList()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureCollectionView()
        
        self.loadDiaryList()
        
        NotificationCenter.default.addObserver(self, selector: #selector(editDiaryNofitication(_:)), name: NSNotification.Name("editDiary"), object: nil)
    }
    
    @objc func editDiaryNofitication(_ notification: Notification) {
        guard let diary = notification.object as? Diary else { return }
        guard let row = notification.userInfo?["indexPath.row"] as? Int else { return }
        self.diaryList[row] = diary
        self.diaryList = self.diaryList.sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
        self.collectionView.reloadData()
    }

    private func configureCollectionView() {
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let writeDiaryViewController = segue.destination as? WriteDiaryViewController {
            writeDiaryViewController.delegate = self
        }
    }
    
    //Date를 받아오면 String으로 변환하여 return 하는 함수
    private func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    
    private func saveDiaryList() {
        let date = self.diaryList.map {
            [
                "title": $0.title,
                "content": $0.content,
                "date": $0.date,
                "isStar": $0.isStar
            ]
        }
        let userDefault = UserDefaults.standard
        userDefault.set(date, forKey: "diaryList")
    }
    
    private func loadDiaryList() {
        let userDefult = UserDefaults.standard
        guard let data = userDefult.object(forKey: "diaryList") as? [[String: Any]] else { return }
        self.diaryList = data.compactMap {
            guard let title = $0["title"] as? String else { return nil }
            guard let content = $0["content"] as? String else { return nil }
            guard let date = $0["date"] as? Date else { return nil }
            guard let isStar = $0["isStar"] as? Bool else { return nil }
            return Diary(title: title, content: content, date: date, isStar: isStar)
        }
        
        self.diaryList = self.diaryList.sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
    }
    
}

//MARK: -WriteDiaryViewDelegate
extension ViewController: WriteDiaryViewDelegate {
    func didSelectRegister(diary: Diary) {
        self.diaryList.append(diary)
        
        self.diaryList = self.diaryList.sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
        
        self.collectionView.reloadData()
    }
}

//MARK: -UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.diaryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiaryCell", for: indexPath) as? DiaryCell else {
            return UICollectionViewCell()
        }
        
        let diary = self.diaryList[indexPath.row]
        cell.titleLabel.text = diary.title
        cell.dateLabel.text = self.dateToString(date: diary.date)
        
        return cell
    }
}

//MARK: -UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width / 2) - 20 , height: 200)
    }
}

//MARK: -UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DiaryDetailViewController") as? DiaryDetailViewController else { return }
        
        let diary = self.diaryList[indexPath.row]
        
        detailViewController.diary = diary
        detailViewController.indexPath = indexPath
        
        detailViewController.delegate = self
        
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

//MARK: -DiaryDetailViewDelegate
extension ViewController: DiaryDetailViewDelegate {
    func didSelectDelete(indexPath: IndexPath) {
        self.diaryList.remove(at: indexPath.row)
        self.collectionView.deleteItems(at: [indexPath])
    }
}
