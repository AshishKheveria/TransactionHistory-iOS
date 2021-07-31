//
//  ViewController.swift
//  TransactionHistory
//
//  Created by Ashish Kheveria on 31/07/21.
//

import UIKit

class ViewController: UIViewController, TransactionDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var message = [TransactionModel]()
    
    var transactionManager = TransactinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transactionManager.delegate = self
        transactionManager.fetchRequest()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
    }
    
    func didUpdateTransaction(_ transactionManager: TransactinManager, transaction: [TransactionModel]) {
        for i in 0..<transaction.count {
            message.append(transaction[i])
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return message.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let messageBubble = message[indexPath.row]
      
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! MessageCell
        cell.amountLabel.text = "₹ \(message[indexPath.row].amount)"
        cell.dateLabel.text = messageBubble.date
        cell.cancelButton.isHidden = true
        cell.declineButton.isHidden = true
        
        if messageBubble.direction == 1 {
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
        } else {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            
        }
        switch message[indexPath.row].direction {
        
        case 1:
            switch message[indexPath.row].type {
            
            case 1:
                switch message[indexPath.row].status {
                case 1:
                    cell.statusLabel.text = "Pending"
                    
                case 2:
                    cell.statusLabel.text = "✅ You Paid!"
                    cell.actionLabel.text = " Trans. ID: \(message[indexPath.row].transactionID)"
                    
                default:
                    cell.statusLabel.text = ""
                }
            case 2:
                switch message[indexPath.row].status {
                
                case 1:
                    cell.statusLabel.text = "Sent Request"
                    cell.actionLabel.textColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
                    cell.actionLabel.isHidden = true
                    cell.cancelButton.isHidden = false
                    cell.cancelButton.setTitle("Cancel", for: .normal)
                    cell.moreButton.text = ""
                    
                case 2:
                    cell.statusLabel.text = "Request Accepted"
                default:
                    cell.statusLabel.text = ""
                }
            default:
                cell.statusLabel.text = ""
            }
            
        case 2:
            switch message[indexPath.row].type {
            
            case 1:
                switch message[indexPath.row].status {
                case 1:
                    cell.statusLabel.text = "Pending"
                    
                case 2:
                    cell.statusLabel.text = "Request Recieved!"
                    cell.actionLabel.isHidden = true
                    cell.cancelButton.setTitle("Pay", for: .normal)
                    cell.declineButton.setTitle("Decline", for: .normal)
                    cell.cancelButton.isHidden = false
                    cell.declineButton.isHidden = false
                    cell.moreButton.text = ""
                    
                default:
                    cell.statusLabel.text = ""
                }
            case 2:
                switch message[indexPath.row].status {
                
                case 1:
                    cell.statusLabel.text = "Requested!"
                    cell.actionLabel.isHidden = true
                    cell.cancelButton.isHidden = false
                    cell.cancelButton.setTitle("Cancel", for: .normal)
                    cell.moreButton.text = ""
                    
                case 2:
                    cell.statusLabel.text = "✅ You recieved!"
                default:
                    cell.statusLabel.text = ""
                }
            default:
                cell.statusLabel.text = ""
            }
            
        default:
            cell.statusLabel.text = ""
        }
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TrasactionHistoryViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.amount = message[indexPath.row].amount
            destinationVC.startDate = message[indexPath.row].date
            destinationVC.endDate = message[indexPath.row].endDate
            destinationVC.descriptionOfTheTrasaction = message[indexPath.row].description
            destinationVC.id = message[indexPath.row].transactionID
        }
        
    }
}
