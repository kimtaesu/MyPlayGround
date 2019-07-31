//
//  ViewController.swift
//  PlayGround
//
//  Created by tskim on 27/07/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import UIKit
import OpenPulbic

class LifeCycleViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    print("1: viewDidLoad")
  }
  override func viewWillAppear(_ animated: Bool) {
    print("1: viewWillAppear")
  }
  override func viewWillLayoutSubviews() {
    
    print("1: viewWillLayoutSubviews \(self.view.bounds)")
  }
  override func viewDidLayoutSubviews() {
    print("1: viewDidLayoutSubviews")
  }
  
  override func viewDidAppear(_ animated: Bool) {
    print("1: viewDidAppear")
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    print("1: viewWillDisappear")
  }
  override func viewDidDisappear(_ animated: Bool) {
    print("1: viewDidDisappear")
  }
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    print("1: viewWillTransition")
  }
}
