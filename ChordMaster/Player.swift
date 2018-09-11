//
//  Player.swift
//  ChordMaster
//
//  Created by KatsuhikoTamura on 2018/09/12.
//  Copyright © 2018年 9bit.co. All rights reserved.
//

import Foundation
import AVFoundation


public class Player: NSObject {
    
    let engine = AVAudioEngine()
    
    func playChord(chord:Chord, bassNote:BasicNote){
        let baseNoteNum = Int16(BASE_C_NUMBER) + (chord.baseNote?.noteNumber)!
        var audioPlayers:[AVAudioPlayerNode] = []
        for noteNum:Int in (chord.chordBase?.intvls)! {
            let playNoteNum = (baseNoteNum + Int16(noteNum))
            let player = AVAudioPlayerNode()
            
            let filePath = Bundle.main.path(forResource: allNoteArray[Int(playNoteNum)].fileName, ofType: "mp3")!
            let fileURL = URL(fileURLWithPath: filePath)
            if let audioFile = try? AVAudioFile(forReading: fileURL) {
                engine.attach(player)
                engine.connect(player, to: engine.mainMixerNode, format: audioFile.processingFormat)
                player.scheduleFile(audioFile, at: nil, completionHandler: nil)
                audioPlayers.append(player)
            }
        }
        //bass音
        let playBassNoteNum = Int16(BASE_BASS_C_NUMBER) + (bassNote.noteNumber)
        let player = AVAudioPlayerNode()
        let filePath = Bundle.main.path(forResource: allNoteArray[Int(playBassNoteNum)].fileName, ofType: "mp3")!
        let fileURL = URL(fileURLWithPath: filePath)
        if let audioFile = try? AVAudioFile(forReading: fileURL) {
            engine.attach(player)
            engine.connect(player, to: engine.mainMixerNode, format: audioFile.processingFormat)
            player.scheduleFile(audioFile, at: nil, completionHandler: nil)
            audioPlayers.append(player)
        }
        
        try? engine.start()
        for player in audioPlayers {
            player.play()
        }
    }






















}
