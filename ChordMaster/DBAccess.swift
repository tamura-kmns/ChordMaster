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
        let chord = NSEntityDescription.insertNewObject(forEntityName: "Chords",
                                                         into: self.managedContext) as! Chord
        chord.keyNote1 = basicNote.eName[0]
        chord.cType1 = chordType.symbol[0]
        chord.keyNote2 = basicNote.eName[1]
        chord.cType2 = chordType.symbol[1]
        
        
        let utils = Utils()
        let notesArray:[[String]] =
            utils.getChordNotesFor(baseNote:basicNote,chordIntvlArray:chordType.intvls)
        chord.notes = notesArray
        appdelegate.saveContext()
        print("inserted")
    }
    
    func db_selectAllChords()->Array<Chord>{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Chords")
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as! [Chord]
            return fetchedResult
        } catch {
            fatalError("Failed to fetch chords: \(error)")
        }
    }
    func db_selectChordWith(keyName:String, chordType:String)->[Chord] {

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Chords")
        fetchRequest.predicate = NSPredicate(format: "keyNote1 = %@ AND cType1 = %@", keyName,chordType)
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as! [Chord]
            return fetchedResult
        } catch {
            fatalError("Failed to fetch chords: \(error)")
        }
    }
    
    
}
