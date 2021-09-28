//
//  PromotionDetailViewController.swift
//  CreditCardList
//
//  Created by shm on 2021/09/27.
//

import UIKit
import Lottie

class PromotionDetailViewController: UIViewController {

    @IBOutlet weak var moneyLottieView: LottieView!
    
    @IBOutlet weak var peroidLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var benefitConditionLabel: UILabel!
    @IBOutlet weak var benefitDetailLabel: UILabel!
    @IBOutlet weak var benefitDataLabel: UILabel!
    
    var promotionDetail: PromotionDetail!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let animationView = AnimationView(name: "money")
        moneyLottieView.contentMode = .scaleAspectFit
        moneyLottieView.addSubview(animationView)
        animationView.frame = moneyLottieView.bounds
        animationView.loopMode = .loop
        animationView.play()
        
        peroidLabel.text = promotionDetail.period
        conditionLabel.text = promotionDetail.condition
        benefitConditionLabel.text = promotionDetail.benefitCondition
        benefitDetailLabel.text = promotionDetail.benefitDetail
        benefitDataLabel.text = promotionDetail.benefitDate
    }

}
