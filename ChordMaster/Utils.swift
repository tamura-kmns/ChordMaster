//
//  Utils.swift
//  ChordMaster
//
//  Created by KatsuhikoTamura on 2018/07/04.
//  Copyright © 2018年 9bit.co. All rights reserved.
//

import Foundation


public class Utils: NSObject {
    
    
    func getChordNotesFor(baseNote:BasicNote,chordIntvlArray:Array<Int>) -> [[String]]{
        var noteArray: [[String]] = []
        var baseN: Int = 0;
        for note in base12NoteArray {
            if (note.eName[0] == baseNote.eName[0]){
                break
            }
            baseN += 1
        }
        let maxIndex = base12NoteArray.count
        for i in chordIntvlArray {
            noteArray.append(base12NoteArray[(baseN + i) % maxIndex].eName)  //eNameのみを選択
        }
        return noteArray;
    }
    
    func getDiatonicMajor3NotesChords(baseNoteNum:Int)-> [Chord] {
        let dbAccess = DBAccess()
        let maxIndex = base12NoteArray.count
        var chordArray: [Chord] = []
        
        for (chordNoteNum,chordType) in majorScale3NotesChords {
            var note = base12NoteArray[(baseNoteNum + chordNoteNum) % maxIndex]
            
            let chords:Array<Chord> = dbAccess.db_selectChordWith(keyName: note.eName[0],
                                                                  chordType: chordType.symbol[0])
            if(chords.count > 0){
                print("get")
                print(chordArray.append(chords[0]))
                chordArray.append(chords[0]) //TODO optional
            }
        }
        return chordArray
    }
}
