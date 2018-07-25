//
//  ViewController.swift
//  Calculator
//
//  Created by LXU on 7/19/18.
//  Copyright © 2018 LXU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var expression: UILabel!
    var expressionStr = ""
    var stack = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        expression.text = "0"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onPressC(_ sender: UIButton) {
        if !expressionStr.isEmpty {
            expressionStr.removeLast()
        }
        
        if expressionStr.isEmpty {
            expression.text! = "0"
        } else {
            expression.text = expressionStr
        }
    }
    
    @IBAction func onPressNumber(_ sender: UIButton) {
        let numStr = String(sender.tag)
        if Int(expressionStr)==0 {
            expressionStr = numStr
        } else {
            expressionStr += numStr
        }
        expression.text = expressionStr
    }
    
    @IBAction func onPressOperator(_ sender: UIButton) {
        var op = ""
        switch sender.tag {
        case 0:
            op = "+"
            break
        case 1:
            op = "-"
            break
        case 2:
            op = "*"
            break
        case 3:
            op = "/"
            break
        default:
            print("Unknow operator!")
        }
        
        if !expressionStr.isEmpty && expressionStr.last! >= "0" && expressionStr.last! <= "9" {
            expressionStr += op
        }
        expression.text = expressionStr
    }
    
    @IBAction func onPressEqual(_ sender: UIButton) {
        var stack = [String]()
        let arr = Array(expressionStr)
        var index = 0
        while index < arr.count {
            if arr[index] == "+" || arr[index] == "-" || arr[index] == "*" || arr[index] == "/" {
                stack.append(String(arr[index]))
                index += 1
            } else {
                var end = index+1
                while end < arr.count && arr[end] >= "0" && arr[end] <= "9" {
                    end += 1
                }
                let si = expressionStr.index(expressionStr.startIndex, offsetBy: index)
                let ei = expressionStr.index(expressionStr.startIndex, offsetBy: end)
                let curNum = Int(expressionStr[si..<ei])
                if !stack.isEmpty && (stack.last! == "*" || stack.last! == "/") {
                    let op = stack.removeLast()
                    let preNum = Int(stack.removeLast())
                    if op == "*" {
                        stack.append(String(preNum! * curNum!))
                    } else {
                        stack.append(String(preNum! / curNum!))
                    }
                } else {
                    stack.append(String(curNum!))
                }
                index = end
            }
        }
        var ret = 0
        var sign = 1
        for each in stack {
            if each == "+" {
                sign = 1
            } else if each == "-" {
                sign = -1
            } else {
                ret += sign * Int(each)!
            }
        }
        expression.text = expressionStr+"= "+String(ret)
        expressionStr = ""
    }
    
    @IBAction func onPressDot(_ sender: UIButton) {
        if expressionStr.isEmpty {
            expressionStr = "0."
            expression.text = expressionStr
            return
        }
        if expressionStr.last! >= "0" && expressionStr.last! <= "9" {
            expressionStr += "."
        }
        expression.text = expressionStr
    }
    
    
}

