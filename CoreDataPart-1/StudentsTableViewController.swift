//
//  StudentsTableViewController.swift
//  CoreDataPart-1
//
//  Created by apple on 20/02/19.
//  Copyright © 2019 iOSProofs. All rights reserved.
//

import UIKit

class StudentsTableViewController: UITableViewController {
    
    @IBAction func addStudent(_ sender: Any) {
        let newStudent = Student(context: CoreDataManager.sharedManager.context)
        newStudent.name = "DNREDDi"
        newStudent.rollNo = 0001
        selectedSchool?.addToStudents(newStudent)
        CoreDataManager.sharedManager.saveContext()
        refresh()
    }
    var selectedSchool: School?
    var students: Set<Student>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        students = selectedSchool?.students as? Set<Student>
    }
    
    func refresh() {
        students = selectedSchool?.students as! Set<Student>
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return students?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell", for: indexPath)
        let aStudent = students?.first
        cell.textLabel?.text = aStudent?.name
        return cell ?? UITableViewCell()
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
 

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
 

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
 

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
