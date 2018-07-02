//
//  ChordBase+CoreDataProperties.swift
//  ChordMaster
//
//  Created by KatsuhikoTamura on 2018/07/03.
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
    @NSManaged public var intvls: Array<Any>?
    @NSManaged public var kName: String?
    @NSManaged public var symbol: String?
    @NSManaged public var symbol2: String?

}
