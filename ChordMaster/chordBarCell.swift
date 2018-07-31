//
//  chordBarCell.swift
//  ChordMaster
//
//  Created by KatsuhikoTamura on 2018/08/01.
//  Copyright © 2018年 9bit.co. All rights reserved.
//

import Foundation

import UIKit

class ChordBarCell : UICollectionViewCell{
    
     @IBOutlet weak var chordNameLabel: UILabel!

    var chord:Chord? = nil
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
}
