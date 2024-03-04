//
//  Calculation.swift
//  CalculatorSwift
//
//  Created by Admin on 2024/02/22.
//

import Foundation
import UIKit

class CalculationViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var lblAnswer: UILabel!
    @IBOutlet weak var tfExpression: UITextField!
    @IBOutlet weak var lblExpression: UITextView!
    @IBOutlet weak var sciExpression: UIStackView!
    @IBOutlet weak var sciInitialExpression: UITextField!
    @IBOutlet weak var swtScientific: UISwitch!
    @IBOutlet weak var vScientific: UIView!
    @IBOutlet weak var aNum8: UIButton!
    @IBOutlet weak var aNum4: UIButton!
    @IBOutlet weak var aNum6: UIButton!
    @IBOutlet weak var aNum2: UIButton!
    @IBOutlet weak var aMotionUp: UIButton!
    @IBOutlet weak var aMotionLeft: UIButton!
    @IBOutlet weak var aMotionRight: UIButton!
    @IBOutlet weak var aMotionDown: UIButton!
    
    @IBOutlet var numbers: [UIButton]!
    
    var isStandBy = false
    var canEnter = false
    var isDotted = false
    var currentNumber = ""
    var arrExpression: Array<String> = []
    var cursorMotion = false
    var currentTF: UITextField!

    override func viewDidLoad() {
        currentTF = tfExpression
        tfExpression.delegate = self
        sciInitialExpression.delegate = self
        
        let cp: UITextField = UITextField(frame: .init(x: 0, y: 0, width: 50, height: 30))
        cp.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        cp.trailingAnchor.constraint(equalTo:  self.view.trailingAnchor)
        cp.placeholder = "Write an expression"
        cp.borderStyle = .roundedRect
        cp.textAlignment = .right
        
        currentTF = cp
        sciExpression.addArrangedSubview(cp)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        currentTF = textField
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.endEditing(false)
    }
    
    func onMove() {
        cursorMotion = !cursorMotion
        if(cursorMotion) {
            self.aMotionUp.isHidden = false
            self.aMotionLeft.isHidden = false
            self.aMotionRight.isHidden = false
            self.aMotionDown.isHidden = false
            numbers.forEach { (btn) in
                switch btn.tag {
                    case 2: do {btn.isHidden=true}
                    case 4: do {btn.isHidden=true}
                    case 6: do {btn.isHidden=true}
                    case 8: do {btn.isHidden=true}
                    default: do{btn.titleLabel?.isHidden=true}
                }
            }
//            self.aNum2.isHidden = true
//            self.aNum4.isHidden = true
//            self.aNum6.isHidden = true
//            self.aNum8.isHidden = true
        } else {
            self.aMotionUp.isHidden = true
            self.aMotionLeft.isHidden = true
            self.aMotionRight.isHidden = true
            self.aMotionDown.isHidden = true
            numbers.forEach { (btn) in
                switch btn.tag {
                    case 2: do {btn.isHidden=false}
                    case 4: do {btn.isHidden=false}
                    case 6: do {btn.isHidden=false}
                    case 8: do {btn.isHidden=false}
                    default: do{btn.titleLabel?.isHidden=false}
                }
            }
//            self.aNum2.isHidden = false
//            self.aNum4.isHidden = false
//            self.aNum6.isHidden = false
//            self.aNum8.isHidden = false
        }
    }
    
    @IBAction func onOptions(_ sender: UIButton) {
        //let dvc =
            DialogViewController(self)
            .setTitle("Options")
//            .setMessage("aMessage")
//            .setButton(aTitle: "Cancel", bType: DialogViewController.ButtonTypes.negative) { (UIAction) in
//                print("Canceled")
//            }
//            .setButton(aTitle: "OK", bType: DialogViewController.ButtonTypes.positive, completion: { (UIAction) in
//                print("OKed")
//            })
            .setButton(aTitle: "Cancel", bType: DialogViewController.ButtonTypes.negative, completion: { (UIAction) in
                
            })
            .setListItem("History", completion:{
            //dvc.parentVC = self
                let pvc = self.storyboard?.instantiateViewController(identifier: "HistoryVC") as! HistoryViewController
                self.show(pvc, sender: nil)
            })
            .setListItem("Move", completion: {
//            dvc.parentVC = self
                let svc = self.storyboard!.instantiateViewController(identifier: "VC") as! VC
                svc.isModalInPresentation=true
                svc.modalPresentationStyle = .custom
                svc.modalTransitionStyle = .crossDissolve
                self.present(svc, animated:true, completion:nil)
            })
            .presentDialog(self)
        
//        VC().presentDialog(self)
    }
    
    @IBAction func onMoving(_ sender: UIButton) {
        switch sender.tag {
            case -1: do {
                
            }
            case -2: do {
                if let selectedRange = currentTF.selectedTextRange {
                    if let newPosition = currentTF.position(from: selectedRange.start, offset: +1) {
                        currentTF.selectedTextRange = currentTF.textRange(from: newPosition, to: newPosition)
                    }
                }
            }
            case -3: do {
                if let selectedRange = currentTF.selectedTextRange {
                    if let newPosition = currentTF.position(from: selectedRange.start, offset: -1) {
                        currentTF.selectedTextRange = currentTF.textRange(from: newPosition, to: newPosition)
                    }
                }
            }
            case -4: do {
                
            }
            default:do{}
        }
    }
    
    @IBAction func onCancel(_ sender: UIButton?) {
        lblAnswer.text = "0"
        currentTF.text = ""
        lblExpression.text = ""
        isStandBy = false
        canEnter = false
        isDotted = false
        currentNumber = ""
        arrExpression.removeAll()
    }
    
    @IBAction func onSymbol(_ sender: UIButton?) {
        var sym = ""
        switch sender!.tag {
            case 11: do {sym="+"}
            case 12: do {sym="-"}
            case 13: do {sym="×"}
            case 14: do {sym="÷";
                if swtScientific.isOn {
                    let cp: UITextField = UITextField(frame: .init(x: 0, y: 0, width: 50, height: 30))
                    cp.leftAnchor.constraint(equalTo: self.view.leftAnchor)
                    cp.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
                    cp.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
                    cp.placeholder = "Write an expression"
                    cp.borderStyle = .roundedRect
                    cp.textAlignment = .right
                    
                    currentTF = cp
                    sciExpression.addArrangedSubview(cp)
                }
            }
            default: do {sym="+"}
        }
        append(sym.first!)
    }
    
    
    
    @IBAction func onEqual(_ sender: UIButton?) {
        if(isSymbol(currentTF.text!.last!)) {
            currentTF.text!.append(currentTF.text!.last!.description.elementsEqual("+") || currentTF.text!.last!.description.elementsEqual("-") ? "0" : "1")}
        calculation(true)
        UserDefault().saveExpression(lblExpression.text)
        isStandBy=true
    }
    
    func calculate(val1:Double, sym:String, val2: Double) -> Double? {
        switch sym {
            case "+": do {return val1 + val2}
            case "-": do {return val1 - (val2)}
            case "*", "×": do {return val1 * val2}
            case "/", "÷": do {return val1 / val2}
            default: do {return nil}
        }
    }
    
    func calculation(_ standBy:Bool) {
        var arrExp:Array<String> = []
        
        var exp = currentTF.text!
        if(exp.count<1){return}
        var cCN = ""
        var sym = ""
        var finAns = 0.0
        if(isSymbol(exp.last!)) {
            exp.append(exp.last!.description.elementsEqual("+") || exp.last!.description.elementsEqual("-") ? "0" : "1")}
        
        exp.forEach { (cs) in
            switch cs {
                case "+": do {sym="+"; arrExp.append(cCN); arrExp.append(sym); cCN=""}
                case "-": do {sym="-"; arrExp.append(cCN); arrExp.append(sym); cCN=""}
                case "×", "*": do {sym="×"; arrExp.append(cCN); arrExp.append(sym); cCN=""}
                case "÷", "/": do {sym="÷"; arrExp.append(cCN); arrExp.append(sym); cCN=""}
                default: do {cCN += cs.description}
            }
        }
        lblExpression.text = exp.appending("=")
        //currentTF.text = ""
        arrExp.append(cCN); sym = "+"
        
        for itm in arrExp {
            switch itm {
                case "+": do {sym="+"}
                case "-": do {sym="-"}
                case "×", "*": do {sym="×"}
                case "÷", "/": do {sym="÷"}
                default: do {
                    finAns = calculate(val1: finAns, sym: sym, val2: Double.init(itm)!)!
                }
            }
        }
        
        var ans = String.init(finAns)
        if(ans.hasSuffix(".0")) {
            ans = ans.replacingOccurrences(of: ".0", with: "")
        }
        lblAnswer.text = ans
//        arrExp.removeAll()
        currentNumber = ""
        isStandBy = standBy
    }
    
    @IBAction func onScientificSwitch(_ sender: UISwitch) {
        if sender.isOn {vScientific.isHidden=false;tfExpression.isHidden=true;currentTF=sciInitialExpression; sciInitialExpression.isHighlighted = true;calculation(isStandBy); if currentTF.text!.isEmpty {onCancel(nil)}}
        else {vScientific.isHidden=true;tfExpression.isHidden=false;currentTF=tfExpression;calculation(isStandBy)}
    }
    
    @IBAction func onNumber(_ sender: UIButton) {
        append(sender.titleLabel!.text!.first!)
        isStandBy=false
//        if(isStandBy) {currentTF.text = sender.titleLabel!.text!}
//        else {currentTF.text!.append(sender.titleLabel!.text!)}
        canEnter = true;
//        isStandBy = false
        currentNumber += sender.titleLabel!.text!
//        currentTF.text?.insert(sender.titleLabel?.text, at: currentTF.)
    }
    
    @IBAction func onDotting(_ sender: UIButton) {
        if(!isDotted) {
            if(!canEnter||isStandBy) { currentTF.text!.append("0") }
            currentNumber += sender.titleLabel!.text!
            append(sender.titleLabel!.text!.first!)
            
            canEnter = false
            isDotted = true
        }
    }
    
    @IBAction func onDelete(_ sender: UIButton) {
        var cp = 0;
        if let selectedRange = currentTF.selectedTextRange {
            cp = currentTF.offset(from: currentTF.beginningOfDocument, to: selectedRange.start)
            currentTF.text!.remove(at: String.Index.init(utf16Offset: cp-1, in: currentTF.text!))
            
            if let newPosition = currentTF.position(from: selectedRange.start, offset: -1) {
                currentTF.selectedTextRange = currentTF.textRange(from: newPosition, to: newPosition)
            }
        }
        
        if tfExpression.text!.isEmpty {onCancel(sender)}
        calculation(false)
    }
    
    func append(_ value:Character) {
        if(!isStandBy) {
            var cp = 0;
            if let selectedRange = currentTF.selectedTextRange {
                cp = currentTF.offset(from: currentTF.beginningOfDocument, to: selectedRange.start)
                
                var valid = false
                var subs = currentTF.text!.substring(to: .init(utf16Offset: cp, in: currentTF.text!))
                
                if ((subs.hasSuffix("+") || subs.hasSuffix("-") || subs.hasSuffix("×") || subs.hasSuffix("÷")) && isSymbol(value)) {
                    
                } else {
                    currentTF.text!.insert(value, at: String.Index.init(utf16Offset: cp, in: currentTF.text!))
                }
                if let newPosition = currentTF.position(from: selectedRange.start, offset: 1) {
                    currentTF.selectedTextRange = currentTF.textRange(from: newPosition, to: newPosition)
                }
            }
            
//            currentTF.text!.append(value)
        } else {currentTF.text! = "\(isSymbol(value) ? "\("0".appending("\(value)"))" : "\(value)")"}
        
        if(isSymbol(value)){isDotted = false}
        calculation(false)
    }
    
    public func writeExpression(_ value:String) {
        currentTF.text = value; isStandBy=false; calculation(false);
        if let selectedRange = currentTF.selectedTextRange {
            if let np = currentTF.position(from: currentTF.endOfDocument, offset: 0) {
                currentTF.selectedTextRange = currentTF.textRange(from: np, to: np)
            }
        }
    }
    
    func isSymbol(_ v: Character) -> Bool {
        switch v {
            case "+": do {return true}
            case "-": do {return true}
            case "×", "*": do {return true}
            case "÷", "/": do {return true}
            default: do {return false}
        }
    }
}

//×+÷-
