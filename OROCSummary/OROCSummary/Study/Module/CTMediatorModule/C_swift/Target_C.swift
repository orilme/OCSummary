//
//  Target_C.swift
//  C_swift
//
//  Created by casa on 2017/1/4.
//  Copyright © 2017年 casa. All rights reserved.
//

import UIKit

@objc class Target_C: NSObject {

    @objc func Action_Extension_ViewController(_ params:NSDictionary) -> UIViewController {
        if let callback = params["callback"] as? (String) -> Void {
            callback("success")
        }

        let cViewController = ViewController()
        return cViewController
    }
    
    @objc func Action_Category_ViewController(_ params:NSDictionary) -> UIViewController {
        
        if let block = params["callback"] {
            
            typealias CallbackType = @convention(block) (NSString) -> Void
            let blockPtr = UnsafeRawPointer(Unmanaged<AnyObject>.passUnretained(block as AnyObject).toOpaque())
            let callback = unsafeBitCast(blockPtr, to: CallbackType.self)
            
            callback("success")
        }
        
        let cViewController = ViewController()
        return cViewController
    }
}
