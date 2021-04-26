//
//  EditTimerViewController.swift
//  TimerApp
//
//  Created by 祥平 on 2021/04/26.
//

import UIKit

class EditTimerViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource  {

    @IBOutlet weak var datePickerView: UIPickerView!
    
    var dataList = [[Int](0...24), [Int](0...59), [Int](0...59)]
    var hcount = 0
    var mcount = 0
    var scount = 0
    
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
        pickerLabel.textColor = .black
        pickerLabel.font = pickerLabel.font.withSize(30)
        pickerLabel.textAlignment = NSTextAlignment.left
        pickerLabel.text = String(dataList[component][row])
        return pickerLabel
    }
    
    @IBAction func editButton(_ sender: Any) {
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
