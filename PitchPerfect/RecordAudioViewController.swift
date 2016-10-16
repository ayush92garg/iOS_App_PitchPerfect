//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Ayush Garg on 15/10/16.
//  Copyright © 2016 Headmaster Technologies. All rights reserved.
//

import UIKit
import AVFoundation

class RecordAudioViewController: UIViewController, AVAudioRecorderDelegate {

    //outlet's definition
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var startRecording: UIButton!
    @IBOutlet var stopRecording: UIButton!
    
    //variable declararions
    var audioRecorder:AVAudioRecorder!
    
    
    //action's definitions
    
    @IBAction func startRecordingIsClicked(_ sender: AnyObject) {
        
        
        //toggle to start/stop recording buttons
        startRecording.isEnabled = false
        stopRecording.isEnabled = true
        
        //update the Recording Label
        updateRecordingLabel()
        
        //getting the path of the file where audio will be saved
        let dirpath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let filename = "recordedAudio.wav"
        let pathArray = [dirpath,filename]
        let filepath = NSURL.fileURL(withPathComponents: pathArray)
        
        //trying to get a shared session to start the audio reecording
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch {
            print("Error in creating a session for recording")
        }
        
        //trying to record audio
        do {
            try audioRecorder = AVAudioRecorder(url: filepath!, settings: [:])
        }catch{
            print("error in recording audio")
        }
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecordingIsClicked(_ sender: AnyObject) {
        
        //toggle start/stop buttons and update the Label
        startRecording.isEnabled = true
        stopRecording.isEnabled = false
        updateRecordingLabel()
        
        //stopping the audio recording and de-active the recording session
        audioRecorder.stop()
        let session = AVAudioSession.sharedInstance()
        do{
            try session.setActive(false)
        }catch{
            print("Error in stopping the audio recording")
        }
    
    }
    
    func updateRecordingLabel(){
        recordingLabel.text = (stopRecording.isEnabled) ? "Recording! Tap below to stop" : "Tap the Mic to start Recording!!"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Disable Stop Recording Button
        stopRecording.isEnabled = false
        updateRecordingLabel()
    }

    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        //check if recording was successfull and then perform the seque
        if flag {
            performSegue(withIdentifier: "stopRecordingSegue", sender: audioRecorder.url)
        }else{
            print("Error in saving the recorded audio")
        }
    }
    
    //this functions is called when the segue is called on the existing view controller to help prepare it for the segue.
    //this function will be used to send the url of recorded audio file to playSoundsViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //checking for the correct segue
        if segue.identifier == "stopRecordingSegue" {
            let playSoundsVc = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! NSURL
            playSoundsVc.recordedAudioURL = recordedAudioURL
        }
    }

}
