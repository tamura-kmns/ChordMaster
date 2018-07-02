//
//  BasicNotes+CoreDataProperties.swift
//  ChordMaster
//
//  Created by KatsuhikoTamura on 2018/07/03.
//  Copyright © 2018年 9bit.co. All rights reserved.
//
//

import Foundation
import CoreData


extension BasicNotes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BasicNotes> {
        return NSFetchRequest<BasicNotes>(entityName: "BasicNotes")
    }

    @NSManaged public var eNameF: String?
    @NSManaged public var eNameS: String?
    @NSManaged public var iNameF: String?
    @NSManaged public var iNameS: String?

}
