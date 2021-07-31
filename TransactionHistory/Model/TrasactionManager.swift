//
//  TrasactionManager.swift
//  TransactionHistory
//
//  Created by Ashish Kheveria on 31/07/21.
//

import Foundation

protocol TransactionDelegate {
    func didUpdateTransaction(_ transactionManager: TransactinManager, transaction: [TransactionModel])
}

struct TransactinManager {
    
    let transactionURL = "https://dev.onebanc.ai/assignment.asmx/GetTransactionHistory?userId=1&recipientId=2"
    
    var delegate: TransactionDelegate?
    
    func fetchRequest() {
        performRequest(with: transactionURL)
    }
    
    func performRequest(with urlString: String) {
        
        var request = URLRequest(url: URL(string: urlString)!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            if let safeData = data {
                print(String(data: safeData, encoding: .utf8)!)
                if let transaction = self.parseJSON(safeData) {
                    self.delegate?.didUpdateTransaction(self, transaction: transaction)
                }
            }
        }
        task.resume()
        
    }
    
    func parseJSON(_ transactionData: Data) -> [TransactionModel]?{
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(TransactionData.self, from: transactionData)
            
            var transactionArray = [TransactionModel]()
            
            let transactionArrayCount = decodedData.transactions.count
            
            for i in 0..<transactionArrayCount {
                
                let direction = decodedData.transactions[i].direction
                let amount = decodedData.transactions[i].amount
                let status = decodedData.transactions[i].status
                let date = decodedData.transactions[i].startDate
                let type = decodedData.transactions[i].type
                let transactionID = decodedData.transactions[i].id
                let endDate = decodedData.transactions[i].endDate
                let description = decodedData.transactions[i].transactionDescription
                
                let transaction = TransactionModel(direction: direction, type: type, status: status, amount: amount, date: date, transactionID: transactionID, endDate: endDate, description: description)
                
                transactionArray.append(transaction)
            }
//            print(transactionArray)
            return transactionArray
            
        } catch {
            return nil
        }
    }
}
