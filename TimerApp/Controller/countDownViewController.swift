//
//  countDownViewController.swift
//  TimerApp
//
//  Created by 祥平 on 2021/04/25.
//

import UIKit

class countDownViewController: UIViewController {
    
    var hcount = Int()
    var mcount = Int()
    var scount = Int()
    var timer = Timer()

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(mcount)
        timerLabel.text = "残り：\(hcount)時間\(mcount)分\(scount)秒"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func startButton(_ sender: Any) {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
    }
    
    @objc func countDown(){
        scount -= 1
        if(scount < 0){
            mcount -= 1
            scount = 59
            if(mcount < 0){
                hcount -= 1
                mcount = 59
            }
        }
        timerLabel.text = "残り：\(hcount)時間\(mcount)分\(scount)秒"
    }
    
    @IBAction func stopButton(_ sender: Any) {
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
