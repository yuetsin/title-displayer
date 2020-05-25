//
//  DisplayerViewController.swift
//  title-displayer
//
//  Created by yuxiqian on 2018/10/5.
//  Copyright © 2018 yuxiqian. All rights reserved.
//

import Cocoa
import YapAnimator

class DisplayerViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    var isFaded: Bool = false
    
    let standardFontSize = 48
    
    var font: NSFont?
    
    func updateLabelSize(to size: Int) {

        titlePlacer.animated?.scale.animate(to: CGFloat(Double(size) / Double(standardFontSize)))
    }
    
    @IBOutlet weak var titlePlacer: NSTextField!
    
    func switchFade() {
        if isFaded {
            self.titlePlacer.animated?.opacity.animate(to: 1.0)
            isFaded = false
        } else {
            self.titlePlacer.animated?.opacity.animate(to: 0.0)
            isFaded = true
        }
    }

    
    func setText(to str: String) {
        if self.titlePlacer.stringValue.sanitize() != "" {
            titlePlacer.animated?.opacity.animate(to: 0.0) {_,_ in
                self.titlePlacer.stringValue = str
                self.titlePlacer.animated?.opacity.animate(to: 1.0)
            }
        } else {
            titlePlacer.animated?.opacity.animate(to: 0.0) {_,_ in
                self.titlePlacer.stringValue = str
                self.titlePlacer.animated?.opacity.animate(to: 1.0)
            }
        }
        isFaded = false
    }
    
    @IBAction func adjustFont(_ sender: Any) {
        self.font = titlePlacer.font!
        let fontManager: NSFontManager = NSFontManager.shared
        fontManager.target = self
        fontManager.setSelectedFont(self.font!, isMultiple: false)
        fontManager.action = #selector(changeFont(_:))
        fontManager.orderFrontFontPanel(self)
    }
}

extension NSFontManager {
    override open func changeFont(_ sender: Any?) {
        
    }
}
