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
    
    func getDiatonicChordsFor(baseNoteNum:Int, chordset:ChordSet)-> [Chord] {
        let dbAccess = DBAccess()
        let maxIndex = base12NoteArray.count
        var chordArray: [Chord] = []
        var scaleArray:[(Int,ChordType)] = []
        
        switch (chordset){
        case .DIATONIC_MAJOR_3:
           scaleArray = majorScaleTriadChords
        case .DIATONIC_MAJOR_4:
            scaleArray = majorScale4NotesChords
        case .DIATONIC_MINOR_NATURAL_3:
            scaleArray = minorNaturalTriadChords
        case .DIATONIC_MINOR_HARMONIC_3:
            scaleArray = minorHarmonicTriadChords
        case .DIATONIC_MINOR_MELODIC_3:
            scaleArray = minorMelodicTriadChords
        case .DIATONIC_MINOR_NATURAL_4:
            scaleArray = minorNatural4NotesChords
        case .DIATONIC_MINOR_HARMONIC_4:
            scaleArray = minorHarmonic4NotesChords
        case .DIATONIC_MINOR_MELODIC_4:
            scaleArray = minorMelodic4NotesChords
        case .DIATONIC_MINOR_ALL_3:
            scaleArray = minorAllTriadChords
        case .DIATONIC_MINOR_ALL_4:
            scaleArray = minorAll4NotesChords
        case .SUBDOMINANT_MINOR:
            break
        }
        
        
        for (chordNoteNum,chordType) in scaleArray {
            var note = base12NoteArray[(baseNoteNum + chordNoteNum) % maxIndex]
            
            let chords:Array<Chord> = dbAccess.db_selectChordWith(keyName: note.eName[0],
                                                                  chordType: chordType.symbol[0])
            if(chords.count > 0){
                chordArray.append(chords[0]) //TODO optional
            }
        }
        return chordArray
    }
}



