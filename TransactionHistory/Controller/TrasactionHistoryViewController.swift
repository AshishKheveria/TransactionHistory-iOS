//
//  TrasactionHistoryViewController.swift
//  TransactionHistory
//
//  Created by Ashish Kheveria on 01/08/21.
//

import UIKit

class TrasactionHistoryViewController: UIViewController {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    var id = 0
    var startDate = ""
    var endDate = ""
    var amount = 1000
    var descriptionOfTheTrasaction = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idLabel.text = "\(id)"
        startDateLabel.text = startDate
        endDateLabel.text = endDate
        amountLabel.text = "\(amount)"
        descriptionLabel.text = descriptionOfTheTrasaction
    }
    
}
