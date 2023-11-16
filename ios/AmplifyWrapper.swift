//
//  AmplifyWrapper.swift
//  bringSwiftUIToReactNative2
//
//  Created by Chong Jhuang Hung on 07/11/2023.
//

import Amplify
import AWSCognitoAuthPlugin

@objc
class AmplifyWrapper: NSObject {
    override init() {
        super.init()
    }
    @objc
    public func initialize() {
        do {
            print("Start trying configure with Auth")
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.configure()
            print("Amplify configured with Auth")
        } catch {
            print("Failed to initialize Amplify with \(error)")
        }
    }
    @objc
    public func recordEvent(name: String, category: String, accountId: String) {
        let properties: AnalyticsProperties = [ "category": category, "accountId": accountId]
        let event = BasicAnalyticsEvent(name: name, properties: properties)
        Amplify.Analytics.record(event: event)
    }
}
