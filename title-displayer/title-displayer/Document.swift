//
//  Document.swift
//  title-displayer
//
//  Created by yuxiqian on 2018/10/4.
//  Copyright © 2018 yuxiqian. All rights reserved.
//

import Cocoa

class Document: NSDocument {
    
    var primaryWindowController: MainWindowController?
    var docData: Data?

    override init() {
        super.init()
        // Add your subclass-specific initialization here.
    }
    

    override func makeWindowControllers() {
        // Returns the Storyboard that contains your Document window.
        let storyboard = NSStoryboard(name: NSStoryboard.Name(rawValue: MainStoryboardIdentifiers.name), bundle: nil)
        let windowController = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: MainStoryboardIdentifiers.documentWindow)) as! MainWindowController
        primaryWindowController = windowController
        self.addWindowController(windowController)
        setWindowContent(data: docData)
    }

    override func data(ofType typeName: String) throws -> Data {
        // Insert code here to write your document to data of the specified type, throwing an error in case of failure.
        // Alternatively, you could remove this method and override fileWrapper(ofType:), write(to:ofType:), or write(to:ofType:for:originalContentsURL:) instead.
        
        if let windowController = primaryWindowController, let viewController = windowController.contentViewController as? MainViewController {
            return viewController.docData
        }
        
        throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }

    override func read(from data: Data, ofType typeName: String) throws {
        // Insert code here to read your document from the given data of the specified type, throwing an error in case of failure.
        // Alternatively, you could remove this method and override read(from:ofType:) instead.
        // If you do, you should also override isEntireFileLoaded to return false if the contents are lazily loaded.
        docData = data //hang on to this data because the window might not exist yet
        setWindowContent(data: data)
    }
    
    private func setWindowContent(data: Data?) {
        if let data = data, let windowController = primaryWindowController, let viewController = windowController.contentViewController as? MainViewController {
            viewController.docData = data
        }
    }

}

enum MainStoryboardIdentifiers {
    static let name = "Main"
    static let documentWindow = "Document Window Controller"
}



