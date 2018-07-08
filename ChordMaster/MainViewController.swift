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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        keyPickerView.isHidden = true
        
        let dbAccess = DBAccess()
        let chordsArray = dbAccess.db_selectAllChords()
        for chord:Chord in chordsArray {
            print (chord.keyNote![0] + chord.cType![0])

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
        let chords = utils.getDiatonicMajor3NotesChords(baseNoteNum: row)
        print(chords.count)

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell! {
        return nil
    }
    



}

