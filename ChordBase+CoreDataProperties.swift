//
//  ChordBase+CoreDataProperties.swift
//  ChordMaster
//
//  Created by KatsuhikoTamura on 2018/07/25.
//  Copyright © 2018年 9bit.co. All rights reserved.
//
//

import Foundation
import CoreData


extension ChordBase {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChordBase> {
        return NSFetchRequest<ChordBase>(entityName: "ChordBase")
    }

    @NSManaged public var cName: String?
    @NSManaged public var intvls: [Int]?
    @NSManaged public var kName: String?
    @NSManaged public var symbol: String?
    @NSManaged public var symbol2: String?
    @NSManaged public var jName: String?
    @NSManaged public var chord: NSSet?

}

// MARK: Generated accessors for chord
extension ChordBase {

    @objc(addChordObject:)
    @NSManaged public func addToChord(_ value: Chord)

    @objc(removeChordObject:)
    @NSManaged public func removeFromChord(_ value: Chord)

    @objc(addChord:)
    @NSManaged public func addToChord(_ values: NSSet)

    @objc(removeChord:)
    @NSManaged public func removeFromChord(_ values: NSSet)

}
