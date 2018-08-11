//
//  Notes.swift
//  Chordworks
//
//  Created by KatsuhikoTamura on 2016/11/25.
//  Copyright © 2016年 9bit.co. All rights reserved.
//

import Foundation

///音名配列
let eNameSharpArray = ["C","C#","D","D#","E","F","F#","G","G#","A","A#","B"];
let eNameFlatArray = ["C","D♭","D","E♭","E","F","G♭","G","A♭","A","B♭","B"];
let iNameSharpArray = ["ド","ド#","レ","レ#","ミ","ファ","ファ#","ソ","ソ#","ラ","ラ","シ"];
let iNameFlatArray = ["ド","ラ♭","レ","ミ♭","ミ","ファ","ソ♭","ソ","ラ♭","ラ","シ♭","シ"];
let jNameSharpArray = ["ハ","嬰ハ","二","変ホ","ホ","へ","嬰へ","ト","変イ","イ","変ロ","ロ"];
let jNameFlatArray = ["ハ","嬰ハ","二","変ホ","ホ","へ","嬰へ","ト","変イ","イ","変ロ","ロ"];

//let noteNameArray = [("C","ド","ハ"),("C#","ド#","嬰ハ")]

////12noteのBasicNotインスタンスの配列  DBより取得する
var base12NoteArray = [BasicNote]()

var allNoteArray:[allNote] = []

///全note sound file名 配列
var allNoteFileNameArray = ["0-0","0-1","0-2","0-3","0-4","0-5","0-6","0-7","0-8","0-9","0-10","0-11",
                     "1-0","1-1","1-2","1-3","1-4","1-5","1-6","1-7","1-8","1-9","1-10","1-11",
                     "2-0","2-1","2-2","2-3","2-4","2-5","2-6","2-7","2-8","2-9","2-10","2-11",
                     "3-0","3-1","3-2","3-3","3-4","3-5","3-6","3-7","3-8","3-9","3-10","3-11",
                     "4-0","4-1","4-2","4-3","4-4","4-5","4-6","4-7","4-8","4-9","4-10","4-11",
                     "5-0","5-1","5-2","5-3","5-4","5-5","5-6","5-7","5-8","5-9","5-10","5-11",
                     "6-0","6-1","6-2","6-3","6-4","6-5","6-6","6-7","6-8","6-9","6-10","6-11"]



//全note 鍵盤88音 + 低音8
struct allNote {
    let basicNote:BasicNote
    let noteNumber:Int
    let c:Int //国際
    let yc:Int //yamaha?
    let fileName:String
    //let freq:Double
    
    init(noteNum:Int){
        noteNumber = noteNum;
        switch(noteNumber){
            
        case 0...11:
            c = 0
        case 12...23:
            c = 1
        case 24...35:
            c = 2
        case 36...47:
            c = 3
        case 48...59:
            c = 4
        case 60...71:
            c = 5
        case 72...83:
            c = 6
        case 84...95:
            c = 7
        default:
            c = 8
        }
        yc = c - 1;
        let n = noteNumber % 12;
        basicNote = base12NoteArray[n]
        fileName = "\(c)-\(n)"
    }
}





//音程テーブル　半音の個数に対応
let intervalNameArray = ["完全1度","短2度","長2度","短3度","長3度","完全4度","増4度:減5度",
                         "完全5度","増5度:短6度","長6度","短7度","長7度","完全8"]


//////////////////////////////////////











