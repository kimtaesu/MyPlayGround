//
//  ChildLifeCycleViewController.swift
//  PlayGround
//
//  Created by tskim on 30/07/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import UIKit
import OpenPulbic
class ChildLifeCycleViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print("2: viewDidLoad")
  }
  override func viewWillAppear(_ animated: Bool) {
    print("2: viewWillAppear")
  }
  override func viewWillLayoutSubviews() {
    print("2: viewWillLayoutSubviews")
  }
  override func viewDidLayoutSubviews() {
    print("2: viewDidLayoutSubviews")
  }
  
  override func viewDidAppear(_ animated: Bool) {
    print("2: viewDidAppear")
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    print("2: viewWillDisappear")
  }
  override func viewDidDisappear(_ animated: Bool) {
    print("2: viewDidDisappear")
  }
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    print("2: viewWillTransition")
  }
}

