//
//  HistoryViewController.swift
//  CalculatorSwift
//
//  Created by Admin on 2024/02/28.
//

import Foundation
import UIKit

class HistoryViewController: UITableViewController {
    
    override func viewDidLoad() {
        UserDefault.init().removeDuplicates()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserDefault.init().stringArray(forKey: Constants.PREF_EXPRESSION)!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cella = tableView.dequeueReusableCell(withIdentifier: "cella")!
        var cellaText = UserDefault().getExpression(indexPath.row)!
        cellaText.removeLast(1)
        cella.textLabel?.text = cellaText
        cella.addGestureRecognizer(UILongPressGestureRecognizer(target:self, action: #selector(onLongPress(gesture:))))
        return cella
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.viewControllers.forEach({ (vc) in
            if(vc.isKind(of: CalculationViewController.self)) {
                (vc as! CalculationViewController).writeExpression((tableView.cellForRow(at: indexPath)!.textLabel?.text)!)
            }
        })
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onLongPress(gesture: UILongPressGestureRecognizer) {
        DialogViewController.init(self)
            .setListItem("Copy") {
                let copyString = UIPasteboard.general
                copyString.string = (gesture.view as! UITableViewCell).textLabel!.text!
            }
            .setListItem("Remove") {
                print("gesture=",(gesture.view as! UITableViewCell).textLabel!.text!)
                var arr = UserDefault().getExpressions()
                var i = 0
                arr?.forEach({ (s) in
                    if(s.elementsEqual((gesture.view as! UITableViewCell).textLabel!.text!.appending("="))) { arr?.remove(at: i)
                    }
                    i += 1
                })
                UserDefault.init().saveAll(arr!)
                self.tableView.reloadData()
            }
            .setButton(aTitle: "Cancel", bType: DialogViewController.ButtonTypes.cancel, completion: nil)
            .presentDialog(self)
    }
    
    func presentVC(_ vc: UIViewController) {
        let pvc = vc.storyboard?.instantiateViewController(identifier: "HistoryVC") as! HistoryViewController
        self.show(pvc, sender: nil)
    }
}
