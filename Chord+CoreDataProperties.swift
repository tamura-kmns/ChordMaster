//
//  Chord+CoreDataProperties.swift
//  ChordMaster
//
//  Created by KatsuhikoTamura on 2018/07/25.
//  Copyright © 2018年 9bit.co. All rights reserved.
//
//

import Foundation
import CoreData


extension Chord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Chord> {
        return NSFetchRequest<Chord>(entityName: "Chord")
    }

    @NSManaged public var num: Int16
    @NSManaged public var baseNote: BasicNote?
    @NSManaged public var chordBase: ChordBase?

}
