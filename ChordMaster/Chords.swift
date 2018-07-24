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
    let symbol:String //記号
    let symbol2:String //記号
    let intvls:Array<Int> //ベース音からのinterval 半音数
    
    init(name:String,
         jName:String,
         kName:String,
         symbol:String,
         symbol2:String,
         intvls:Array<Int>){
        
        self.name = name
        self.jName = jName
        self.kName = kName
        self.symbol = symbol
        self.symbol2 = symbol2
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

let dim = ChordType(name:"diminish",
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
                     kName:"メジャーセブンス",
                     symbol:"M7",
                     symbol2:"maj7",
                     intvls:[0,4,7,11]
)

let seventh = ChordType(name:"seventh",
                     jName:"セブンス",
                     kName:"セブンス",
                     symbol:"7",
                     symbol2:"7",
                     intvls:[0,4,7,10]
)

let minor7 = ChordType(name:"minor7",
                        jName:"セブンス",
                        kName:"セブンス",
                        symbol:"m7",
                        symbol2:"m7",
                        intvls:[0,3,7,10]
)

let halfdim = ChordType(name:"halfdiminish",
                        jName:"ハーフディミニッシュ",
                        kName:"ハーフディミニッシュ",
                        symbol:"m7-5",
                        symbol2:"m7♭5",
                        intvls:[0,3,6,10]
)

let dim7 = ChordType(name:"diminish7",
                         jName:"減七和音",
                         kName:"ディミニッシュ7",
                         symbol:"dim7",
                         symbol2:"dim7",
                         intvls:[0,3,6,9]
)

let maj7s5 = ChordType(name:"major7#5",
                     jName:"メジャーセブンス",
                     kName:"メジャーセブンス",
                     symbol:"M7#5",
                     symbol2:"M7#5",
                     intvls:[0,4,8,11]
)

let minormaj7 = ChordType(name:"minormaj7",
                       jName:"マイナーメジャーセブンス",
                       kName:"マイナーメジャーセブンス",
                       symbol:"mMaj7",
                       symbol2:"m△7",
                       intvls:[0,3,7,11]
)


//コードタイプ配列
let chordTypes = [major,
                  minor,
                  seventh,
                  minor7,
                  dim,
                  augment,
                  sus4,
                  maj7,
                  halfdim,
                  dim7,
                  maj7s5,
                  minormaj7
                 ]


//////////////////////////////////////
//音階
let scale = (major: [0,2,4,5,7,9,11],
             minior1: [0,2,3,5,7,8,10],
             minior2: [0,2,3,5,7,8,11],
             minior3: [0,2,3,5,7,9,11]
)

let majorScaleTriadChords = [(0,major),(2,minor),(4,minor),(5,major),(7,major),(9,minor),(11,dim)]
let majorScale4NotesChords = [(0,maj7),(2,minor7),(4,minor7),(5,maj7),(7,seventh),(9,minor7),(11,halfdim)]

let minorNaturalTriadChords = [(0,minor),(2,dim),(3,major),(5,minor),(7,minor),(8,major),(10,major)]
let minorNatural4NotesChords = [(0,minor7),(2,halfdim),(3,maj7),(5,minor7),(7,minor7),(8,maj7),(10,seventh)]

let minorHarmonicTriadChords = [(0,minor),(2,dim),(3,augment),(5,minor),(7,major),(8,major),(11,dim)]
let minorHarmonic4NotesChords = [(0,minormaj7),(2,halfdim),(3,maj7s5),(5,minor7),(7,seventh),(8,maj7),(11,dim7)]

let minorMelodicTriadChords = [(0,minor),(2,minor),(3,augment),(5,major),(7,major),(9,dim),(11,dim)]
let minorMelodic4NotesChords = [(0,minormaj7),(2,minor7),(3,maj7s5),(5,seventh),(7,seventh),(9,halfdim),(11,halfdim)]

let minorAllTriadChords = [(0,minor),(2,minor),(3,augment),(3,major),(5,major),(5,minor),(7,major),(7,minor),(9,dim),(9,major),(11,dim),(11,major)]
let minorAll4NotesChords = [(0,minor7),(0,minormaj7),(2,halfdim),(2,minor7),(3,maj7),(3,maj7s5),(5,minor7),(5,seventh),(5,minor),(7,seventh),(7,minor7),(8,maj7),(9,halfdim),(10,seventh),(11,dim7),(11,halfdim)]




