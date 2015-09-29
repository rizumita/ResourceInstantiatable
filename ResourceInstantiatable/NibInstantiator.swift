//
//  NibInstantiator.swift
//  ResourceInstantiatable
//
//  Created by 和泉田 領一 on 2015/09/28.
//  Copyright © 2015年 CAPH. All rights reserved.
//

import Foundation

public struct NibInstantiator<T: UIView>: ResourceInstantiatable {

    public typealias InstanceType = T
    
    let name: String
    let bundle: NSBundle
    
    public func instantiate() throws -> InstanceType {
        let nib = UINib(nibName: name, bundle: bundle)
        return nib.instantiateWithOwner(nil, options: nil).first as! InstanceType
    }
    
    init(name: String, bundle: NSBundle = NSBundle.mainBundle()) {
        self.name = name
        self.bundle = bundle
    }

}
