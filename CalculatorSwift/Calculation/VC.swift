//
//  VC.swift
//  CalculatorSwift
//
//  Created by Admin on 2024/02/22.
//

import Foundation

import UIKit

class VC: UIViewController {
    @IBOutlet weak var mFrame: UIStackView!
    override func viewDidLoad() {
        mFrame.layer.cornerRadius = 10
    }
    
    func presentDialog(_ vc: UIViewController) {
        presentDialog(vc, sender:nil)
    }
    
    func presentDialog(_ vc: UIViewController, sender: UIButton?) {
        let svc = vc.storyboard!.instantiateViewController(identifier: "VC") as! VC
        svc.isModalInPresentation=true
        svc.modalPresentationStyle = .custom
        svc.modalTransitionStyle = .crossDissolve
//        svc.view.frame = CGRect(x: sender.centerXAnchor, y: sender.centerYAnchor, width: (svc.view.frame.width-(svc.view.frame.width/8)), height: (svc.view.frame.height/2))
        vc.present(svc, animated:true, completion:nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view != mFrame {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    //CGRect(x: sender.centerXAnchor, y: sender.centerYAnchor, width: (svc.view.frame.width-(svc.view.frame.width/8)), height: (svc.view.frame.height/2))
}
