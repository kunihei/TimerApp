//
//  ViewController.swift
//  TimerApp
//
//  Created by 祥平 on 2021/04/18.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet weak var datePickerView: UIPickerView!
    
    var dataList = [[Int](0...24), [Int](0...59), [Int](0...59)]
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
        mStr.frame = CGRect(x: datePickerView.bounds.width/1.9 - mStr.bounds.width/1, y: datePickerView.bounds.height/2 - (mStr.bounds.height/2), width: mStr.bounds.width, height: mStr.bounds.height)
        datePickerView.addSubview(mStr)
        
        let sStr = UILabel()
        sStr.text = "秒"
        sStr.font = sStr.font.withSize(30)
        sStr.sizeToFit()
        sStr.frame = CGRect(x: datePickerView.bounds.width*1.6/2.1 - sStr.bounds.width/5, y: datePickerView.bounds.height/2 - (sStr.bounds.height/2), width: sStr.bounds.width, height: sStr.bounds.height)
        datePickerView.addSubview(sStr)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTimerList = []
        
        if let data = UserDefaults.standard.data(forKey: "setTimer") {
            let pasttimerList = try! PropertyListDecoder().decode([setTimer].self, from: data)
            for i in 0..<pasttimerList.count{
                setTimerList.append(pasttimerList[i])
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return dataList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataList[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return datePickerView.bounds.width * 1/3.9
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.font = pickerLabel.font.withSize(30)
        pickerLabel.textAlignment = NSTextAlignment.left
        pickerLabel.text = String(dataList[component][row])
        return pickerLabel
    }
    
    @IBAction func setTime(_ sender: Any) {
        hcount = dataList[0][datePickerView.selectedRow(inComponent: 0)]
        mcount = dataList[1][datePickerView.selectedRow(inComponent: 1)]
        scount = dataList[2][datePickerView.selectedRow(inComponent: 2)]
        setTimerList.append(setTimer(hcount: hcount, mcount: mcount, scount: scount))
        if let data = try? PropertyListEncoder().encode(setTimerList) {
            UserDefaults.standard.set(data, forKey: "setTimer")
        }
        datePickerView.selectRow(0, inComponent: 0, animated: false)
        datePickerView.selectRow(0, inComponent: 1, animated: false)
        datePickerView.selectRow(0, inComponent: 2, animated: false)
    }
}

