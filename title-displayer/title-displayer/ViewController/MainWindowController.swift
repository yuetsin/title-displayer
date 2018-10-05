//
//  MainWindowController.swift
//  title-displayer
//
//  Created by yuxiqian on 2018/10/5.
//  Copyright © 2018 yuxiqian. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        shouldCascadeWindows = true
        // 让多个字幕窗口层叠显示
    }

    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        
        self.window?.level = NSWindow.Level.statusBar
    }

}
