//
//  TodoViewController.swift
//  bitlist
//
//  Created by Bayan on 7/20/16.
//  Copyright © 2016 Bayan. All rights reserved.
//

import UIKit

class TodoViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet var datePickerView: DatePickerView!
    
    @IBOutlet var repeatPickerView: RepeatView!
    
    @IBOutlet var reminderPickerView: DatePickerView!
    
    
    var todo: TodoModel!
    
    var mainVC: TodosViewController!
    
    var currentMenuView: UIView?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        //Showing Todo in TodoViewController
        if todo.completed {
            navigationItem.leftBarButtonItem?.title = "Pending"
        }
        
        if todo.favorited {
            navigationItem.rightBarButtonItem?.title = "Unfavorite"
        }
        
        navigationItem.title = todo.title
        
        //Swiping back to the TodosViewController
        let swipeView = UISwipeGestureRecognizer(target: self, action: #selector(TodoViewController.respondToSwipe(_:)))
        swipeView.direction = UISwipeGestureRecognizerDirection.right
        
        navigationController?.navigationBar.addGestureRecognizer(swipeView)
        
        let secondSwipeView = UISwipeGestureRecognizer(target: self, action: #selector(TodoViewController.respondToSwipe(_:)))
        secondSwipeView.direction = UISwipeGestureRecognizerDirection.right
        
        datePickerView.frame = CGRect(x: view.frame.origin.x, y: view.frame.height, width: view.frame.size.width, height: datePickerView.frame.height)
        datePickerView.delegate = self
        view.addSubview(datePickerView)
        
        repeatPickerView.frame = CGRect(x: view.frame.origin.x, y: view.frame.size.height, width: view.frame.size.width, height: repeatPickerView.frame.height)
        repeatPickerView.delegate = self
        view.addSubview(repeatPickerView)
        
        reminderPickerView.frame = CGRect(x: view.frame.origin.x, y: view.frame.size.height, width: view.frame.size.width, height: reminderPickerView.frame.height)
        reminderPickerView.delegate = self
        view.addSubview(reminderPickerView)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func respondToSwipe(_ gesture: UIGestureRecognizer) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func completeBarButtonItemPressed(_ sender: UIBarButtonItem) {
        todo.completed = !todo.completed
        
        mainVC.baseArray[mainVC.selectedTodoIndexPath.section - 1].remove(at: mainVC.selectedTodoIndexPath.row)
        
        if todo.completed {
            mainVC.baseArray[1].append(todo)
        }
        else {
            mainVC.baseArray[0].append(todo)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func favoriteBarButtonItemPressed(_ sender: UIBarButtonItem) {
        
        todo.favorited = !todo.favorited
        
        mainVC.baseArray[mainVC.selectedTodoIndexPath.section - 1].remove(at: mainVC.selectedTodoIndexPath.row)
        
        if todo.completed {
            mainVC.baseArray[1].append(todo)
        }
        else {
            mainVC.baseArray[0].append(todo)
        }
        
        if todo.favorited {
            navigationItem.rightBarButtonItem?.title = "Unfavorite"
        }
        else {
            navigationItem.rightBarButtonItem?.title = "Favorite"
        }
    }
    
    
    @IBAction func deleteBarButtonItemPressed(_ sender: UIBarButtonItem) {
        mainVC.baseArray[mainVC.selectedTodoIndexPath.section - 1].remove(at: mainVC.selectedTodoIndexPath.row)
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func returnBarButtonItemPressed(_ sender: UIBarButtonItem) {
        
        navigationController?.popViewController(animated: true)
        
        
        
    }
    
    func presentPicker (_ menuView: UIView) {
        
        currentMenuView = menuView
        
        UIView.animate(withDuration: 0.6, animations: { () -> Void in
            menuView.frame = CGRect(x: menuView.frame.origin.x,  y: menuView.frame.origin.y - menuView.frame.size.height, width: menuView.frame.width, height: menuView.frame.size.height)
        }) 
    }
    
    
    func dismissPicker() {
        
        UIView.animate(withDuration: 1.0, animations: { () -> Void in

            if let picker = self.currentMenuView {
                self.currentMenuView = nil
                picker.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.size.height, width: self.view.frame.size.width, height: picker.frame.height)
            }
        }) 
    }

}


extension TodoViewController: DatePickerViewDelegate {
    
    func removePressed() {
        
        if let menuView = currentMenuView {
            if menuView == datePickerView {
                todo.dueDate = nil
            }
            else if menuView == reminderPickerView {
                todo.reminder = nil
            }
        }
        dismissPicker()
        tableView.reloadData()
    }
    
    func donePressed() {
        dismissPicker()
    }
    
    func datePickerValueChanged(_ date: Date) {
        
        if let menuView = currentMenuView {
            if menuView == datePickerView {
                todo.dueDate = date
            }
            else if menuView == reminderPickerView {
                todo.reminder = date
            }
        }
        
        tableView.reloadData()
        
    }
}


extension TodoViewController: RepeatViewDelegate {
    
    func remove() {
        todo.repeated = nil
        tableView.reloadData()
    }
    
    func done() {
        dismissPicker()
    }
    
    func pickerViewDidSelect(_ type: RepeatType) {
        todo.repeated = type
        tableView.reloadData()
    }
    
    
    
}


extension TodoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentMenu = currentMenuView
        
        dismissPicker()
        
        var pickerView: UIView?
        
        switch ((indexPath as NSIndexPath).section, (indexPath as NSIndexPath).row) {
        case (0,0):
            pickerView = datePickerView
        case (0,1):
            pickerView = repeatPickerView
        case (1,0):
            pickerView = reminderPickerView
        default: break
        }
        
        if let viewForPicker = pickerView , currentMenu != pickerView {
            presentPicker(viewForPicker)
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    
}


extension TodoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateStyle = DateFormatter.Style.long
        
        let timeStringFormatter = DateFormatter()
        timeStringFormatter.dateFormat = "HH:mm:ss"
        
        if (indexPath as NSIndexPath).section == 0 {
            
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            
            if (indexPath as NSIndexPath).row == 0 {
                cell.imageView?.image = UIImage(named: "calendar")
                if let dueDate = todo.dueDate {
                    let dateString = dateStringFormatter.string(from: dueDate as Date)
                    cell.textLabel?.text = "Due " + dateString
                    cell.textLabel?.textColor = UIColor.blue
                    cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
                }
                else {
                    cell.textLabel?.text = "Due Date"
                    cell.textLabel?.textColor = UIColor.lightGray
                }
            }
            else {
                cell.imageView?.image = UIImage(named: "repeat")
                if let repeatFrequency = todo.repeated {
                    cell.textLabel?.text = "Repeat \(repeatFrequency)"
                    cell.textLabel?.textColor = UIColor.blue
                    cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
                }
                else {
                    cell.textLabel?.text = "Repeat"
                    cell.textLabel?.textColor = UIColor.lightGray
                }
            }
            return cell
        }
            
        else if (indexPath as NSIndexPath).section == 1 {
            
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Reminder")!
            
            cell.imageView?.image = UIImage(named: "alarmclock")
            
            if let reminderDate = todo.reminder {
                let timeString = timeStringFormatter.string(from: reminderDate as Date)
                
                cell.textLabel?.text = "Remind me at " + timeString
                cell.textLabel?.textColor = UIColor.blue
                cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
                
                let dateString = dateStringFormatter.string(from: reminderDate as Date)
                cell.detailTextLabel?.text = dateString
            }
            else {
                cell.textLabel?.text = "Reminder"
                cell.textLabel?.textColor = UIColor.lightGray
                cell.detailTextLabel?.text = ""
            }
            return cell
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 2
        }
        else if section == 1 {
            return 1
        }
        return 0
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
}







