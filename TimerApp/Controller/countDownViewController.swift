//
//  countDownViewController.swift
//  TimerApp
//
//  Created by 祥平 on 2021/04/25.
//

import UIKit
import AudioToolbox
import MBCircularProgressBar

private var vibrationCount = 10
private var soundIdRing:SystemSoundID = 1304

class countDownViewController: UIViewController {
    
    var hcount = Int()
    var mcount = Int()
    var scount = Int()
    private var timer = Timer()
    
    private let systemSoundID = SystemSoundID(kSystemSoundID_Vibrate)
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var progressView: MBCircularProgressBarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopBtn.isEnabled = false
        if let data = try? PropertyListEncoder().encode(setTimer(hcount: hcount, mcount: mcount, scount: scount)){
            UserDefaults.standard.set(data, forKey: "countTimer")
        }
        progressView.value = CGFloat(hcount * 60 * 60 + mcount * 60 + scount)
        progressView.maxValue = CGFloat(hcount * 60 * 60 + mcount * 60 + scount)
        timerLabel.text = "残り：\(hcount)時間\(mcount)分\(scount)秒"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func startButton(_ sender: Any) {
        timer.invalidate()
        stopBtn.isEnabled = true
        if(hcount == 0 && mcount == 0 && scount == 0){
            if let data = UserDefaults.standard.data(forKey: "countTimer"){
                let countDownTimer = try! PropertyListDecoder().decode(setTimer.self, from: data)
                hcount = countDownTimer.hcount
                mcount = countDownTimer.mcount
                scount = countDownTimer.scount
                timerLabel.text = "残り：\(hcount)時間\(mcount)分\(scount)秒"
            }
        }
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
    }
    
    @objc func countDown(){
        scount -= 1
        if(scount < 0){
            mcount -= 1
            scount = 59
        }
        if(mcount < 0){
            hcount -= 1
            mcount = 59
        }
        progressView.value = CGFloat(hcount * 60 * 60 + mcount * 60 + scount)
        if(hcount == 0 && mcount == 0 && scount == 0){
            progressView.value = 0
            timerLabel.text = "カウントダウン終了！"
            vibrationCount = 10
            AudioServicesAddSystemSoundCompletion(systemSoundID, nil, nil, { (systemSoundID, nil) -> Void in
                vibrationCount -= 1
                
                if ( vibrationCount > 0 ) {
                    // 繰り返し再生
                    AudioServicesPlaySystemSound(systemSoundID)
                    
                    if let soundUrl = CFBundleCopyResourceURL(CFBundleGetMainBundle(), nil, nil, nil){
                        AudioServicesCreateSystemSoundID(soundUrl, &soundIdRing)
                        AudioServicesPlaySystemSound(soundIdRing)
                    }
                }
            }, nil)
            
            AudioServicesPlaySystemSound(systemSoundID)
            timer.invalidate()
        }else{
            timerLabel.text = "残り：\(hcount)時間\(mcount)分\(scount)秒"
        }
    }
    
    @IBAction func stopButton(_ sender: Any) {
        // コールバックを解除
        AudioServicesRemoveSystemSoundCompletion(systemSoundID)
        timer.invalidate()
    }
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
