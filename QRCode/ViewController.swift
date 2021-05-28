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
        if !WeChat.canRecordScreen() {
            WeChat.showScreenRecordingPrompt()
        }
    }
    
    @IBAction func scanTap(_ sender: NSButton) {
        self.textView.string = ""
        if WeChat.canRecordScreen() {
            self.textView.string = "Scaning ......"
            Thread {
                let results = WeChat.scanQRCodeOnScreen()
                DispatchQueue.main.async {
                    if results.count > 0 {
                        self.textView.string = ""
                        for item in results {
                            self.textView.string += item + "\n"
                        }
                    } else {
                        self.textView.string = "No QR code found"
                    }
                }
            }.start()
        } else {
            NSWorkspace.shared.open(URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_ScreenCapture")!)
        }
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

