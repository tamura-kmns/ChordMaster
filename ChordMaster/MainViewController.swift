//
//  MainViewController.swift
//  ChordMaster
//
//  Created by KatsuhikoTamura on 2018/07/03.
//  Copyright © 2018年 9bit.co. All rights reserved.
//

import UIKit
import AVFoundation

class MainViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,
UITextFieldDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate,AVAudioPlayerDelegate {
    
    @IBOutlet weak var keyButton: UIButton!
    @IBOutlet weak var keyPickerView: UIPickerView!
    @IBOutlet weak var chordCollectionView: UICollectionView!
    
    @IBOutlet weak var chordBarCollectionView: UICollectionView!
    
    let engine = AVAudioEngine()
    
    let NUMBER_OF_CHORD_GROUPS = 5
    
    var allChordsArray: [Chord] = []
    var chordArray_Diatonic3: [Chord] = []
    var chordArray_Diatonic4: [Chord] = []
    var chordArray_NaturalMinor3: [Chord] = []
    var chordArray_NaturalMinor4: [Chord] = []
    
    var chordArray_AllMinor3: [Chord] = []
    var chordArray_AllMinor4: [Chord] = []
    
    var chordBarArray: [Chord] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let dbAccess = DBAccess()
        
        /**test code
         let cod:[Chord] = dbAccess.db_selectChordWith(keyNoteNumber:1, chordSymbol:"7")
         if(cod.count > 0){
         print("code=")
         print((cod[0].baseNote?.eNameF)! + (cod[0].chordBase?.symbol)!)
         }else{
         print("no code")
         }
         ***/
        
        keyPickerView.isHidden = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
        var chords = utils.getChordsFor(baseNoteNum: row, chordset: ChordSet.DIATONIC_MAJOR_3)
        for chord in chords{
            //print((chord.baseNote?.eNameF)! + (chord.chordBase?.symbol)!)
            chordArray_Diatonic3.append(chord)
        }
        //allChordsArray += chordArray_Diatonic3
        
        chordArray_Diatonic4.removeAll()
        chords.removeAll()
        chords = utils.getChordsFor(baseNoteNum: row, chordset: ChordSet.DIATONIC_MAJOR_4)
        for chord in chords{
            //print((chord.baseNote?.eNameF)! + (chord.chordBase?.symbol)!)
            chordArray_Diatonic4.append(chord)
        }
        //allChordsArray += chordArray_Diatonic4
        
        /**
         chordArray_NaturalMinor3.removeAll()
         chords.removeAll()
         chords = utils.getChordsFor(baseNoteNum: row, chordset: ChordSet.DIATONIC_MINOR_NATURAL_3)
         for chord in chords{
         //print((chord.baseNote?.eNameF)! + (chord.chordBase?.symbol)!)
         chordArray_NaturalMinor3.append(chord)
         }
         
         chordArray_NaturalMinor4.removeAll()
         chords.removeAll()
         chords = utils.getChordsFor(baseNoteNum: row, chordset: ChordSet.DIATONIC_MINOR_NATURAL_4)
         for chord in chords{
         //print((chord.baseNote?.eNameF)! + (chord.chordBase?.symbol)!)
         chordArray_NaturalMinor4.append(chord)
         }
         **/
        
        chordArray_AllMinor3.removeAll()
        chords.removeAll()
        chords = utils.getChordsFor(baseNoteNum: row, chordset: ChordSet.DIATONIC_MINOR_ALL_3)
        for chord in chords{
            //print((chord.baseNote?.eNameF)! + (chord.chordBase?.symbol)!)
            chordArray_AllMinor3.append(chord)
        }
        //allChordsArray += chordArray_AllMinor3
        
        chordArray_AllMinor4.removeAll()
        chords.removeAll()
        chords = utils.getChordsFor(baseNoteNum: row, chordset: ChordSet.DIATONIC_MINOR_ALL_4)
        for chord in chords{
            //print((chord.baseNote?.eNameF)! + (chord.chordBase?.symbol)!)
            chordArray_AllMinor4.append(chord)
        }
        // allChordsArray += chordArray_AllMinor4
        
        self.chordCollectionView.reloadData()
    }
    
    
    //////////UICollectionView
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if(collectionView == self.chordCollectionView){
          return NUMBER_OF_CHORD_GROUPS
        }
        else{//chordBarCollectionView
          return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == self.chordCollectionView){
            switch(section) {
            case 0:
                return self.chordArray_Diatonic3.count
            case 1:
                return self.chordArray_Diatonic4.count
            case 2:
                return self.chordArray_AllMinor3.count
            case 3:
                return self.chordArray_AllMinor4.count
            default:
                return 0
            }
        }else {//chordBarCollectionView
            return self.chordBarArray.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(collectionView == self.chordCollectionView){
            let cell:ChordCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChordCell",
                                                                    for: indexPath)  as! ChordCell
            
            switch(indexPath.section){
            case 0:
                cell.chord = self.chordArray_Diatonic3[indexPath.row]
                
                cell.backgroundColor = UIColor(red: CGFloat(drand48()),
                                               green: CGFloat(drand48()),
                                               blue: CGFloat(drand48()),
                                               alpha: 1.0)
            case 1:
                cell.chord = self.chordArray_Diatonic4[indexPath.row]
                
                cell.backgroundColor = UIColor(red: CGFloat(drand48()),
                                               green: CGFloat(drand48()),
                                               blue: CGFloat(drand48()),
                                               alpha: 1.0)
                
            case 2:
                cell.chord = self.chordArray_AllMinor3[indexPath.row]
                
                cell.backgroundColor = UIColor(red: CGFloat(drand48()),
                                               green: CGFloat(drand48()),
                                               blue: CGFloat(drand48()),
                                               alpha: 1.0)
            case 3:
                cell.chord = self.chordArray_AllMinor4[indexPath.row]
                
                cell.backgroundColor = UIColor(red: CGFloat(drand48()),
                                               green: CGFloat(drand48()),
                                               blue: CGFloat(drand48()),
                                               alpha: 1.0)
                
            default:
                break;
            }
            
            cell.chordNameLabel.text = (cell.chord?.baseNote?.eNameF)! + (cell.chord?.chordBase?.symbol)!
            
            let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped(_:)))
            doubleTap.numberOfTapsRequired = 2
            cell.addGestureRecognizer(doubleTap)
            
            let singleTap = UITapGestureRecognizer(target: self, action: #selector(singleTapped(_:)))
            singleTap.numberOfTapsRequired = 1
            singleTap.require(toFail: doubleTap)
            cell.addGestureRecognizer(singleTap)
            
            return cell
        }
        ///////////////////////////////////////////////////////////////////////////////////////////////
        else { ///chordCollectionView

            let cell:ChordBarCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChordBarCell",
                                                                    for: indexPath)  as! ChordBarCell
            cell.backgroundColor = UIColor(red: CGFloat(drand48()),
                                           green: CGFloat(drand48()),
                                           blue: CGFloat(drand48()),
                                           alpha: 1.0)
            cell.chord = self.chordBarArray[indexPath.row]
            cell.chordNameLabel.text = (cell.chord?.baseNote?.eNameF)! + (cell.chord?.chordBase?.symbol)!
            return cell
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let identifier: String
        let bgColor: UIColor
        
        if kind == UICollectionElementKindSectionHeader {
            identifier = "Header"
            bgColor = .blue
        } else {
            identifier = "Footer"
            bgColor = .yellow
        }
        
        let supplement = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: indexPath)
        supplement.backgroundColor = bgColor
        
        return supplement
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        return CGSize(width: collectionView.bounds.width, height: 20)
    }

    
    
    
    @objc func singleTapped(_ sender: UITapGestureRecognizer){
        
        print("tapped,,,")
        
        playChord(chord: (sender.view as! ChordCell).chord!)
        
    }
    
    @objc func doubleTapped(_ sender: UITapGestureRecognizer){
        
        print("double tapped,,,")
        chordBarArray.append((sender.view as! ChordCell).chord!)
        chordBarCollectionView.reloadData()
        
    }
    
    
    func playChord(chord:Chord){
        let baseNoteNum = Int16(BASE_C_NUMBER) + (chord.baseNote?.noteNumber)!
        var audioPlayers:[AVAudioPlayerNode] = []
        for noteNum:Int in (chord.chordBase?.intvls)! {
            let playNoteNum = (baseNoteNum + Int16(noteNum))
            let player = AVAudioPlayerNode()
            
            let filePath = Bundle.main.path(forResource: allNoteFileNameArray[Int(playNoteNum)], ofType: "mp3")!
            let fileURL = URL(fileURLWithPath: filePath)
            if let audioFile = try? AVAudioFile(forReading: fileURL) {
                engine.attach(player)
                engine.connect(player, to: engine.mainMixerNode, format: audioFile.processingFormat)
                player.scheduleFile(audioFile, at: nil, completionHandler: nil)
                audioPlayers.append(player)
            }
        }
        try? engine.start()
        for player in audioPlayers {
            player.play()
        }
        
    }
    
}

