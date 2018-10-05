//
//  MainViewController.swift
//  title-displayer
//
//  Created by yuxiqian on 2018/10/4.
//  Copyright © 2018 yuxiqian. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {

    
    override func viewDidAppear() {
        if titles.count == 0 {
            self.view.window?.close()
            return
        }
        
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        windowController = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("Title Window Controller")) as? TransparentWindowController
        viewController = (windowController?.contentViewController as! DisplayerViewController)
        
        windowController?.showWindow(self)
        windowController?.window?.title = "正在展示" + (self.view.window?.title ?? "字幕")
        shrinkFrame()
        updateNextPrompt()
        viewController?.updateLabelSize(to: fontSize)
    }
    
    override func viewWillDisappear() {
        windowController?.window?.orderOut(self)
    }
    
    @objc dynamic var selectedIndex: Int = 0
    @objc dynamic var titles: [String] = []
    
    var fontSize: Int = 24
    var windowController: TransparentWindowController?
    var viewController: DisplayerViewController?
    var frameSize: [CGFloat] = [1280.0, 720.0]
    
    @IBOutlet weak var leftButton: NSButton!
    @IBOutlet weak var rightButton: NSButton!
    
    @IBOutlet weak var nextPrompt: NSTextField!
    
    @IBAction func onSelectionChanged(_ sender: NSPopUpButton) {
        updateNextPrompt()
    }
    
    @IBAction func goForward(_ sender: NSButton) {
        if selectedIndex != 0 {
            self.selectedIndex -= 1
            updateNextPrompt()
        }
    }
    
    @IBAction func goNext(_ sender: NSButton) {
        if selectedIndex != titles.count - 1 {
            self.selectedIndex += 1
            updateNextPrompt()
        }
    }
    
    @IBAction func pickFontSize(_ sender: NSButton) {
        switch sender.title {
        case "24 磅":
            self.fontSize = 24
            break
        case "36 磅":
            self.fontSize = 36
            break
        case "48 磅":
            self.fontSize = 48
            break
        default:
            break
        }

        viewController?.updateLabelSize(to: fontSize)
    }
    
    @IBAction func pickFrameSize(_ sender: NSPopUpButton) {
        switch sender.titleOfSelectedItem {
        case "1920 × 1080":
            frameSize = [1920.0, 1080.0]
            break
        case "1280 × 720":
            frameSize = [1280.0, 720.0]
            break
        case "720 × 480":
            frameSize = [720.0, 480.0]
            break
        default:
            return
        }
        shrinkFrame()
    }
    
    var docData: Data {
        
        get {
            return Data()
            // may not obtain anything
        }
        
        set(inData) {

            if let raw = String(data: inData, encoding: .utf8) {
                print("gotta raw = \(raw)")
                self.titles = raw.components(separatedBy: "\n")
                updateNextPrompt()
            } else {
                showErrorMessage("数据似乎无效？")
            }
        }
    }
    
    var titleWindowController: TransparentWindowController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func showErrorMessage(_ errorMsg: String) {
        let errorAlert: NSAlert = NSAlert()
        errorAlert.messageText = "出错啦"
        errorAlert.informativeText = errorMsg
        errorAlert.addButton(withTitle: "嗯")
        errorAlert.alertStyle = NSAlert.Style.critical
        errorAlert.beginSheetModal(for: self.view.window!, completionHandler: nil)
    }
    
    func updateNextPrompt() {
        viewController?.setText(to: titles[selectedIndex])
        if selectedIndex == 0 {
            self.leftButton.isEnabled = false
        } else {
            self.leftButton.isEnabled = true
        }
        
        if selectedIndex < titles.count - 1 {
            self.rightButton.isEnabled = true
            nextPrompt.stringValue = titles[selectedIndex + 1]
            if nextPrompt.stringValue.remove(" ") == "" {
                nextPrompt.stringValue = "(空)"
            }
        } else {
            nextPrompt.stringValue = "(没有了)"
            self.rightButton.isEnabled = false
        }
    }
    
    @IBAction func switchFade(_ sender: NSButton) {
        viewController?.switchFade()
    }
    
    func shrinkFrame() {
        
        var frame: NSRect = (windowController?.window?.frame)!
        frame.size = NSSize(width: frameSize[0], height: frameSize[1])
        windowController?.window?.setFrame(frame, display: true, animate: true)
        viewController?.updateLabelSize(to: fontSize)
    }
}

