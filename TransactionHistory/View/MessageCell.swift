//
//  MessageCell.swift
//  TransactionHistory
//
//  Created by Ashish Kheveria on 31/07/21.
//

import UIKit

class MessageCell: UITableViewCell {
    
    
    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dateOfTransactionLabel: UILabel!
    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var moreButton: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var declineButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
