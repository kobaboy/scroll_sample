//
//  ViewController.swift
//  scrollview_sample
//
//  Created by Keisuke.K on 2015/04/12.
//  Copyright (c) 2015年 Keisuke.K. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate{
    let text1: UITextField = UITextField(frame: CGRectMake(0,0,200,30))
    let text2: UITextField = UITextField(frame: CGRectMake(0,0,200,30))
    let sc = UIScrollView();
    var txtActiveField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        sc.frame = self.view.frame;
        sc.backgroundColor = UIColor.redColor();
        sc.delegate = self;
        
        //textfileの位置を指定する
        sc.contentSize = CGSize(width: 250,height: 1000)
        self.view.addSubview(sc);
        
        // 表示する文字を代入する.
        text1.text = ""
        text2.text = ""
        
        // Delegateを設定する.
        text1.delegate = self
        text2.delegate = self
        
        // 枠を表示する.
        text1.borderStyle = UITextBorderStyle.RoundedRect
        text2.borderStyle = UITextBorderStyle.RoundedRect
        
        // UITextFieldの表示する位置を設定する.
        text1.layer.position = CGPoint(x:self.view.bounds.width/2,y:500);
        text2.layer.position = CGPoint(x:self.view.bounds.width/2,y:100);
        
        self.view.addSubview(text1)
        self.view.addSubview(text2)
        
        // Viewに追加する
        sc.addSubview(text1)
        sc.addSubview(text2)
        
    }
    
    //改行ボタンが押された際に呼ばれる.
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    //UITextFieldが編集された直後に呼ばれる.
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        txtActiveField = textField
        return true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "handleKeyboardWillShowNotification:", name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: "handleKeyboardWillHideNotification:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func handleKeyboardWillShowNotification(notification: NSNotification) {
        
        let userInfo = notification.userInfo!
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let myBoundSize: CGSize = UIScreen.mainScreen().bounds.size
        var txtLimit = txtActiveField.frame.origin.y + txtActiveField.frame.height + 8.0
        let kbdLimit = myBoundSize.height - keyboardScreenEndFrame.size.height
        
        
        println("テキストフィールドの下辺：(\(txtLimit))")
        println("キーボードの上辺：(\(kbdLimit))")
        
        if txtLimit >= kbdLimit {
            sc.contentOffset.y = txtLimit - kbdLimit
        }
    }
    
    func handleKeyboardWillHideNotification(notification: NSNotification) {
        sc.contentOffset.y = 0
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

