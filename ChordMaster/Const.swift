//
//  Const.swift
//  ChordMaster
//
//  Created by KatsuhikoTamura on 2018/07/07.
//  Copyright © 2018年 9bit.co. All rights reserved.
//

import Foundation


let NUMBER_OF_KEYS = 12

let DegreeNumber:[String] = ["I","Ⅱ♭","Ⅱ","Ⅲ♭","Ⅲ","Ⅳ","Ⅴ♭","Ⅴ","Ⅵ♭","Ⅵ","Ⅶ♭","Ⅶ"]

//コード鳴らす時の基準C-4 のallNoteArray内の順番
let BASE_C_NUMBER = 48
//Bass音のC C-3
let BASE_BASS_C_NUMBER = 24


enum ChordSet {
    case DIATONIC_MAJOR_3
    case DIATONIC_MAJOR_4
    case DIATONIC_MINOR_NATURAL_3
    case DIATONIC_MINOR_HARMONIC_3
    case DIATONIC_MINOR_MELODIC_3
    case DIATONIC_MINOR_NATURAL_4
    case DIATONIC_MINOR_HARMONIC_4
    case DIATONIC_MINOR_MELODIC_4
    case DIATONIC_MINOR_ALL_3
    case DIATONIC_MINOR_ALL_4
    
    case SECONDARY_DOMINANT
    case SUBDOMINANT_MINOR
}

enum ViewTag:Int{
    case BASS_PICKERVIEW
    case KEY_PICKERVIEW
}
