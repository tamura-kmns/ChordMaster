//
//  MainViewController.swift
//  ChordMaster
//
//  Created by KatsuhikoTamura on 2018/07/03.
//  Copyright © 2018年 9bit.co. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,
UITextFieldDelegate,UICollectionViewDataSource {

    @IBOutlet weak var keyButton: UIButton!
    @IBOutlet weak var keyPickerView: UIPickerView!
    @IBOutlet weak var chordCollectionView: UICollectionView!
    var chordArray: [Chord] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        keyPickerView.isHidden = true
        
        let dbAccess = DBAccess()
        let chordsArray = dbAccess.db_selectAllChords()
        for chord:Chord in chordsArray {
            print (chord.keyNote1! + chord.cType1!)

        }
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
        
        chordArray.removeAll()
        let chords = utils.getScaleChordsFor(baseNoteNum: row, scale: DiatonicScaleChords.MAJOR_3)
        for chord in chords{
            print(chord.keyNote1! + chord.cType1!)
            chordArray.append(chord)
        }
        self.chordCollectionView.reloadData()

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chordArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:ChordCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChordCell",
                                                                for: indexPath)  as! ChordCell
        
        
        cell.backgroundColor = UIColor(red: CGFloat(drand48()),
                                       green: CGFloat(drand48()),
                                       blue: CGFloat(drand48()),
                                       alpha: 1.0)
        cell.chordNameLabel.text =
            self.chordArray[indexPath.row].keyNote2! + self.chordArray[indexPath.row].cType1!
        
        /***
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(tapped(_:)))
        
        cell.addGestureRecognizer(tapGesture)
        **/
        return cell
    }
    



}

