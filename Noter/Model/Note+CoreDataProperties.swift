//
//  Note+CoreDataProperties.swift
//  Noter
//
//  Created by Santiago on 9/25/17.
//  Copyright © 2017 Santiago. All rights reserved.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var noteContents: String?
    @NSManaged public var noteTitle: String?

}
