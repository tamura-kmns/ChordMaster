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
    @IBOutlet weak var chordDetailView: ChordDetailView!
    @IBOutlet weak var chordBarDetailView: ChordBarDetailView!
    
    let utils = Utils()
    let player = Player()
    
    let NUMBER_OF_CHORD_GROUPS = 5
    
    var allChordsArray: [Chord] = []
    var chordArray_Diatonic3: [Chord] = []
    var chordArray_Diatonic4: [Chord] = []
    var chordArray_NaturalMinor3: [Chord] = []
    var chordArray_NaturalMinor4: [Chord] = []
    
    var chordArray_AllMinor3: [Chord] = []
    var chordArray_AllMinor4: [Chord] = []
    
    var chordBarArray: [(chord:Chord, bass:BasicNote, key:Int)] = []
    
    var selectedChordBarIndexPath: NSIndexPath? = nil
    var selectedBarChordNum: Int = 0
    var currentKeyNumber: Int = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let longPressGesture = UILongPressGestureRecognizer(target: self,
                                                            action:#selector(self.handleLongGesture(gesture:)))
        chordBarCollectionView.addGestureRecognizer(longPressGesture)
        
        self.keyPickerView.isHidden = true
        
        self.keyPickerView.tag = ViewTag.KEY_PICKERVIEW.rawValue
        
        chordBarDetailView.bassPickerView.dataSource = self
        chordBarDetailView.bassPickerView.delegate = self
        chordBarDetailView.bassPickerView.tag = ViewTag.BASS_PICKERVIEW.rawValue
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showKeyPickerView(_ sender: UIButton) {
        self.keyPickerView.isHidden = false;
    }
    
    
    /////////////////////  UIPicekerViewDelegate //////////////////////////////
    
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
        if (ViewTag.KEY_PICKERVIEW.rawValue == pickerView.tag) {
            self.currentKeyNumber = row
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
                chordArray_AllMinor3.append(chord)
            }
            //allChordsArray += chordArray_AllMinor3
            
            chordArray_AllMinor4.removeAll()
            chords.removeAll()
            chords = utils.getChordsFor(baseNoteNum: row, chordset: ChordSet.DIATONIC_MINOR_ALL_4)
            for chord in chords{
                chordArray_AllMinor4.append(chord)
            }
            // allChordsArray += chordArray_AllMinor4
            self.chordCollectionView.reloadData()
            
        }else if (ViewTag.BASS_PICKERVIEW.rawValue == pickerView.tag) {
            
            self.chordBarArray[self.selectedBarChordNum].bass = base12NoteArray[row]
            self.chordBarDetailView.setBassDegreeLabel(bassNote: chordBarArray[self.selectedBarChordNum].bass
                ,inKey:chordBarArray[self.selectedBarChordNum].key)
            self.chordBarCollectionView.reloadItems(at: [self.selectedChordBarIndexPath! as IndexPath])

        }
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
                
                cell.backgroundColor = UIColor.cyan
            case 1:
                cell.chord = self.chordArray_Diatonic4[indexPath.row]
                
                cell.backgroundColor = UIColor.blue
                
            case 2:
                cell.chord = self.chordArray_AllMinor3[indexPath.row]
                
                cell.backgroundColor = UIColor.yellow
            case 3:
                cell.chord = self.chordArray_AllMinor4[indexPath.row]
                
                cell.backgroundColor = UIColor.orange
                
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
            
            let longPress = UILongPressGestureRecognizer(target: self, action: #selector(logPressedChordCell(_:)))
            cell.addGestureRecognizer(longPress)
    
            let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipedChordCell(_:)))
            rightSwipe.direction = .right
            cell.addGestureRecognizer(rightSwipe)
            
            let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipedChordCell(_:)))
            leftSwipe.direction = .left
            cell.addGestureRecognizer(leftSwipe)
            
            
            
            return cell
        }
        ///////////////////////////////////////////////////////////////////////////////////////////////
        else { ///chordBarCollectionView

            let cell:ChordBarCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChordBarCell",
                                                                    for: indexPath)  as! ChordBarCell
            cell.indexPath = indexPath
            cell.backgroundColor = UIColor.green
            
            cell.chord = self.chordBarArray[indexPath.row].chord
            cell.bassNote = self.chordBarArray[indexPath.row].bass
            cell.inKey = self.chordBarArray[indexPath.row].key
    
            
            cell.chordNameLabel.text = (cell.chord?.baseNote?.eNameF)! + (cell.chord?.chordBase?.symbol)!
            cell.bassLabel.text = cell.bassNote?.eNameF
            
            let doubleTap_BarChord = UITapGestureRecognizer(target: self, action: #selector(doubleTapped_BarChord(_:)))
            doubleTap_BarChord.numberOfTapsRequired = 2
            cell.addGestureRecognizer(doubleTap_BarChord)
            
            let singleTap =
                UITapGestureRecognizer(target: self, action: #selector(singleTapped_BarChord(_:)))
            singleTap.numberOfTapsRequired = 1
            singleTap.require(toFail: doubleTap_BarChord)
            cell.addGestureRecognizer(singleTap)
            
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
    
    func collectionView(_ collectionView: UICollectionView,
                        moveItemAt sourceIndexPath: IndexPath,
                        to destinationIndexPath: IndexPath) {
        
        let tempNumber = self.chordBarArray.remove(at: sourceIndexPath.item)
        self.chordBarArray.insert(tempNumber, at: destinationIndexPath.item)
    }


    @objc func singleTapped(_ sender: UITapGestureRecognizer){
        self.chordDetailView.setDetails(chord: (sender.view as! ChordCell).chord!,
                                        bassNote: (sender.view as! ChordCell).chord!.baseNote!)
        player.playChord(chord: (sender.view as! ChordCell).chord!,
                         bassNote:(sender.view as! ChordCell).chord!.baseNote!)
    }
    
    @objc func doubleTapped(_ sender: UITapGestureRecognizer){
        chordBarArray.append( ((sender.view as! ChordCell).chord!,
                               (sender.view as! ChordCell).chord!.baseNote!,
                               self.currentKeyNumber)
        )
        chordBarCollectionView.reloadData()
    }
    
    @objc func singleTapped_BarChord(_ sender: UITapGestureRecognizer){
        player.playChord(chord: (sender.view as! ChordBarCell).chord!,
                         bassNote: (sender.view as! ChordBarCell).bassNote!)
        //save the selecting cell's row number (indexPath)
        let path: NSIndexPath = chordBarCollectionView.indexPath(for: sender.view as! ChordBarCell)! as NSIndexPath
        self.selectedChordBarIndexPath = path
        self.selectedBarChordNum = path.row
        self.chordBarDetailView.setDetails(chord: (sender.view as! ChordBarCell).chord!,
                                        bassNote:(sender.view as! ChordBarCell).bassNote!,
                                        keyNumber:(sender.view as! ChordBarCell).inKey)
    
    }
    
    @objc func doubleTapped_BarChord(_ sender: UITapGestureRecognizer){
        
        self.chordBarArray.remove(at: ((sender.view as! ChordBarCell).indexPath?.row)!)
        chordBarCollectionView.deleteItems(at: [(sender.view as! ChordBarCell).indexPath!])
        
        //chordBarCollectionView.reloadData()
        
    }
    
    @objc func logPressedChordCell(_ sender: UILongPressGestureRecognizer){
        if (sender.state == UIGestureRecognizerState.began) {
            print("longPressed")
            //showChordDetails(chord: (sender.view as! ChordCell).chord!)
        }
    }
    
    @objc func swipedChordCell(_ sender: UISwipeGestureRecognizer) {
        
        if sender.direction == .right {
            print("Right")
            utils.inverse_high(chord: &(sender.view as! ChordCell).chord! )
        }
        else if sender.direction == .left {
            print("Left")
            utils.inverse_low(chord: &(sender.view as! ChordCell).chord! )
        }
        self.chordDetailView.setChordNotes(chord: (sender.view as! ChordCell).chord!)
    }
    
    
    @objc func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        
        switch(gesture.state) {
            
        case UIGestureRecognizerState.began:
            guard let selectedIndexPath = chordBarCollectionView.indexPathForItem(
                at: gesture.location(in: chordBarCollectionView)) else {
                    break
            }
            chordBarCollectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
            
        case UIGestureRecognizerState.changed:
            chordBarCollectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
            
        case UIGestureRecognizerState.ended:
            chordBarCollectionView.endInteractiveMovement()
            
        default:
            chordBarCollectionView.cancelInteractiveMovement()
        }
    }
    

    

}

