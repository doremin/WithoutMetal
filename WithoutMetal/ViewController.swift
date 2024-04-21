//
//  ViewController.swift
//  WithoutMetal
//
//  Created by doremin on 2022/11/17.
//

import UIKit

class ViewController: UIViewController {
  
  var model = Cube.default
  var camera = Camera()
  var previousTime: CFTimeInterval = CACurrentMediaTime()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let timer = Timer(
      timeInterval: 0.01,
      target: self, selector: #selector(self.draw),
      userInfo: nil, repeats: true
    )
    RunLoop.current.add(timer, forMode: .default)
    
    self.view.addGestureRecognizer(
      UIPanGestureRecognizer(target: self, action: #selector(handleDrag))
    )
  }
  
  @objc
  func handleDrag(sender: UIPanGestureRecognizer) {
    let x = sender.translation(in: self.view).x
    let y = sender.translation(in: self.view).y
    
    self.model.transoform.modelRotateY -= Float(x) * 0.01
    self.model.transoform.modelRotateX -= Float(y) * 0.01
  }

  @objc
  func draw() {
    self.model.transoform.modelRotateY += 0.1
    self.model.transoform.modelRotateX += 0.01
    render(model: self.model, camera: self.camera)
    presentRenderBuffer(layer: self.view.layer)
  }

}


