//
//  Chord+CoreDataProperties.swift
//  ChordMaster
//
//  Created by KatsuhikoTamura on 2018/07/06.
//  Copyright © 2018年 9bit.co. All rights reserved.
//
//

import Foundation
import CoreData


extension Chord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Chord> {
        return NSFetchRequest<Chord>(entityName: "Chords")
    }

    @NSManaged public var cType: [String]?
    @NSManaged public var keyNote: [String]?
    @NSManaged public var notes: [[String]]?

}
