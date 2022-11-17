//
//  Support.swift
//  WithoutMetal
//
//  Created by doremin on 2022/11/17.
//

import Foundation
import UIKit
import QuartzCore

fileprivate let width = Int(UIScreen.main.bounds.width)
fileprivate let height = Int(UIScreen.main.bounds.height)

let context = CGContext(data: nil, width: width, height: height,
                        bitsPerComponent: 8, bytesPerRow: width * 4,
                        space: CGColorSpaceCreateDeviceRGB(),
                        bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)

// aBGR
func clearRenderBuffer(aBGRHexColor: UInt32 = 0xff000000) {
  guard let context = context, let pixels = context.data else {
    return
  }
  
  let size = context.width * 4 * context.height
  
  for i in stride(from: 0, to: size, by: 4) {
    pixels.storeBytes(of: aBGRHexColor, toByteOffset: i, as: UInt32.self)
  }
}

func setPixel(x: Int, y: Int, r: Float, g: Float, b: Float, a: Float) {
  guard let context = context, let pixels = context.data else {
    return
  }
  
  let width = context.width
  let height = context.height
  
  guard x >= 0 && x < width && y >= 0 && y < height else {
    return
  }
  
  let offset = (y * width + x) * 4
  let color: UInt32 = (UInt32(a * 255) << 24) | (UInt32(b * 255) << 16) | (UInt32(g * 255) <<  8) | (UInt32(r * 255))
  
  pixels.storeBytes(of: color, toByteOffset: offset, as: UInt32.self)
}

func presentRenderBuffer(layer: CALayer) {
  if let image = context?.makeImage() {
    layer.contents = image
  }
}
