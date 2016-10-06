//
//  AddTodoTableViewCell.swift
//  bitlist
//
//  Created by Bayan on 7/12/16.
//  Copyright © 2016 Bayan. All rights reserved.
//

import UIKit

class AddTodoTableViewCell: UITableViewCell {

    @IBOutlet weak var addTodoTextField: UITextField!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var favorited: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        
        if addTodoTextField.isFirstResponder {
            favorited = !favorited
            
            if favorited {
                favoriteButton.backgroundColor = UIColor.blue
            }
            else {
                favoriteButton.backgroundColor = UIColor.orange
            }
        }
    }

}
