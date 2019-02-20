//
//  ViewController.swift
//  CoreDataPart-1
//
//  Created by apple on 20/02/19.
//  Copyright © 2019 iOSProofs. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    var schools: [School] = []
    var selectedSchool: School?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refresh()
    }

    @IBAction func addNewSchools(_ sender: Any) {
        let context = CoreDataManager.sharedManager.context
        let newSchool = School(context: context)
        newSchool.name = "Chaithnya"
        newSchool.established = 2001
        newSchool.address = "Guntoor"
        CoreDataManager.sharedManager.saveContext()
        refresh()
    }
    
    func refresh() {
        schools = CoreDataManager.sharedManager.fetchObjects(entityName: "School")
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let svc = segue.destination as! StudentsTableViewController
        svc.selectedSchool = selectedSchool
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schools.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SchoolCell")
        
        let aSchools = schools[indexPath.row]
        cell?.textLabel?.text = aSchools.name
        cell?.detailTextLabel?.text = aSchools.address
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSchool = schools[indexPath.row]
        self.performSegue(withIdentifier: "ToStudentVC", sender: nil)
    }
}

