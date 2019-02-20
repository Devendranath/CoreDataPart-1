//
//  Student+CoreDataProperties.swift
//  CoreDataPart-1
//
//  Created by apple on 20/02/19.
//  Copyright © 2019 iOSProofs. All rights reserved.
//
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var name: String?
    @NSManaged public var rollNo: Int16
    @NSManaged public var school: School?

}
