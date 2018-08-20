//
//  ChordDetailView.swift
//  ChordMaster
//
//  Created by KatsuhikoTamura on 2018/08/13.
//  Copyright © 2018年 9bit.co. All rights reserved.
//

import UIKit

class ChordDetailView: UIView {
    
    @IBOutlet weak var chordNotesLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var bassPickerView: UIPickerView!
    
    
    let utils = Utils()
    
    func setDetails(chord: Chord, bassNote: BasicNote){
        self.setChordNotes(chord: chord)
        self.showDegree(chord: chord)
        
    }
    
    func setChordNotes(chord: Chord){
        
        let chordNotes = utils.getNotesOfChord(chord:chord)
        
        var notesString:String = ""
        for note:BasicNote in chordNotes {
            notesString.append(note.eNameF!)
            notesString.append(" ")
        }
        self.chordNotesLabel.text = notesString

    }
    
    func showDegree(chord: Chord) {
        self.degreeLabel.text = DegreeNumber[Int(chord.degreeInKey)]
    }
    
}
