//
//  MainViewController.swift
//  ChordMaster
//
//  Created by KatsuhikoTamura on 2018/07/03.
//  Copyright © 2018年 9bit.co. All rights reserved.
//

import UIKit
import AVFoundation

class MainViewController: UIViewController/*,UIPickerViewDelegate,UIPickerViewDataSource,
UITextFieldDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate */{
/*
    @IBOutlet weak var keyButton: UIButton!
    @IBOutlet weak var keyPickerView: UIPickerView!
    @IBOutlet weak var chordCollectionView: UICollectionView!
*/
    let engine = AVAudioEngine()
    
    var allChordsArray: [Chord] = []
    var chordArray_Diatonic3: [Chord] = []
    var chordArray_Diatonic4: [Chord] = []
    var chordArray_NaturalMinor3: [Chord] = []
    var chordArray_NaturalMinor4: [Chord] = []
    
    var chordArray_AllMinor3: [Chord] = []
    var chordArray_AllMinor4: [Chord] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let dbAccess = DBAccess()
        
        let cod:[Chord] = dbAccess.db_selectChordWith(keyNoteNumber:1, chordSymbol:"7")
        if(cod.count > 0){
            print("code=")
            print((cod[0].baseNote?.eNameF)! + (cod[0].chordBase?.symbol)!)
        }else{
            print("no code")
        }
       // keyPickerView.isHidden = true

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    @IBAction func showKeyPickerView(_ sender: UIButton) {
        self.keyPickerView.isHidden = false;
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
 
        let utils = Utils()
        self.allChordsArray.removeAll()
        
        chordArray_Diatonic3.removeAll()
        var chords = utils.getDiatonicChordsFor(baseNoteNum: row, chordset: ChordSet.DIATONIC_MAJOR_3)
        for chord in chords{
            print(chord.keyNote1! + chord.cType1!)
            chordArray_Diatonic3.append(chord)
        }
        allChordsArray += chordArray_Diatonic3
        
        chordArray_Diatonic4.removeAll()
        chords.removeAll()
        chords = utils.getDiatonicChordsFor(baseNoteNum: row, chordset: ChordSet.DIATONIC_MAJOR_4)
        for chord in chords{
            print(chord.keyNote1! + chord.cType1!)
            chordArray_Diatonic4.append(chord)
        }
        allChordsArray += chordArray_Diatonic4
        
        chordArray_NaturalMinor3.removeAll()
        chords.removeAll()
        chords = utils.getDiatonicChordsFor(baseNoteNum: row, chordset: ChordSet.DIATONIC_MINOR_NATURAL_3)
        for chord in chords{
            print(chord.keyNote1! + chord.cType1!)
            chordArray_NaturalMinor3.append(chord)
        }
        
        chordArray_NaturalMinor4.removeAll()
        chords.removeAll()
        chords = utils.getDiatonicChordsFor(baseNoteNum: row, chordset: ChordSet.DIATONIC_MINOR_NATURAL_4)
        for chord in chords{
            print(chord.keyNote1! + chord.cType1!)
            chordArray_NaturalMinor4.append(chord)
        }
        
        chordArray_AllMinor3.removeAll()
        chords.removeAll()
        chords = utils.getDiatonicChordsFor(baseNoteNum: row, chordset: ChordSet.DIATONIC_MINOR_ALL_3)
        for chord in chords{
            print(chord.keyNote1! + chord.cType1!)
            chordArray_AllMinor3.append(chord)
        }
        allChordsArray += chordArray_AllMinor3
        
        chordArray_AllMinor4.removeAll()
        chords.removeAll()
        chords = utils.getDiatonicChordsFor(baseNoteNum: row, chordset: ChordSet.DIATONIC_MINOR_ALL_4)
        for chord in chords{
            print(chord.keyNote1! + chord.cType1!)
            chordArray_AllMinor4.append(chord)
        }
        allChordsArray += chordArray_AllMinor4
        
 
        self.chordCollectionView.reloadData()


    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return allChordsArray.count
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:ChordCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChordCell",
                                                                for: indexPath)  as! ChordCell
        
        //cell.chord = self.allChordsArray[indexPath.row]
 
        cell.backgroundColor = UIColor(red: CGFloat(drand48()),
                                       green: CGFloat(drand48()),
                                       blue: CGFloat(drand48()),
                                       alpha: 1.0)
        cell.chordNameLabel.text = cell.chord.keyNote2! + cell.chord.cType1!
        
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(tapped(_:)))
        
        cell.addGestureRecognizer(tapGesture)
        return cell
    }
    
    
    @objc func tapped(_ sender: UITapGestureRecognizer){
        
        print("tapped,,,")
        
        //playChord(chord: (sender.view as! ChordCell).chord)

    }
    
    func playChord(chord:Chord){

        let player1 = AVAudioPlayerNode()
        let player2 = AVAudioPlayerNode()
        if let path1 = Bundle.main.path(forResource: "do", ofType: "mp3"), let path2 = Bundle.main.path(forResource: "mi", ofType: "mp3") {
            let url1 = URL(fileURLWithPath: path1)
            let url2 = URL(fileURLWithPath: path2)
            
            if let file1 = try? AVAudioFile(forReading: url1), let file2 = try? AVAudioFile(forReading: url2) {
                engine.attach(player1)
                engine.attach(player2)
                engine.connect(player1, to: engine.mainMixerNode, format: file1.processingFormat)
                engine.connect(player2, to: engine.mainMixerNode, format: file2.processingFormat)
                player1.scheduleFile(file1, at: nil, completionHandler: nil)
                player2.scheduleFile(file2, at: nil, completionHandler: nil)
                try? engine.start()
                player1.play()
                player2.play()
            }
        }
       */
    

}

