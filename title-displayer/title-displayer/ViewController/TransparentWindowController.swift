//
//  TransparentWindowController.swift
//  title-displayer
//
//  Created by yuxiqian on 2018/10/4.
//  Copyright © 2018 yuxiqian. All rights reserved.
//

import Cocoa

class TransparentWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        window?.isOpaque = false
        window?.backgroundColor = NSColor.clear
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }

}
