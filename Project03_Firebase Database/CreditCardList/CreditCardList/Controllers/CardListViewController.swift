//
//  CardListViewController.swift
//  CreditCardList
//
//  Created by shm on 2021/09/27.
//

import UIKit
import Kingfisher
import FirebaseDatabase

class CardListViewController: UITableViewController {
    
    var ref: DatabaseReference!
    
    var creditCardList: [CreditCard] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        ref.observe(.value) { snapshot in
            guard let value = snapshot.value as? [String: [String: Any]] else { return }
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: value)
                let cardData = try JSONDecoder().decode([String: CreditCard].self, from: jsonData)
                let cardList = Array(cardData.values)
                self.creditCardList = cardList.sorted { $0.rank < $1.rank }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }catch {
                print()
            }
        }
        
        //UITableView Cell Register
        let nibName = UINib(nibName: "CreditCardTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "CreditCardTableViewCell")
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creditCardList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CreditCardTableViewCell", for: indexPath) as? CreditCardTableViewCell else { return UITableViewCell() }
        
        cell.rankLabel.text = "\(creditCardList[indexPath.row].rank)위"
        cell.prmotionLabel.text = "\(creditCardList[indexPath.row].promotionDetail.benefitDetail) 증정"
        cell.creditLabel.text = "\(creditCardList[indexPath.row].name)"
        
        let imageURL = URL(string: creditCardList[indexPath.row].cardImageURL)
        cell.cardImage.kf.setImage(with: imageURL)
        
        return cell
    }
    
    //cell의 높이 지정
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "PromotionDetailViewController") as? PromotionDetailViewController else { return }
        
        detailViewController.promotionDetail = creditCardList[indexPath.row].promotionDetail
        self.show(detailViewController, sender: nil)
    }
    
}
