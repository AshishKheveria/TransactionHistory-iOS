//
//  TrasactionData.swift
//  TransactionHistory
//
//  Created by Ashish Kheveria on 31/07/21.
//

import Foundation

// MARK: - Welcome
struct TransactionData: Codable {
    let userID, receipeintID: Int
    let transactions: [Transaction]

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case receipeintID = "receipeintId"
        case transactions
    }
}

// MARK: - Transaction
struct Transaction: Codable {
    let id: Int
    let startDate, endDate: String
    let amount, direction, type, status: Int
    let transactionDescription: String
    let customer, partner: Customer

    enum CodingKeys: String, CodingKey {
        case id, startDate, endDate, amount, direction, type, status
        case transactionDescription = "description"
        case customer, partner
    }
}

// MARK: - Customer
struct Customer: Codable {
    let vPayID: Int
    let vPay: VPay

    enum CodingKeys: String, CodingKey {
        case vPayID = "vPayId"
        case vPay
    }
}

enum VPay: String, Codable {
    case johnDoeOenabanc = "johnDoe@oenabanc"
    case manindersinghOnebanc = "manindersingh@onebanc"
}
