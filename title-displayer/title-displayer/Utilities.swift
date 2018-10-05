//
//  Utilities.swift
//  title-displayer
//
//  Created by yuxiqian on 2018/10/5.
//  Copyright © 2018 yuxiqian. All rights reserved.
//

import Foundation

extension String {
    
    func remove(_ s: String) -> String {
        return self.replacingOccurrences(of: s, with: "")
    }
    func sanitize() -> String {
        return self.remove(" ").remove("\t")
    }
}
