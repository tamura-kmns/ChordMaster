//
//  ChordCell.swift
//  ChordMaster
//
//  Created by KatsuhikoTamura on 2018/07/09.
//  Copyright © 2018年 9bit.co. All rights reserved.
//

import UIKit

class ChordCell : UICollectionViewCell{
    
    
    @IBOutlet weak var chordNameLabel: UILabel!
    
    //var chord:Chord
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
}
