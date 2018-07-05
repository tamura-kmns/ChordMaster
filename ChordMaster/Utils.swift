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
        var noteArray:[[String]] = []
        var baseN:Int = 0;
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
}
