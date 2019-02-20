//
//  School+CoreDataProperties.swift
//  CoreDataPart-1
//
//  Created by apple on 20/02/19.
//  Copyright © 2019 iOSProofs. All rights reserved.
//
//

import Foundation
import CoreData


extension School {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<School> {
        return NSFetchRequest<School>(entityName: "School")
    }

    @NSManaged public var name: String?
    @NSManaged public var established: Int32
    @NSManaged public var address: String?
    @NSManaged public var isCoEducation: Bool
    @NSManaged public var students: NSSet?

}

// MARK: Generated accessors for students
extension School {

    @objc(addStudentsObject:)
    @NSManaged public func addToStudents(_ value: Student)

    @objc(removeStudentsObject:)
    @NSManaged public func removeFromStudents(_ value: Student)

    @objc(addStudents:)
    @NSManaged public func addToStudents(_ values: NSSet)

    @objc(removeStudents:)
    @NSManaged public func removeFromStudents(_ values: NSSet)

}
