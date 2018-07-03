//
//  ViewController.swift
//  ChordMaster
//
//  Created by KatsuhikoTamura on 2018/07/03.
//  Copyright © 2018年 9bit.co. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    var managedContext:NSManagedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("init")

        init12Notes()
        initAllNotes()
        
        managedContext = appdelegate.persistentContainer.viewContext
        
        makeChordTable()
        
        /**********************
        let entity = NSEntityDescription.entity(forEntityName:"BasicNote", in: managedObjectContext)
        // データ追加
        var chordBase = ChordBase(entity:entity!,insertInto:managedObjectContext)
        chordBase.intvls = [0,3,6]
        chordBase.kName = "メジャー"
        chordBase.cName = "major"
        chordBase.symbol = ""
        chordBase.symbol2 = "maj"
        do{
            try managedObjectContext.save()
        }catch{
            
        }
        chordBase = ChordBase(entity:entity!,insertInto:managedObjectContext)
        chordBase.intvls = [0,3,6]
        chordBase.kName = "マイナー"
        chordBase.cName = "minor"
        chordBase.symbol = "m"
        chordBase.symbol2 = "min"
        do{
            try managedObjectContext.save()
        }catch{
            
        }
        print("ok")
       ******************/
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //12音生成
    func init12Notes(){
        for i in 0..<12 {
            base12NoteArray.append(BasicNote (num: i))
        }
    }
    //全noteテーブル(鍵盤)生成
    func initAllNotes() {
        for i in 0...127 {
            allNotesArray.append(Note(noteNum: i) )
        }
    }
    
    func makeChordTable(){
        for note in base12NoteArray {
            for chord in chordArray {
                db_insertChord(basicNote:note,chordType:chord)
                print("insert")
            }
        }
    }
    
    func db_insertChord(basicNote:BasicNote, chordType:ChordType){
        let chords = NSEntityDescription.insertNewObject(forEntityName: "Chords",
                                                         into: self.managedContext) as! Chords
        chords.keyNote = basicNote.eName
        chords.cName = chordType.symbol
        
        
        
        self.appdelegate.saveContext()
    }
    





}

