//
//  Utils.swift
//  ChordMaster
//
//  Created by KatsuhikoTamura on 2018/07/04.
//  Copyright © 2018年 9bit.co. All rights reserved.
//

import Foundation


public class Utils: NSObject {
    
    /*
    func getChordNotesFor(baseNote:BasicNote_,chordIntvlArray:Array<Int>) -> [[String]]{
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
    */
    
    func getChordsFor(baseNoteNum:Int, chordset:ChordSet)-> [Chord] {
        let dbAccess = DBAccess()
        let maxIndex = NUMBER_OF_KEYS
        var chordArray: [Chord] = []
        var chordSetArray:[(Int,ChordType)] = []
        
        switch (chordset){
        case .DIATONIC_MAJOR_3:
           chordSetArray = majorScaleTriadChords
        case .DIATONIC_MAJOR_4:
            chordSetArray = majorScale4NotesChords
        case .DIATONIC_MINOR_NATURAL_3:
            chordSetArray = minorNaturalTriadChords
        case .DIATONIC_MINOR_HARMONIC_3:
            chordSetArray = minorHarmonicTriadChords
        case .DIATONIC_MINOR_MELODIC_3:
            chordSetArray = minorMelodicTriadChords
        case .DIATONIC_MINOR_NATURAL_4:
            chordSetArray = minorNatural4NotesChords
        case .DIATONIC_MINOR_HARMONIC_4:
            chordSetArray = minorHarmonic4NotesChords
        case .DIATONIC_MINOR_MELODIC_4:
            chordSetArray = minorMelodic4NotesChords
        case .DIATONIC_MINOR_ALL_3:
            chordSetArray = minorAllTriadChords
        case .DIATONIC_MINOR_ALL_4:
            chordSetArray = minorAll4NotesChords
        case .SUBDOMINANT_MINOR:
            break
        }
        
        for (chordNoteNum,chordType) in chordSetArray {
            let noteNum = (baseNoteNum + chordNoteNum) % maxIndex
            let chords:Array<Chord> = dbAccess.db_selectChordWith(keyNoteNumber: noteNum,
                                                                  chordSymbol: chordType.symbol)
            if(chords.count > 0){
                chordArray.append(chords[0]) //TODO optional
            }
        }
        
        return chordArray
    }

}


//////////////////////////// extension ////////////////////////////////////
extension Array {
    mutating func arraySwap(index1: Int, index2: Int) {
        self.swapAt(index1, index2)
    }
}



