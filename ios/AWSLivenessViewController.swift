//
//  AWSLivenessViewController.swift
//  bringSwiftUIToReactNative2
//
//  Created by Chong Jhuang Hung on 06/11/2023.
//

import UIKit
import SwiftUI

class AWSLivenessViewController: UIViewController {
    @IBOutlet weak var theContainer: UIView!
    let awsLivenessView = UIHostingController(rootView: AWSFaceLivenessView())

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        awsLivenessView.view.frame = view.frame
//        awsLivenessView.view.bounds = view.bounds
        awsLivenessView.view.frame = theContainer.bounds
//        awsLivenessView.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addChild(awsLivenessView)
//        view.addSubview(awsLivenessView.view)
//        setupConstraints()
        theContainer.addConstrained(subview: awsLivenessView.view)
//      awsLivenessView.didMove(toParent: self)
    }
  
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        awsLivenessView.view.frame = view.frame
        awsLivenessView.view.bounds = view.bounds
    }
    
    fileprivate func setupConstraints() {
        awsLivenessView.view.translatesAutoresizingMaskIntoConstraints = false
        awsLivenessView.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        awsLivenessView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        awsLivenessView.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        awsLivenessView.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }

}

extension UIView {
    func addConstrained(subview: UIView) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.topAnchor.constraint(equalTo: topAnchor).isActive = true
        subview.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        subview.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        subview.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
