//
//  TodoModel.swift
//  bitlist
//
//  Created by Bayan on 7/13/16.
//  Copyright © 2016 Bayan. All rights reserved.
//

import Foundation

enum RepeatType: Int {
    case daily = 0
    case weekly = 1
    case monthly = 2
    case yearly = 3
}

struct TodoModel {
    var title: String
    var favorited: Bool
    var dueDate: Date?
    var completed: Bool
    
    var repeated: RepeatType?
    var reminder: Date?
}
