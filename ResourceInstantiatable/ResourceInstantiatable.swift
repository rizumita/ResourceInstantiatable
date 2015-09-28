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
    func instantiate() -> InstanceType
    func instantiate(configure: (InstanceType -> Void)?) -> InstanceType
}

public extension ResourceInstantiatable {
    func instantiate(configure: (InstanceType -> Void)?) -> InstanceType {
        let instance = instantiate()
        configure?(instance)
        return instance
    }
}
