//
//  TodoTableViewCell.swift
//  bitlist
//
//  Created by Bayan on 7/12/16.
//  Copyright © 2016 Bayan. All rights reserved.
//

import UIKit

protocol TodoTableViewCellDelegate {
    func completeTodo(_ indexPath: IndexPath)
    func favoriteTodo(_ indexPath: IndexPath)
}

class TodoTableViewCell: UITableViewCell {

    @IBOutlet weak var completeButton: UIButton!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    
    var indexPath: IndexPath!
    var delegate: TodoTableViewCellDelegate?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func completeButtonTapped(_ sender: UIButton) {
        delegate?.completeTodo(indexPath)
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        delegate?.favoriteTodo(indexPath)
    }
    
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        
        super.setEditing(true, animated: true)
        
        if editing {
            dateLabel.isHidden = true
            favoriteButton.isHidden = true
            completeButton.isHidden = true
        }
        else {
            dateLabel.isHidden = false
            favoriteButton.isHidden = false
            completeButton.isHidden = false
        }
        
    }
    

}
