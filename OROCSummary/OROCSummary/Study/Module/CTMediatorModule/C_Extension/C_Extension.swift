//
//  C_Extension.swift
//  C_Extension
//
//  Created by casa on 2018/8/23.
//  Copyright © 2018年 casa. All rights reserved.
//

import CTMediator

public extension CTMediator {
    @objc public func C_showSwift(callback:@escaping (String) -> Void) -> UIViewController? {
        let params = [
            "callback":callback,
            kCTMediatorParamsKeySwiftTargetModuleName:"C_swift"
            ] as [AnyHashable : Any]
        if let viewController = self.performTarget("C", action: "Extension_ViewController", params: params, shouldCacheTarget: false) as? UIViewController {
            return viewController
        }
        return nil
    }
    
    @objc public func C_showObjc(callback:@escaping (String) -> Void) -> UIViewController? {
        let callbackBlock = callback as @convention(block) (String) -> Void
        let callbackBlockObject = unsafeBitCast(callbackBlock, to: AnyObject.self)
        let params = ["callback":callbackBlockObject] as [AnyHashable:Any]
        if let viewController = self.performTarget("C", action: "Extension_ViewController", params: params, shouldCacheTarget: false) as? UIViewController {
            return viewController
        }
        return nil
    }
}
