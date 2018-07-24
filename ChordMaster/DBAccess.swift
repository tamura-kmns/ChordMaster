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
    
    func db_insertBaseNote(eNameF:String,
                           eNameS:String,
                           iNameF:String,
                           iNameS:String,
                           jNameF:String,
                           jNameS:String,
                           noteNumber:Int){
        
        let basenote = NSEntityDescription.insertNewObject(forEntityName: "BasicNote", into: managedContext) as! BasicNote
        basenote.eNameF = eNameF
        basenote.eNameS = eNameS
        basenote.iNameF = iNameF
        basenote.iNameS = iNameS
        basenote.jNameF = jNameF
        basenote.jNameS = jNameS
        basenote.noteNumber = Int16(noteNumber)
        appdelegate.saveContext()
        print("inserted basenote")
    }
    
    
    func db_insertChordBase(name:String,
                            jName:String,
                            kName:String,
                            symbol:String,
                            symbol2:String,
                            intvls:Array<Int>){
        
        let chordbase = NSEntityDescription.insertNewObject(forEntityName: "ChordBase", into: managedContext) as! ChordBase
        chordbase.cName = name
        chordbase.jName = jName
        chordbase.kName = kName
        chordbase.symbol = symbol
        chordbase.symbol2 = symbol2
        chordbase.intvls = intvls
        
        appdelegate.saveContext()
        print("inserted chordbase")
    }

    func db_insertChord(chordNum:Int, noteNumber:Int, chordSymbol:String){
        let chord = NSEntityDescription.insertNewObject(forEntityName: "Chord",
                                                         into: self.managedContext) as! Chord
        chord.num = Int16(chordNum)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BasicNote")
        fetchRequest.predicate = NSPredicate(format:"noteNumber = %d", noteNumber)
        do {
            let result = try managedContext.fetch(fetchRequest) as? [BasicNote]
            if(result!.count > 0) {
                chord.baseNote = result![0]
            }else{
                print("no basicnote found")
            }
        }catch {
            print(error)
        }
        let fetchRequest2 = NSFetchRequest<NSFetchRequestResult>(entityName: "ChordBase")
        fetchRequest2.predicate = NSPredicate(format:"symbol = %@", chordSymbol)
        do {

            let result2 = try managedContext.fetch(fetchRequest2) as? [ChordBase]
            if(result2!.count > 0) {
                chord.chordBase = result2![0]
            }
            else{
                print("no ChordBase found")
            }
        }catch {
            print(error)
        }
        
        appdelegate.saveContext()
        
        
        print("inserted")
    }

    func db_countChords()->Int?{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Chord")
        do {
            let count = try managedContext.count(for: fetchRequest)
            return count
            
        } catch {
            return nil //
        }
    }
    
    func db_selectAllChords()->Array<Chord>{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Chord")
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as! [Chord]
            return fetchedResult
        } catch {
            fatalError("Failed to fetch chords: \(error)")
        }
    }

    func db_selectChordWith(keyNoteNumber:Int, chordSymbol:String)->[Chord] {

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Chord")
        fetchRequest.predicate = NSPredicate(format: "baseNote.noteNumber = %d AND chordBase.symbol = %@", keyNoteNumber,chordSymbol)
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as! [Chord]
            return fetchedResult
        } catch {
            fatalError("Failed to fetch chords: \(error)")
        }
    }

    
    
}
