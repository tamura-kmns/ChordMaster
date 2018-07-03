//
//  Chords.swift
//  ChordMaster
//
//  Created by KatsuhikoTamura on 2018/07/03.
//  Copyright © 2018年 9bit.co. All rights reserved.
//

import Foundation

//コードの雛形
class ChordType {
    let name:String
    let jName:String //和
    let kName:String //カナ
    let symbol:[String] //記号
    let intvls:Array<Int> //ベース音からのinterval半音数
    
    init(name:String,
         jName:String,
         kName:String,
         symbol:String,
         symbol2:String,
         intvls:Array<Int>){
        
        self.name = name
        self.jName = jName
        self.kName = kName
        self.symbol = [symbol,symbol2]
        self.intvls = intvls
    }
}

///////////////////////////////////////////
let major = ChordType(name:"major",
                      jName:"長三和音",
                      kName:"メジャー",
                      symbol:"",
                      symbol2:"maj",
                      intvls:[0,4,7]
)

let minor = ChordType(name:"minor",
                      jName:"短三和音",
                      kName:"マイナー",
                      symbol:"m",
                      symbol2:"min",
                      intvls:[0,3,7]
)

let diminish = ChordType(name:"diminish",
                         jName:"減三和音",
                         kName:"ディミニッシュ",
                         symbol:"dim",
                         symbol2:"m-5",
                         intvls:[0,3,6]
)

let augment = ChordType(name:"augment",
                        jName:"増三和音",
                        kName:"オーギュメント",
                        symbol:"aug",
                        symbol2:"+5",
                        intvls:[0,4,8]
)
let sus4 = ChordType(name:"sus4",
                     jName:"サスフォー",
                     kName:"サス4",
                     symbol:"sus4",
                     symbol2:"sus4",
                     intvls:[0,5,7]
)

let maj7 = ChordType(name:"major7",
                     jName:"メジャーセブンス",
                     kName:"メジャーセブンす",
                     symbol:"M7",
                     symbol2:"Maj7",
                     intvls:[0,4,7,11]
)

let seventh = ChordType(name:"seventh",
                     jName:"セブンス",
                     kName:"セブンす",
                     symbol:"7",
                     symbol2:"7",
                     intvls:[0,4,7,10]
)


let chordArray = [major,minor,diminish,augment,sus4,maj7,seventh]




