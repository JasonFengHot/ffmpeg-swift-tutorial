//
//  MediaHelper.swift
//  tutorial
//
//  Created by jayios on 2016. 9. 9..
//  Copyright © 2016년 gretech. All rights reserved.
//

import Foundation
import AVFoundation
class MediaHelper {
    
    var engine: AVAudioEngine?
    var player: AVAudioPlayerNode?
    var picth: AVAudioUnitTimePitch?
    static let audioDefaultFormat: AVAudioFormat = AVAudioFormat(commonFormat: .pcmFormatFloat32, sampleRate: 44100, channels: 2, interleaved: false)
    static var defaultSampleRate: Int32 {
        return Int32(self.audioDefaultFormat.sampleRate)
    }
    static var defaultChannels: Int32 {
        return Int32(self.audioDefaultFormat.channelCount)
    }
    func setupAudio(rate: Float = 1.0) -> Bool{
        self.engine = AVAudioEngine()
        self.player = AVAudioPlayerNode()
        self.picth = AVAudioUnitTimePitch()
        
        guard let playerEngine = self.engine, let playerNode = self.player, let playPitch = self.picth else {
            return false
        }
        playPitch.rate = min(32, max(1.0 / 32.0, rate))
        playerEngine.attach(playerNode)
        playerEngine.attach(playPitch)
        playerEngine.connect(playerNode, to: playPitch, format: MediaHelper.audioDefaultFormat)
        playerEngine.connect(playPitch, to: playerEngine.mainMixerNode, format: MediaHelper.audioDefaultFormat)
        
        do {
            playerEngine.prepare()
            
            try playerEngine.start()
            playerNode.play()
        } catch {
            assertionFailure(error.localizedDescription)
            return false
        }
        return true
    }
    
    func audioPlay(data: AudioData) {
        self.player?.scheduleBuffer(data.pcmBuffer, completionHandler:nil)
    }
    
}
