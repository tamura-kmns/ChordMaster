//
//  BasicNote+CoreDataProperties.swift
//  ChordMaster
//
//  Created by KatsuhikoTamura on 2018/07/26.
//  Copyright © 2018年 9bit.co. All rights reserved.
//
//

import Foundation
import CoreData


extension BasicNote {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BasicNote> {
        return NSFetchRequest<BasicNote>(entityName: "BasicNote")
    }

    @NSManaged public var eNameF: String?
    @NSManaged public var eNameS: String?
    @NSManaged public var iNameF: String?
    @NSManaged public var iNameS: String?
    @NSManaged public var jNameF: String?
    @NSManaged public var jNameS: String?
    @NSManaged public var noteNumber: Int16
    @NSManaged public var chord: NSSet?

}

// MARK: Generated accessors for chord
extension BasicNote {

    @objc(addChordObject:)
    @NSManaged public func addToChord(_ value: Chord)

    @objc(removeChordObject:)
    @NSManaged public func removeFromChord(_ value: Chord)

    @objc(addChord:)
    @NSManaged public func addToChord(_ values: NSSet)

    @objc(removeChord:)
    @NSManaged public func removeFromChord(_ values: NSSet)

}
