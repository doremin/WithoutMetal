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

func render(model: Model) {
  // Like Vertex Shader
  // clear frame buffer
  clearRenderBuffer()
  
  // clear depthBuffer
  for index in depthBuffer.indices {
    depthBuffer[index] = .infinity
  }
  
  // Like Fragment Shader
  let transformedTriangles = transform(model: model)
}

func transform(model: Model) -> [Triangle] {
  let transform = model.transoform
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
        
        return newVertex
      }
    )
  }
  
  return triangles
}

func project() {
  
}

func draw(triangle: Triangle) {
  
}
