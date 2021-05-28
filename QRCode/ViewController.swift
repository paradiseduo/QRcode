//
//  ViewController.swift
//  QRCode
//
//  Created by Paradiseduo on 2021/5/24.
//  Copyright © 2021 Paradiseduo. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {


    @IBOutlet var textView: NSTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        WeChat.showScreenRecordingPrompt()
    }
    
    @IBAction func scanTap(_ sender: NSButton) {
        self.textView.string = ""
        let results = WeChat.scanQRCodeOnScreen()
        for item in results {
            self.textView.string += item + "\n"
        }
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

