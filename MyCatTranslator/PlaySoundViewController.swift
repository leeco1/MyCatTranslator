//
//  PlaySoundViewController.swift
//  MyCatTranslator
//
//  Created by Lee Cohen on 6/16/15.
//  Copyright (c) 2015 Lee. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
    //Declared globally with PlaySoundsViewController
    var audioPlayer:AVAudioPlayer!
    var recivedAudio:RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile:AVAudioFile!


    override func viewDidLoad() {
        
        super.viewDidLoad()
        audioEngine = AVAudioEngine()

        // Do any additional setup after loading the view.
//        if var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3")
//            {   //get a NSURL from the string filePath
//                var filePathUrl = NSURL.fileURLWithPath(filePath)
//                //creat an instance of AVAoudioPlayer
//                
//        }
//        else {
//                println("The filePath is empty")
//                }
        audioPlayer = AVAudioPlayer(contentsOfURL: recivedAudio.filePathUrl , error: nil)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: recivedAudio.filePathUrl, error: nil)

    }//end of viewDidLoad
    
    @IBAction func PlaySlowSound(sender: UIButton) {
        audioPlayer.stop()
      
        //enable rate options
       // audioPlayer.enableRate = true
        
        //set the rate speed of sound
        audioPlayer.rate = 0.5
        //go back to the begining og audio
        audioPlayer.currentTime = 0.0
        //Play audio
        audioPlayer.play()
        
        //disable ate option
        //audioPlayer.enableRate = false
    }
    
    
    @IBAction func PlayFastsound(sender: UIButton) {
        audioPlayer.stop()
        //enable rate options
       // audioPlayer.enableRate = true
        //set the rate speed of sound
        audioPlayer.rate = 2
       //go back to the begining og audio
        audioPlayer.currentTime = 0.0
        //Play audio
        audioPlayer.play()
        //disable ate option
        //audioPlayer.enableRate = false
    }
    
    
    
    @IBAction func PlayChipmunkSound(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func PlayDarthvaderSound(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    //New Function
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
   
    @IBAction func StopButton2(sender: UIButton) {
        //stop Sound
        audioPlayer.stop()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    } /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
