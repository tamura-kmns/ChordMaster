//
//  DBAccess.swift
//  ChordMaster
//
//  Created by KatsuhikoTamura on 2018/07/05.
//  Copyright © 2018年 9bit.co. All rights reserved.
//

import Foundation
import UIKit
import CoreData

let appdelegate = UIApplication.shared.delegate as! AppDelegate

public class DBAccess: NSObject {

    let managedContext:NSManagedObjectContext! = appdelegate.persistentContainer.viewContext

    func db_insertChord(basicNote:BasicNote, chordType:ChordType){
        //managedContext = appdelegate.persistentContainer.viewContext
        let chords = NSEntityDescription.insertNewObject(forEntityName: "Chords",
                                                         into: self.managedContext) as! Chords
        chords.keyNote = basicNote.eName
        chords.cName = chordType.symbol
        
        let utils = Utils()
        let notesArray:[[String]] =
            utils.getChordNotesFor(baseNote:basicNote,chordIntvlArray:chordType.intvls)
        chords.notes = notesArray
        appdelegate.saveContext()
        
        print("saved")
    }


}
