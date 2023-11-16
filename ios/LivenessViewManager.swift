//
//  LivenessViewManager.swift
//  bringSwiftUIToReactNative2
//
//  Created by Chong Jhuang Hung on 06/11/2023.
//

import Foundation
import UIKit
import SwiftUI

@objc(LivenessViewManager)
class LivenessViewManager: RCTViewManager {
  
  override var methodQueue: DispatchQueue! {
    return DispatchQueue(label: "com.amazonaws.faceliveness.cameracapturequeue")
  }
  
  override static func requiresMainQueueSetup() -> Bool {
    return true
  }
  
  override func view() -> UIView! {
    let awsLivenessViewVC = UIHostingController(rootView: AWSFaceLivenessView())
    return awsLivenessViewVC.view
//    return AWSLivenessViewController().view
  }

  @objc(presentViewController)
  func presentViewController() {
    DispatchQueue.main.async {
//      let viewController = AWSLivenessViewController()
      let awsLivenessViewVC = UIHostingController(rootView: AWSFaceLivenessView())
      let rootViewController = RCTPresentedViewController()

//      rootViewController?.present(viewController, animated: true, completion: nil)
      rootViewController?.present(awsLivenessViewVC, animated: true, completion: nil)
    }
  }}
