//
//  ChordBarDetailView.swift
//  ChordMaster
//
//  Created by KatsuhikoTamura on 2018/08/16.
//  Copyright © 2018年 9bit.co. All rights reserved.
//

import UIKit

class ChordBarDetailView: UIView,UIPickerViewDelegate,UIPickerViewDataSource {
 
    @IBOutlet weak var chordNotesLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var bassPickerView: UIPickerView!
    
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
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return NUMBER_OF_KEYS
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return eNameFlatArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    
    
    
    
    
    
}
