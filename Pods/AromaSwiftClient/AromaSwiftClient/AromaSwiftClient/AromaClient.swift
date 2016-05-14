//
//  AromaClient.swift
//  AromaSwiftClient
//
//  Created by Juan Wellington Moreno on 4/4/16.
//  Copyright © 2016 RedRoma, Inc. All rights reserved.
//

import AromaThrift
import Foundation
import SwiftExceptionCatcher


public class AromaClient
{

    public typealias OnDone = () -> Void
    public typealias OnError = (ErrorType) -> Void

    //Endpoint management
    private static let DEFAULT_ENDPOINT = ApplicationService_ApplicationServiceConstants.PRODUCTION_ENDPOINT()
  
    public static var hostname = DEFAULT_ENDPOINT.hostname
    public static var port = UInt32(DEFAULT_ENDPOINT.port)
    
    
    //Defaults
    public static var deviceName: String = UIDevice.currentDevice().name

    //Async and Threading
    private static let async = NSOperationQueue()
    private static let main = NSOperationQueue.mainQueue()
    public static var maxConcurrency: Int = 1 {
        didSet
        {
            if maxConcurrency >= 1
            {
                async.maxConcurrentOperationCount = maxConcurrency
            }
        }
    }

    //Token Management
    public static var TOKEN_ID: String = ""
    private static var APP_TOKEN: ApplicationService_ApplicationToken?
    {
        guard !TOKEN_ID.isEmpty else { return nil }

        let token = ApplicationService_ApplicationToken()
        token.tokenId = TOKEN_ID
        return token
    }

     static func createThriftClient() -> ApplicationService_ApplicationService
     {

        let tTransport = TSocketClient(hostname: AromaClient.hostname, port: AromaClient.port)
        let tProtocol = TBinaryProtocol(transport: tTransport)

        return ApplicationService_ApplicationServiceClient(withProtocol: tProtocol)
    }
}

//MARK : API
extension AromaClient {

    public static func beginWithTitle(title: String) -> AromaRequest
    {
        return AromaRequest().withTitle(title)
    }

    public static func send(message: AromaRequest, onError: AromaClient.OnError? = nil, onDone: AromaClient.OnDone? = nil)
    {

        guard !message.title.isEmpty else
        {
            onDone?()
            return
        }

        self.async.addOperationWithBlock()
        {

            defer
            {
                if let callback = onDone
                {
                    callback()
                }
            }

            let request = self.toRequestObject(message)
            let client = self.createThriftClient()

            do
            {
                let _ = try tryOp() { client.sendMessage(request) }
                //Message successfully sent
            }
            catch let ex
            {
                print("Failed to send AromaMessage \(message) : \(ex)")

                if let callback = onError
                {
//                    AromaClient.main.addOperationWithBlock() { callback(ex) }
                    callback(ex)
                }
            }

        }
    }

    public static func sendHighPriorityMessage(withTitle title: String, withBody body: String? = nil, onError: AromaClient.OnError? = nil, onDone: AromaClient.OnDone? = nil)
    {
        let request = AromaRequest().withTitle(title).addBody(body ?? "").withPriority(.HIGH)
        send(request, onError: onError, onDone: onDone)
    }

    public static func sendMediumPriorityMessage(withTitle title: String, withBody body: String? = nil, onError: AromaClient.OnError? = nil, onDone: AromaClient.OnDone? = nil)
    {
        let request = AromaRequest().withTitle(title).addBody(body ?? "").withPriority(.MEDIUM)
        send(request, onError: onError, onDone: onDone)
    }

    public static func sendLowPriorityMessage(withTitle title: String, withBody body: String? = nil, onError: AromaClient.OnError? = nil, onDone: AromaClient.OnDone? = nil)
    {
        let request = AromaRequest().withTitle(title).addBody(body ?? "").withPriority(.LOW)
        send(request, onError: onError, onDone: onDone)
    }

}

extension AromaClient
{

    private static func toRequestObject(message: AromaRequest) -> ApplicationService_SendMessageRequest
    {

        let request = ApplicationService_SendMessageRequest()
        request.body = message.body
        request.title = message.title
        request.hostname = message.deviceName
        request.timeOfMessage = currentTimestamp
        request.urgency = Int32(message.priority.toThrift())

        //We set the App Token
        request.applicationToken = APP_TOKEN

        return request
    }

    private static var currentTimestamp: Aroma_timestamp
    {
        let now = NSDate()
        return Aroma_timestamp(now.timeIntervalSince1970 * 1000)
    }
}
