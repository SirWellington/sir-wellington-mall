//
//  AromaRequest.swift
//  AromaSwiftClient
//
//  Created by Juan Wellington Moreno on 4/6/16.
//  Copyright © 2016 RedRoma, Inc. All rights reserved.
//

import AromaThrift
import Foundation
import SwiftExceptionCatcher

public struct AromaRequest : Equatable
{

    public enum Priority: UInt32
    {
        case LOW
        case MEDIUM
        case HIGH

        func toThrift() -> UInt32
        {
            switch self
            {
                case .LOW : return Urgency_LOW.rawValue
                case .MEDIUM : return Urgency_MEDIUM.rawValue
                case .HIGH : return Urgency_HIGH.rawValue
            }
        }
    }


    //MARK: Public properties
    public var title: String = ""
    public var body: String? = ""
    public var priority: AromaRequest.Priority = .LOW
    public var deviceName: String = AromaClient.deviceName

}


public func == (lhs: AromaRequest, rhs: AromaRequest) -> Bool
{

    if !equals(lhs.title, right: rhs.title)
    {
        return false
    }

    if !equals(lhs.body, right: rhs.body)
    {
        return false
    }

    if !equals(lhs.priority, right: rhs.priority)
    {
        return false
    }

    if !equals(lhs.deviceName, right: rhs.deviceName)
    {
        return false
    }

    return true
}

func equals<T:Equatable> (left: T?, right: T?) -> Bool
{

    if let left = left, let right = right
    {
        return left == right
    }

    return left == nil && right == nil

}

//MARK: Public APIs
extension AromaRequest
{

    public func addBody(body: String) -> AromaRequest
    {
        let newBody = (self.body ?? "") + body
        return AromaRequest(title: title, body: newBody, priority: priority, deviceName: deviceName)
    }

    public func addLine(number: Int = 1) -> AromaRequest
    {
        
        guard number > 0 else { return self }
        
        let newLineCharacter = Character("\n")
        let newBody = (self.body ?? "") + String(count: number, repeatedValue: newLineCharacter)
        
        return AromaRequest(title: title, body: newBody, priority: priority, deviceName: deviceName)
    }

    public func withDeviceName(deviceName: String) -> AromaRequest
    {
        return AromaRequest(title: title, body: body, priority: priority, deviceName: deviceName)
    }

    public func withTitle(title: String) -> AromaRequest
    {
        return AromaRequest(title: title, body: body, priority: priority, deviceName: deviceName)
    }

    public func withPriority(priority: AromaRequest.Priority) -> AromaRequest
    {
        return AromaRequest(title: title, body: body, priority: priority, deviceName: deviceName)
    }

    public func send(onError: AromaClient.OnError? = nil, onDone: AromaClient.OnDone? = nil)
    {
        AromaClient.send(self, onError: onError, onDone: onDone)
    }
}
