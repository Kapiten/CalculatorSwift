//
//  DialogViewController.swift
//  CalculatorSwift
//
//  Created by Admin on 2024/02/26.
//

import Foundation
import UIKit

class DialogViewController: UIViewController {
    public var parentVC: UIViewController? = nil
    
    @IBOutlet weak var MFrame: UIStackView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    
    @IBOutlet weak var listWindow: UIStackView!
    @IBOutlet weak var stkDefaults: UIStackView!
    
    @IBOutlet var btnDefault: [UIButton]!
    var lstButtons: [UIButton]! = []
    
    var dTitle: String? = nil
    var dMessage: String? = nil
    var dList: Array<String>? = nil
    var defaultBtns: [Abutton] = []
    enum ButtonTypes {
        case negative, cancel, positive
    }
    
    class Abutton: NSObject {
        var title="", type:ButtonTypes? = .cancel, action:UIAction?=nil
        
        init(at:String, tp:ButtonTypes, act:UIAction) {
            title = at; type = tp; action = act
        }
    }
    
    init(_ vc: UIViewController) {
        parentVC = vc

        super.init(nibName: nil, bundle: nil);
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder);
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MFrame.layer.cornerRadius = 10
        
        if(dTitle != nil && !dTitle!.isEmpty){lblTitle.text = dTitle}
        else {lblTitle.isHidden = true}
        if(dMessage != nil && !dMessage!.isEmpty){lblMessage.text = dMessage}
        else {lblMessage.isHidden = true}
        if(lstButtons != nil && lstButtons!.count>0) {
            for btn in lstButtons {
                listWindow.addArrangedSubview(btn)
            }
        } else {listWindow.isHidden = true}
        
        for v in defaultBtns {
            if v.type == ButtonTypes.negative {
                (stkDefaults.arrangedSubviews[0] as! UIButton).setTitle(v.title, for: .normal)
                (stkDefaults.arrangedSubviews[0] as! UIButton).addAction(v.action!, for: .touchUpInside)
                stkDefaults.arrangedSubviews[0].isHidden = false
            } else if v.type == ButtonTypes.positive {
                (stkDefaults.arrangedSubviews[2] as! UIButton).setTitle(v.title, for: .normal)
                (stkDefaults.arrangedSubviews[2] as! UIButton).addAction(v.action!, for: .touchUpInside)
                stkDefaults.arrangedSubviews[2].isHidden = false
            } else if v.type == ButtonTypes.cancel {
                (stkDefaults.arrangedSubviews[1] as! UIButton).setTitle(v.title, for: .normal)
                (stkDefaults.arrangedSubviews[1] as! UIButton).addAction(v.action!, for: .touchUpInside)
                stkDefaults.arrangedSubviews[1].isHidden = false
            }
        }
    }
    
    func presentDialog(_ vc: UIViewController, aTitle: String?, aMessage: String?) {
        dTitle = aTitle
        dMessage = aMessage
        presentDialog(vc)
    }
    
    func presentDialog(_ vc: UIViewController) {
        let svc = vc.storyboard!.instantiateViewController(identifier: "DialogVC") as! DialogViewController
        svc.isModalInPresentation=true
        svc.modalPresentationStyle = .custom
        svc.modalTransitionStyle = .crossDissolve
        svc.dTitle = dTitle
        svc.dMessage = dMessage
        svc.lstButtons = lstButtons
        svc.defaultBtns = defaultBtns
        vc.present(svc, animated:true, completion:nil)
    }
    
    func setTitle(_ text:String) -> DialogViewController {
        dTitle = text
        return self
    }
    
    func setMessage(_ text:String) -> DialogViewController {
        dMessage = text
        return self
    }
    
    func setCancel(_ value:Bool) {btnDefault[1].isHidden = false}
    
    func setButton(aTitle:String, bType: ButtonTypes, completion: UIActionHandler?) -> DialogViewController {
        defaultBtns.append(Abutton.init(at: aTitle, tp: bType, act: UIAction.init(handler: completion ?? {(v) in })))
        return self
    }
    
    func setListItem(_ aTitle:String, completion: @escaping () -> Void) -> DialogViewController {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 30), primaryAction: UIAction(handler: { (UIAction) in
            self.parentVC?.dismiss(animated: true, completion: nil)
            completion()
        }))
        btn.setTitle(aTitle, for: .normal)
        btn.backgroundColor = .white
        btn.setTitleColor(.black, for: .normal)
        btn.setTitleColor(.gray, for: .highlighted)
//        btn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
//        btn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
//        btn.topAnchor.constraint(equalTo: self.view.topAnchor)
//        btn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        lstButtons.append(btn)
        
        return self
    }
    
    @IBAction func onTouch(_ sender: UIButton?) {
        if(sender != nil) {
            switch(sender!.tag) {
                case -1: do {
                    print("-1")
                }
                case -3: do {
                    print("-3")
                }
                default: do {}
            }
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if touches.first?.view != MFrame {
//            doDismiss()
//        }
//    }
    
    @objc
    func doDismiss() { self.dismiss(animated: true, completion: nil) }
}
