//
//  ViewController.swift
//  TimerApp
//
//  Created by 祥平 on 2021/04/18.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet weak var datePickerView: UIPickerView!
    
    let dataList = [[Int](0...24), [Int](0...60), [Int](0...60)]
    
    var timer = Timer()
    var hcount = 0
    var mcount = 0
    var scount = 0
    var setTimerList:[setTimer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePickerView.delegate = self
        datePickerView.dataSource = self
        let hStr = UILabel()
        hStr.text = "時間"
        hStr.font = hStr.font.withSize(30)
        hStr.sizeToFit()
        hStr.frame = CGRect(x: datePickerView.bounds.width/4 - hStr.bounds.width/2, y: datePickerView.bounds.height/2 - (hStr.bounds.height/2), width: hStr.bounds.width, height:hStr.bounds.height)
        datePickerView.addSubview(hStr)
        
        let mStr = UILabel()
        mStr.text = "分"
        mStr.font = mStr.font.withSize(30)
        mStr.sizeToFit()
        mStr.frame = CGRect(x: datePickerView.bounds.width/2 - mStr.bounds.width/2, y: datePickerView.bounds.height/2 - (mStr.bounds.height/2), width: mStr.bounds.width, height: mStr.bounds.height)
        datePickerView.addSubview(mStr)
        
        let sStr = UILabel()
        sStr.text = "秒"
        sStr.font = sStr.font.withSize(30)
        sStr.sizeToFit()
        sStr.frame = CGRect(x: datePickerView.bounds.width*3/4 - sStr.bounds.width/2, y: datePickerView.bounds.height/2 - (sStr.bounds.height/2), width: sStr.bounds.width, height: sStr.bounds.height)
        datePickerView.addSubview(sStr)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return dataList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataList[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return datePickerView.bounds.width * 1/4
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.textColor = .black
        pickerLabel.font = pickerLabel.font.withSize(30)
        pickerLabel.textAlignment = NSTextAlignment.left
        pickerLabel.text = String(dataList[component][row])
        return pickerLabel
    }
    
    @IBAction func setTime(_ sender: Any) {
        timer.invalidate()
        hcount = dataList[0][datePickerView.selectedRow(inComponent: 0)]
        mcount = dataList[0][datePickerView.selectedRow(inComponent: 1)]
        scount = dataList[0][datePickerView.selectedRow(inComponent: 2)]
        setTimerList.append(setTimer(hcount: hcount, mcount: mcount, scount: scount))
        UserDefaults.standard.setValue(setTimerList, forKey: "setTimer")
    }
}

