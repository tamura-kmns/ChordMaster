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
    func getChordNotesFor(baseNote:BasicNote,chordIntvlArray:Array<Int>) -> [BasicNote]{
        var noteArray: [BasicNote] = []
        var baseN: Int = 0;
        for note in base12NoteArray {
            if (note.eNameF == baseNote.eNameF){
                break
            }
            baseN += 1
        }
        let maxIndex = base12NoteArray.count
        for i in chordIntvlArray {
            noteArray.append( base12NoteArray[(baseN + i) % maxIndex] )  //eNameのみを選択
        }
        return noteArray;
    }
    */
    func getChordNotesFor(chord:Chord) -> [BasicNote]{
        var noteArray: [BasicNote] = []

        for memberNum:Int in (chord.chordBase?.intvls)! {
            let noteNum = Int(((chord.baseNote?.noteNumber)! + Int16(memberNum)))
            noteArray.append( base12NoteArray[noteNum % NUMBER_OF_KEYS] )  //eNameのみを選択
        }
        return noteArray;
    }
    
    
    func getChordsFor(baseNoteNum:Int, chordset:ChordSet)-> [Chord] {
        let dbAccess = DBAccess()
        let maxIndex = NUMBER_OF_KEYS
        var chordArray: [Chord] = []
        var chordSetArray:[(Int,ChordType,Int)] = []
        
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
        
        for (chordNoteNum,chordType,degree) in chordSetArray {
            let noteNum = (baseNoteNum + chordNoteNum) % maxIndex
            let chords:Array<Chord> = dbAccess.db_selectChordWith(keyNoteNumber: noteNum,
                                                                  chordSymbol: chordType.symbol)
            if(chords.count > 0){
                let chord = chords[0]
                chord.degreeInKey = Int16(degree)
                chordArray.append(chord) //TODO optional
            }
        }
        
        return chordArray
    }
    
    
    func inverse_high(chord:inout Chord){
        let noteCount:Int = (chord.chordBase?.intvls?.count)!
        for i in 0..<noteCount-1 {
            chord.chordBase?.intvls?.arraySwap(index1: i, index2: i+1)
        }
        chord.chordBase?.intvls?[noteCount-1] = (chord.chordBase?.intvls?[noteCount-1])! + 12
    }
    
    func inverse_low(chord:inout Chord) {
        let noteCount:Int = (chord.chordBase?.intvls?.count)! 
        for i in (1..<noteCount).reversed() {
            chord.chordBase?.intvls?.arraySwap(index1: i, index2: i-1)
        }
        chord.chordBase?.intvls?[0] = (chord.chordBase?.intvls?[0])! - 12
    }
    
    
    func getNotesOfChord(chord:Chord)->[BasicNote] {
        
        var noteArray: [BasicNote] = []
        let baseNoteNum = Int16(BASE_C_NUMBER) + (chord.baseNote?.noteNumber)! //TODO 変更の必要
    
        for i in (chord.chordBase?.intvls)! {
            noteArray.append(allNoteArray[Int(baseNoteNum + Int16(i))].basicNote)
        }
        return noteArray;
 
    }

}

//////////////////////////////////////////////////////////////////////////////////////////////////









//////////////////////////// extension ////////////////////////////////////
extension Array {
    mutating func arraySwap(index1: Int, index2: Int) {
        self.swapAt(index1, index2)
    }
}



