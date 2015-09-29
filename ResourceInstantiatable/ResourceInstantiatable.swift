//
//  ResourceInstantiatable.swift
//  ResourceInstantiatable
//
//  Created by 和泉田 領一 on 2015/09/28.
//  Copyright © 2015年 CAPH. All rights reserved.
//

import Foundation

public protocol ResourceInstantiatable {
    
    typealias InstanceType

    func instantiate() throws -> InstanceType

    func instantiate(configure: (inout InstanceType) -> Void) throws -> InstanceType

}

public extension ResourceInstantiatable {

    func instantiate(configure: (inout InstanceType) -> Void) throws -> InstanceType {
        var instance = try instantiate()
        configure(&instance)
        return instance
    }

}
