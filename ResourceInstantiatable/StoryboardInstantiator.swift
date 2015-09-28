//
//  StoryboardInstantiator.swift
//  ResourceInstantiatable
//
//  Created by 和泉田 領一 on 2015/09/28.
//  Copyright © 2015年 CAPH. All rights reserved.
//

import Foundation

public struct StoryboardInstantiator<T: UIViewController>: ResourceInstantiatable {
    public typealias InstanceType = T
    
    let name: String
    let bundle: NSBundle?
    let identifier: String?
    
    public func instantiate() -> InstanceType {
        let storyboard = UIStoryboard(name: name, bundle: bundle)
        if let identifier = identifier {
            return storyboard.instantiateViewControllerWithIdentifier(identifier) as! InstanceType
        } else {
            return storyboard.instantiateInitialViewController() as! InstanceType
        }
    }
    
    init(name: String, bundle: NSBundle? = nil, identifier: String? = nil) {
        self.name = name
        self.bundle = bundle
        self.identifier = identifier
    }
}
