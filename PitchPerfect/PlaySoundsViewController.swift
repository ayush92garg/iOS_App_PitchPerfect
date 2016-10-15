//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Ayush Garg on 16/10/16.
//  Copyright © 2016 Headmaster Technologies. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    
    //defining outlets
    
    @IBOutlet weak var snailButton:UIButton!
    @IBOutlet weak var rabbitButton:UIButton!
    @IBOutlet weak var chipmunkButton:UIButton!
    @IBOutlet weak var vaderButton:UIButton!
    @IBOutlet weak var echoButton:UIButton!
    @IBOutlet weak var reverbButton:UIButton!
    @IBOutlet weak var stopButton:UIButton!
    
    //defining variables
    var recordedAudioURL: NSURL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum buttonType: Int {
        case Slow = 0, Fast, Chipmunk, Vader, Echo, Reverb
    }
    
    
    @IBAction func playSoundForButton(sender: UIButton){
        print("play")
        switch buttonType(rawValue: sender.tag)! {
        case .Slow:
            playSound(rate: 0.5)
        case .Fast:
            playSound(rate: 2.0)
        case .Chipmunk:
            playSound(pitch: 1000)
        case .Vader:
            playSound(pitch: -1000)
        case.Echo:
            playSound(echo: true)
        case.Reverb:
            playSound(reverb: true)
        }
        
        configureUI(playState: .Playing)
    }
    
    @IBAction func stopButtonPressed(sender: AnyObject){
        print("stop")
        stopAudio()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        configureUI(playState: .NotPlaying)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
