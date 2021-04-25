//
//  TimerListViewController.swift
//  TimerApp
//
//  Created by 祥平 on 2021/04/18.
//

import UIKit

class TimerListViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var timeList:[setTimer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
        if let data = UserDefaults.standard.data(forKey: "setTimer") {
            timeList = try! PropertyListDecoder().decode([setTimer].self, from: data)
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "削除") { (action, view, completionHndler) in
            self.timeList.remove(at: indexPath.row)
            if let data = try? PropertyListEncoder().encode(self.timeList) {
                UserDefaults.standard.set(data, forKey: "setTimer")
            }
            tableView.reloadData()
            
            completionHndler(true)
        }
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let timeLabel = cell.contentView.viewWithTag(1) as! UILabel
        timeLabel.text = "\(timeList[indexPath.row].hcount)時間\(timeList[indexPath.row].mcount)分\(timeList[indexPath.row].scount)秒"
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let countDownVC = self.storyboard?.instantiateViewController(withIdentifier: "countDownVC") as! countDownViewController
        countDownVC.hcount = timeList[indexPath.row].hcount
        countDownVC.mcount = timeList[indexPath.row].mcount
        countDownVC.scount = timeList[indexPath.row].scount
        navigationController?.pushViewController(countDownVC, animated: true)
        
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
