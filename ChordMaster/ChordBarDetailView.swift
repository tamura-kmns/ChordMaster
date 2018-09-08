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
    @IBOutlet weak var bassPickerView: UIPickerView!
    @IBOutlet weak var bassDegreeLabel: UILabel!
    
    
    let utils = Utils()
    
    
    func setDetails(chord: Chord, bassNote: BasicNote, keyNumber:Int){
        self.setChordNotes(chord: chord,bassNote: bassNote,inKey: keyNumber)
        self.setBassPiker(bassNote: bassNote, inKey:keyNumber)
        self.showDegree(chord: chord,bassNote: bassNote, inKey: keyNumber)
        
    }
    
    func setChordNotes(chord: Chord ,bassNote: BasicNote,inKey:Int){
        let chordNotes = utils.getNotesOfChord(chord:chord)
        var notesString:String = ""
        for note:BasicNote in chordNotes {
            notesString.append(note.eNameF!)
            notesString.append(" ")
        }
        self.chordNotesLabel.text = notesString + "/"
    }
    
    func showDegree(chord: Chord,bassNote: BasicNote,inKey:Int) {
        self.degreeLabel.text = DegreeNumber[utils.getDegreeInKey(note:chord.baseNote!,keyNumber:inKey)]
        self.setBassDegreeLabel(bassNote:bassNote,inKey:inKey)
    }
    
    func setBassPiker(bassNote: BasicNote, inKey:Int){
        self.bassPickerView.selectRow(Int(bassNote.noteNumber), inComponent: 0, animated: false)
    }
    
    func setBassDegreeLabel(bassNote: BasicNote,inKey:Int) {
       self.bassDegreeLabel.text = DegreeNumber[utils.getDegreeInKey(note:bassNote,keyNumber:inKey)]
    }

}
