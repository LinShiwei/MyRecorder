//
//  ViewController.swift
//  MyRecorder
//
//  Created by Linsw on 15/12/16.
//  Copyright © 2015年 Linsw. All rights reserved.
//
/**
*  @brief  实现基础的录音功能，参考自印象笔记：Swift－制作一个录音机
*  只包含三个按钮，play、start、stop
*  点击start开始录音，stop停止录音，play播放录音
*
*  @since 2015.12.16 1.0
*/
import UIKit
import AVFoundation
class ViewController: UIViewController {
    /**
     play按钮响应函数
     
     :param: sender button：play
     */
    @IBAction func playRecord(sender: AnyObject) {
        
        do{
            player=try AVAudioPlayer(contentsOfURL: recorder!.url)
            player!.prepareToPlay()
            player!.play()
            
        }
        catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
        
        print("play")
    }
    /**
     button:stop action
     
     :param: sender button:stop
     */
    @IBAction func stopRecord(sender: AnyObject) {
        recorder!.stop()
        print("stop")
    }
    /**
     button:start action
     
     :param: sender button:start
     */
    @IBAction func startRecord(sender: AnyObject) {
        print("\(recorder!.record())，start")
    }
    /// a recorder object
    var recorder:AVAudioRecorder?
    /// a player object
    var player:AVAudioPlayer?
    /// recorder setting dictionary
    var recorderSettingDic:[String:AnyObject]?
    /// the save path of record
    var accPath:String?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /// 初始化录音器
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        
        /// 设置录音类型
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        /// 设置支持后台
        try! session.setActive(true)
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
      
        accPath = paths + "/sound.acc"///把aac改成wav灰出现初始化错误，是否不支持wav？

        recorderSettingDic=[
            AVFormatIDKey:NSNumber(unsignedInt: kAudioFormatMPEG4AAC),
            AVNumberOfChannelsKey:2,
            AVEncoderAudioQualityKey:AVAudioQuality.Max.rawValue,
            AVEncoderBitRateKey:320000,
            AVSampleRateKey:44100.0
        ]
        do{
            /// init the recorder object
            recorder = try AVAudioRecorder(URL: NSURL(string: accPath!)!, settings: recorderSettingDic!)

        }
        catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
        print("\(recorder!.prepareToRecord())，perpare")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

