//
//  DatePickerView.swift
//  bitlist
//
//  Created by Bayan on 8/11/16.
//  Copyright © 2016 Bayan. All rights reserved.
//

import UIKit

protocol DatePickerViewDelegate {
    func removePressed()
    func donePressed()
    func datePickerValueChanged(_ date: Date)
}

class DatePickerView: UIView {
    

    @IBOutlet weak var datePicker: UIDatePicker!
    
    var delegate: DatePickerViewDelegate?
    
    @IBAction func removeBarButtonItemPressed(_ sender: UIBarButtonItem) {
        delegate?.removePressed()
    }
    
    @IBAction func doneBarButtonItemPressed(_ sender: UIBarButtonItem) {
        delegate?.donePressed()
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        delegate?.datePickerValueChanged(sender.date)
    }

}
