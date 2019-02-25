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
    var fetchRC: NSFetchedResultsController<NSFetchRequestResult>!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFRC()
//        refresh()
    }
    
    func configureFRC() {
        
        var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "School")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "established", ascending: false)]
        
        fetchRC = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.sharedManager.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchRC.delegate = self
        do {
            try fetchRC.performFetch()
            tableView.reloadData()
        } catch {
            print("Failed to load data from School Table")
        }
    }

    @IBAction func addNewSchools(_ sender: Any) {
        
        // Update Records
        let sectionsArray = fetchRC.sections
        let firstSection = sectionsArray?[0] ?? [] as! NSFetchedResultsSectionInfo
        let objects = firstSection.objects
        let aSchool = objects?[0] as! School
        
        aSchool.address = "AAAAAAAAAAA"
        CoreDataManager.sharedManager.saveContext()
        
        
//        let newSchoolAlert = UIAlertController(title: "Add data for new school", message: "", preferredStyle: .alert)
//
//        newSchoolAlert.addTextField { (nameTF) in
//            nameTF.placeholder = "Enter school Name"
//        }
//        newSchoolAlert.addTextField { (yearTF) in
//            yearTF.placeholder = "Enter Year"
//        }
//
//        newSchoolAlert.addTextField { (addressTF) in
//            addressTF.placeholder = "Enter Place"
//        }
//
//        let canelAtion = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
//
//        newSchoolAlert.addAction(canelAtion)
//
//        let addSchoolAction = UIAlertAction(title: "Add School", style: .default) { (action) in
//            let context = CoreDataManager.sharedManager.context
//            let newSchool = School(context: context)
//            newSchool.name = newSchoolAlert.textFields?[0].text ?? ""
//
//            newSchool.established = Int32(Int(newSchoolAlert.textFields?[1].text ?? "") ?? 0)
//
//            newSchool.address = newSchoolAlert.textFields?[2].text ?? ""
//            CoreDataManager.sharedManager.saveContext()
////            self.refresh()
//        }
//
//        newSchoolAlert.addAction(addSchoolAction)
//        self.present(newSchoolAlert, animated: true, completion: nil)
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
//        return schools.count
        
        let sectionsArray = fetchRC.sections
        let firstSection = sectionsArray?[0] ?? [] as! NSFetchedResultsSectionInfo
        return firstSection.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SchoolCell")
        
        let sectionsArray = fetchRC.sections
        let firstSection = sectionsArray?[0] ?? [] as! NSFetchedResultsSectionInfo
        let objects = firstSection.objects
        let aSchool = objects?[indexPath.row] as! School
        
//        let aSchools = schools[indexPath.row]
        cell?.textLabel?.text = aSchool.name
        cell?.detailTextLabel?.text = aSchool.address
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSchool = schools[indexPath.row]
        self.performSegue(withIdentifier: "ToStudentVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let sectionsArray = fetchRC.sections
        let zeroSection = sectionsArray?[0] ?? [] as! NSFetchedResultsSectionInfo
        var allSchools = zeroSection.objects as! [School]
        
//        allSchools.remove(at: indexPath.row)
        CoreDataManager.sharedManager.context.delete(allSchools[indexPath.row])
//                CoreDataManager.sharedManager.saveContext()
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension ViewController: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        print(indexPath)
        print(newIndexPath)
        
        switch type {
        case .insert:
            tableView.reloadData()
        case .update:
            guard let indexPath = indexPath else {return}
            tableView.beginUpdates()
            tableView.reloadRows(at: [indexPath], with: .fade)
            tableView.endUpdates()            
        case .delete:
            guard let indexPath = indexPath else {return}
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        case .move:
            print("User moded tableViewCells")
        }
    }
}
