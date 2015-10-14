//
//  RecordSoundViewController.swift
//  MyCatTranslator
//
//  Created by Lee Cohen on 6/8/15.
//  Copyright (c) 2015 Lee. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var RecordingLable: UILabel!
    @IBOutlet weak var StopButton: UIButton!
    
    //Declared Globally
    var audioRecorder:AVAudioRecorder!
    var recordedAudio: RecordedAudio!
   
    //weak someone alse created that varaiable so hold it shurt time
    //strong i created this var so hold it till i dont need it
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func viewWillAppear(animated: Bool) {
        println("viewwill apear")
        //Hide stop button
        StopButton.hidden = true
        //Enable record button
        recordButton.enabled = true
        
        
        
    }
    @IBAction func recordAudio(sender: AnyObject) {
        //recProgress.hidden=true
        //Disable record button
        recordButton.enabled = false
        //show stop button
        StopButton.hidden = false
        //display lable "recording"
        RecordingLable.hidden=false
        println("recording")
        //Inside func recordAudio(sender: UIButton)
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        
      //let currentDateTime = NSDate()
      //let formatter = NSDateFormatter()
      //formatter.dateFormat = "ddMMyyyy-HHmmss"
      // let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        
        let recordingName = "my_audio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        //initializing audioRecorder
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
       //delegate statment
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
       
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        
        if (flag){
        //save recorded audio :
        //first we inisilize the new obj
        recordedAudio = RecordedAudio()
        //then get parames from recorder , from our function input
        recordedAudio.filePathUrl = recorder.url
        recordedAudio.title = recorder.url.lastPathComponent
        
        
        
        //TODO: Move to next screen aka preforme segue
        self.performSegueWithIdentifier("stopRecordingSegue", sender: recordedAudio)
        }
        
    }
    
    //function inharaited from UIViewController
    //this func happen just befor a segue is accure and is a great place to transfer data
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "stopRecordingSegue"
        {
            let playSoundVC:PlaySoundViewController = segue.destinationViewController as! PlaySoundViewController
            let data = sender as! RecordedAudio
            playSoundVC.recivedAudio = data
        }
    }
 
    @IBAction func PressStop(sender: AnyObject) {
        //Hide "recording" lable
        RecordingLable.hidden=true
        //Hide stop button
        StopButton.hidden = true
        //Enable record button
        recordButton.enabled = true
        
        //Inside func stopAudio(sender: UIButton)
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
        
        println("stoped record")
    }
}

