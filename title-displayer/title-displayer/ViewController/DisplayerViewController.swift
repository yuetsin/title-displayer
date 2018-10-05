//
//  DisplayerViewController.swift
//  title-displayer
//
//  Created by yuxiqian on 2018/10/5.
//  Copyright © 2018 yuxiqian. All rights reserved.
//

import Cocoa

class DisplayerViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @objc dynamic var fontSize = 24
    
    func updateLabelSize(to size: Int) {
        let width = Int(self.titlePlacer.frame.width)
        let newSize = NSSize(width: width, height: size + 5)
        titlePlacer.setFrameSize(newSize)
        fontSize = size
    }
    
    @IBOutlet weak var titlePlacer: NSTextField!
    
    func fadeOut() {
        
    }
}
