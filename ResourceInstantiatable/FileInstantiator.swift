//
//  FileInstantiator.swift
//  ResourceInstantiatable
//
//  Created by 和泉田 領一 on 2015/09/29.
//  Copyright © 2015年 CAPH. All rights reserved.
//

import Foundation

public protocol FileInstantiatable: ResourceInstantiatable {

    var initialize: String throws -> InstanceType? { get }

}

public struct FileInstantiator<T>: FileInstantiatable {

    public typealias InstanceType = T

    public let name: String
    public let type: String?
    public let bundle: NSBundle
    public let initialize: String throws -> InstanceType?

    public func instantiate() throws -> InstanceType {
        guard let path = bundle.pathForResource(name, ofType: type) else {
            throw ResourceInstantiatableError.CannotRetrieveResourcePath
        }
        guard let initialized = try? initialize(path), let result = initialized else {
            throw ResourceInstantiatableError.CannotInstantiate
        }

        return result
    }
    
    init(name: String, type: String? = nil, bundle: NSBundle = NSBundle.mainBundle(), initialize: String throws -> InstanceType?) {
        self.name = name
        self.type = type
        self.bundle = bundle
        self.initialize = initialize
    }

}
