//
//  CreditCard.swift
//  CreditCardList
//
//  Created by shm on 2021/09/27.
//

import Foundation

struct CreditCard: Codable {
    let id: Int
    let rank: Int
    let name: String
    let isSelected: Bool?
    let cardImageURL: String
    let promotionDetail: PromotionDetail
}

struct PromotionDetail: Codable {
    let companyName: String
    let amount: Int
    let benefitDate: String
    let benefitDetail: String
    let benefitCondition: String
    let condition: String
    let period: String
}
