//
//  Chords+CoreDataProperties.swift
//  ChordMaster
//
//  Created by KatsuhikoTamura on 2018/07/03.
//  Copyright © 2018年 9bit.co. All rights reserved.
//
//

import Foundation
import CoreData


extension Chords {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Chords> {
        return NSFetchRequest<Chords>(entityName: "Chords")
    }

    @NSManaged public var cName: String?
    @NSManaged public var keyNote: String?
    @NSManaged public var notes: NSObject?

}
