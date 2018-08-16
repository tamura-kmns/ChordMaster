//
//  ChordBarDetailView.swift
//  ChordMaster
//
//  Created by KatsuhikoTamura on 2018/08/16.
//  Copyright © 2018年 9bit.co. All rights reserved.
//

import UIKit

class ChordBarDetailView: UIView {
    
    @IBOutlet weak var chordNotesLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!

    
    let utils = Utils()
    
    func setDetails(chord: Chord, bassNote: BasicNote){
        self.setChordNotes(chord: chord,bassNote: bassNote)
        self.showDegree(chord: chord,bassNote: bassNote)
    }
    
    func setChordNotes(chord: Chord ,bassNote: BasicNote){
        
        let chordNotes = utils.getNotesOfChord(chord:chord)
        
        var notesString:String = ""
        for note:BasicNote in chordNotes {
            notesString.append(note.eNameF!)
            notesString.append(" ")
        }
        self.chordNotesLabel.text = notesString + " / " + bassNote.eNameS!
        
        
    }
    
    func showDegree(chord: Chord,bassNote: BasicNote) {
        self.degreeLabel.text = DegreeNumber[Int(chord.degreeInKey)]
            + " / " + DegreeNumber[Int(bassNote.noteNumber)]
    }
    
    
    
    
    
    
    
    
}
