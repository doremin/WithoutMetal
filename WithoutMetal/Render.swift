//
//  Render.swift
//  WithoutMetal
//
//  Created by doremin on 2022/11/17.
//

import Foundation
import QuartzCore

/*
 If you don't use depth buffer, it might be look weird.
 Because it might happen that a triangle far from camera overlap near triangle.
 */

fileprivate let useDepthBuffer = true
fileprivate var depthBuffer = [Float](repeating: .infinity, count: context!.width * context!.height)

func render(model: Model, camera: Camera) {
  // Like Vertex Shader
  // clear frame buffer
  clearRenderBuffer()
  
  // clear depthBuffer
  for index in depthBuffer.indices {
    depthBuffer[index] = .infinity
  }
  
  // Like Fragment Shader
  // transform and project vertices
  let transformedTriangles = transformAndProject(model: model, camera: camera)
  for triangle in transformedTriangles {
    draw(triangle: triangle)
  }
}

// this function transforms model into 2d scrren vertex
func transformAndProject(model: Model, camera: Camera) -> [Triangle] {
  let transform = model.transoform
  let width = context!.width
  let height = context!.height
  
  let triangles = model.triangles.map { triangle in
    return Triangle(
      vertices: triangle.vertices.map { vertex in
        var newVertex = vertex
        
        // adjust origin
        newVertex.x -= model.originX
        newVertex.y -= model.originY
        newVertex.z -= model.originZ
        
        // scale
        newVertex.x *= transform.modelScaleX
        newVertex.y *= transform.modelScaleY
        newVertex.z *= transform.modelScaleZ
        
        // rotation
        
        // Rotate about the X-axis
        newVertex.y =  cos(transform.modelRotateX) * newVertex.y + sin(transform.modelRotateX) * newVertex.z
        newVertex.z = -sin(transform.modelRotateX) * newVertex.y + cos(transform.modelRotateX) * newVertex.z
        
        // Rotate about the Y-axis
        newVertex.x =  cos(transform.modelRotateY) * newVertex.x + sin(transform.modelRotateY) * newVertex.z
        newVertex.z = -sin(transform.modelRotateY) * newVertex.x + cos(transform.modelRotateY) * newVertex.z
        
        // Rotate about the Z-axis
        newVertex.x =  cos(transform.modelRotateZ) * newVertex.x + sin(transform.modelRotateZ) * newVertex.y
        newVertex.y = -sin(transform.modelRotateZ) * newVertex.x + cos(transform.modelRotateZ) * newVertex.y
        
        // rotate normal vector
        newVertex.ny =  cos(transform.modelRotateX) * newVertex.ny + sin(transform.modelRotateX) * newVertex.nz
        newVertex.nz = -sin(transform.modelRotateX) * newVertex.ny + cos(transform.modelRotateX) * newVertex.nz
        
        // Rotate about the Y-axis
        newVertex.nx =  cos(transform.modelRotateY) * newVertex.nx + sin(transform.modelRotateY) * newVertex.nz
        newVertex.nz = -sin(transform.modelRotateY) * newVertex.nx + cos(transform.modelRotateY) * newVertex.nz
        
        // Rotate about the Z-axis
        newVertex.nx =  cos(transform.modelRotateZ) * newVertex.nx + sin(transform.modelRotateZ) * newVertex.ny
        newVertex.ny = -sin(transform.modelRotateZ) * newVertex.nx + cos(transform.modelRotateZ) * newVertex.ny
        
        // transform
        newVertex.x += transform.modelX
        newVertex.y += transform.modelY
        newVertex.z += transform.modelZ
        
        // move object to camera space
        newVertex.x -= camera.cameraX
        newVertex.y -= camera.cameraY
        newVertex.z -= camera.cameraZ
        
        // skip rotation camera...
        // 카메라가 보는 world는 V * x_view = M * x_model -> x_view = V^-1 * M * x_model이다.
        // 그리고 V^-1 * M을 model view matrix라고 한다.
        
        // project to 2D by simple way
        // place object far away from camera to avoid divide by zero
        newVertex.x /= (newVertex.z + 100) * 0.01
        newVertex.y /= (newVertex.z + 100) * 0.01
        
        newVertex.x *= Float(height / 80)
        newVertex.y *= Float(height / 80)
        
        // set origin to center of screen
        newVertex.x += Float(width / 2)
        newVertex.y += Float(height / 2)
        
        return newVertex
      }
    )
  }
  
  return triangles
}

fileprivate func isInsideViewport(vertex: Vertex) -> Bool {
  let width = Float(context!.width)
  let height = Float(context!.height)
  
  return vertex.x >= 0 && vertex.x < width && vertex.y >= 0 && vertex.y < height
}

func draw(triangle: Triangle) {
  guard isInsideViewport(vertex: triangle.vertices[0])
      && isInsideViewport(vertex: triangle.vertices[1])
      && isInsideViewport(vertex: triangle.vertices[2]) else {
    return
  }
  
  var spans = [Span](repeating: Span(), count: Int(context!.height))
  
  spans = decideEdges(spans: spans, from: triangle.vertices[0], to: triangle.vertices[1])
  spans = decideEdges(spans: spans, from: triangle.vertices[1], to: triangle.vertices[2])
  spans = decideEdges(spans: spans, from: triangle.vertices[2], to: triangle.vertices[0])
  
  for (i, span) in spans.enumerated() {
    drawSpan(span: span, yPosition: i)
  }
}

func decideEdges(spans: [Span], from: Vertex, to: Vertex) -> [Span] {
  let deltaY = to.y - from.y
  
  guard deltaY != 0 else {
    return spans
  }
  
  let (start, end) = deltaY > 0 ? (from, to) : (to, from)
  
  let endY = Int(round(end.y))
  var positionY = Int(round(start.y))
  let length = abs(deltaY)
  
  let stepX = (end.x - start.x) / length
  var positionX = start.x
  
  let stepZ = (end.z - start.z) / length
  var positionZ = start.z
  
  let stepR = (end.r - start.r) / length
  var positionR = start.r
  
  let stepG = (end.g - start.g) / length
  var positionG = start.g
  
  let stepB = (end.b - start.b) / length
  var positionB = start.b
  
  let stepA = (end.a - start.a) / length
  var positionA = start.a
  
  let stepNX = (end.nx - start.nx) / length
  var positionNX = start.nx
  
  let stepNY = (end.ny - start.ny) / length
  var positionNY = start.ny
  
  let stepNZ = (end.nz - start.nz) / length
  var positionNZ = start.nz
  
  var spans = spans
  
  while positionY < endY {
    let x = positionX
    
    if positionY >= 0 && positionY < spans.count {
      spans[positionY].edges.append(
        Edge(
        x: Int(round(x)),
        r: positionR, g: positionG, b: positionB, a: positionA,
        z: positionZ,
        nx: positionNX, ny: positionNY, nz: positionNZ))
    }
    
    positionY += 1
    positionX += stepX
    positionZ += stepZ
    positionR += stepR
    positionG += stepG
    positionB += stepB
    positionA += stepA
    positionNX += stepNX
    positionNY += stepNY
    positionNZ += stepNZ
  }
  
  return spans
}

func drawSpan(span: Span, yPosition y: Int) {
  guard span.edges.count == 2 else {
    return
  }
  
  let edgeDistance = span.right.x - span.left.x
  
  let light = Light()
  
  for x in span.left.x ..< span.right.x {
    let alpha = Float((x - span.left.x)) / Float(edgeDistance)

    var r = (1 - alpha) * span.left.r + alpha * span.right.r
    var g = (1 - alpha) * span.left.g + alpha * span.right.g
    var b = (1 - alpha) * span.left.b + alpha * span.right.b
    let a = (1 - alpha) * span.left.a + alpha * span.right.a

    let nx = (1 - alpha) * span.left.nx + alpha * span.right.nx
    let ny = (1 - alpha) * span.left.ny + alpha * span.right.ny
    let nz = (1 - alpha) * span.left.nz + alpha * span.right.nz

    var shouldDrawPixel = true
    if useDepthBuffer {
      let z = (1 - alpha) * span.left.z + alpha * span.right.z
      let offset = x + y * Int(context!.width)
      if depthBuffer[offset] > z {
        depthBuffer[offset] = z
      } else {
        shouldDrawPixel = false
      }
    }

    if shouldDrawPixel {
      
      // ambient
      r = r * light.ambientR * light.ambientIntensity
      g = g * light.ambientG * light.ambientIntensity
      b = b * light.ambientB * light.ambientIntensity
      
      // difuse
      let factor = max(-1 * (nx * light.diffuseX + ny * light.diffuseY + nz * light.diffuseZ), 0)
      
      r += factor * light.diffuseR * light.diffuseIntensity
      g += factor * light.diffuseG * light.diffuseIntensity
      b += factor * light.diffuseB * light.diffuseIntensity

      setPixel(x: x, y: y, r: r, g: g, b: b, a: a)
    }

  }
}
