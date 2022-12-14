//
//  Promitives.swift
//  WithoutMetal
//
//  Created by doremin on 2022/11/17.
//

import Foundation

struct Vertex {
  // Coordinate
  var x: Float
  var y: Float
  var z: Float
  
  // Color
  var r: Float
  var g: Float
  var b: Float
  var a: Float
  
  // Normal vector
  var nx: Float
  var ny: Float
  var nz: Float
}

struct ModelTransformation {
  // Transformation = T*R*S*x
  var modelX: Float = 0
  var modelY: Float = 0
  var modelZ: Float = 0

  var modelScaleX: Float = 1
  var modelScaleY: Float = 1
  var modelScaleZ: Float = 1

  var modelRotateX: Float = 0
  var modelRotateY: Float = 0
  var modelRotateZ: Float = 0
  
  var modelOriginX: Float = 0
  var modelOriginY: Float = 0
  var modelOriginZ: Float = 0
}

struct Camera {
  var cameraX: Float = 0
  var cameraY: Float = 0
  var cameraZ: Float = -20
}

struct Light {
  var ambientR: Float = 1
  var ambientG: Float = 1
  var ambientB: Float = 1
  var ambientIntensity: Float = 0.2
  
  var diffuseR: Float = 1
  var diffuseG: Float = 1
  var diffuseB: Float = 1
  var diffuseIntensity: Float = 0.8

  var diffuseX: Float = 0
  var diffuseY: Float = 0
  var diffuseZ: Float = 1
}

protocol Primitive {
  var vertices: [Vertex] { get }
}

protocol Model {
  var triangles: [Triangle] { get }
  var transoform: ModelTransformation { get set }
  
  // model's origin point
  var originX: Float { get set }
  var originY: Float { get set }
  var originZ: Float { get set }
}

struct Triangle: Primitive {
  let vertices: [Vertex]
}

struct Cube: Model {
  var originX: Float = 0
  var originY: Float = 0
  var originZ: Float = 0
  
  var transoform =  ModelTransformation()
  let triangles: [Triangle]
  
  static let `default`: Self = {
    let model = Cube(triangles: [
        Triangle(vertices: [
          Vertex(x: -10, y: -10, z:  10, r: 0, g: 0, b: 1, a: 1, nx: 0, ny: 0, nz: 1),
          Vertex(x: -10, y:  10, z:  10, r: 0, g: 0, b: 1, a: 1, nx: 0, ny: 0, nz: 1),
          Vertex(x:  10, y: -10, z:  10, r: 0, g: 0, b: 1, a: 1, nx: 0, ny: 0, nz: 1)
        ]),
        Triangle(vertices: [
          Vertex(x: -10, y:  10, z:  10, r: 0, g: 0, b: 1, a: 1, nx: 0, ny: 0, nz: 1),
          Vertex(x:  10, y: -10, z:  10, r: 0, g: 0, b: 1, a: 1, nx: 0, ny: 0, nz: 1),
          Vertex(x:  10, y:  10, z:  10, r: 0, g: 0, b: 1, a: 1, nx: 0, ny: 0, nz: 1)
        ]),
        Triangle(vertices: [
          Vertex(x: -10, y: -10, z: -10, r: 1, g: 0, b: 0, a: 1, nx: 0, ny: 0, nz: -1),
          Vertex(x:  10, y: -10, z: -10, r: 0, g: 1, b: 0, a: 1, nx: 0, ny: 0, nz: -1),
          Vertex(x:  10, y:  10, z: -10, r: 0, g: 0, b: 1, a: 1, nx: 0, ny: 0, nz: -1)
        ]),
        Triangle(vertices: [
          Vertex(x: -10, y: -10, z: -10, r: 1, g: 1, b: 0, a: 1, nx: 0, ny: 0, nz: -1),
          Vertex(x:  10, y:  10, z: -10, r: 0, g: 1, b: 1, a: 1, nx: 0, ny: 0, nz: -1),
          Vertex(x: -10, y:  10, z: -10, r: 1, g: 0, b: 1, a: 1, nx: 0, ny: 0, nz: -1)
        ]),
        Triangle(vertices: [
          Vertex(x: -10, y:  10, z: -10, r: 1, g: 0, b: 0, a: 1, nx: 0, ny: 1, nz: 0),
          Vertex(x: -10, y:  10, z:  10, r: 1, g: 0, b: 0, a: 1, nx: 0, ny: 1, nz: 0),
          Vertex(x:  10, y:  10, z: -10, r: 1, g: 0, b: 0, a: 1, nx: 0, ny: 1, nz: 0)
        ]),
        Triangle(vertices: [
          Vertex(x: -10, y:  10, z:  10, r: 1, g: 0, b: 0, a: 1, nx: 0, ny: 1, nz: 0),
          Vertex(x:  10, y:  10, z: -10, r: 1, g: 0, b: 0, a: 1, nx: 0, ny: 1, nz: 0),
          Vertex(x:  10, y:  10, z:  10, r: 1, g: 0, b: 0, a: 1, nx: 0, ny: 1, nz: 0)
        ]),
        Triangle(vertices: [
          Vertex(x: -10, y: -10, z: -10, r: 1, g: 1, b: 1, a: 1, nx: 0, ny: -1, nz: 0),
          Vertex(x:  10, y: -10, z: -10, r: 1, g: 1, b: 1, a: 1, nx: 0, ny: -1, nz: 0),
          Vertex(x: -10, y: -10, z:  10, r: 1, g: 1, b: 1, a: 1, nx: 0, ny: -1, nz: 0)
        ]),
        Triangle(vertices: [
          Vertex(x: -10, y: -10, z:  10, r: 1, g: 1, b: 1, a: 1, nx: 0, ny: -1, nz: 0),
          Vertex(x:  10, y: -10, z:  10, r: 1, g: 1, b: 1, a: 1, nx: 0, ny: -1, nz: 0),
          Vertex(x:  10, y: -10, z: -10, r: 1, g: 1, b: 1, a: 1, nx: 0, ny: -1, nz: 0)
        ]),
        Triangle(vertices: [
          Vertex(x:  10, y: -10, z: -10, r: 0, g: 1, b: 0, a: 1, nx: 1, ny: 0, nz: 0),
          Vertex(x:  10, y: -10, z:  10, r: 0, g: 1, b: 0, a: 1, nx: 1, ny: 0, nz: 0),
          Vertex(x:  10, y:  10, z: -10, r: 0, g: 1, b: 0, a: 1, nx: 1, ny: 0, nz: 0)
        ]),
        Triangle(vertices: [
          Vertex(x:  10, y: -10, z:  10, r: 0, g: 1, b: 0, a: 1, nx: 1, ny: 0, nz: 0),
          Vertex(x:  10, y:  10, z: -10, r: 0, g: 1, b: 0, a: 1, nx: 1, ny: 0, nz: 0),
          Vertex(x:  10, y:  10, z:  10, r: 0, g: 1, b: 0, a: 1, nx: 1, ny: 0, nz: 0)
        ]),
        Triangle(vertices: [
          Vertex(x: -10, y: -10, z: -10, r: 1, g: 1, b: 0, a: 1, nx: -0.577, ny: -0.577, nz: -0.577),
          Vertex(x: -10, y:  10, z: -10, r: 1, g: 1, b: 0, a: 1, nx: -0.577, ny:  0.577, nz: -0.577),
          Vertex(x: -10, y: -10, z:  10, r: 1, g: 1, b: 0, a: 1, nx: -0.577, ny: -0.577, nz:  0.577)
        ]),
        Triangle(vertices: [
          Vertex(x: -10, y: -10, z:  10, r: 1, g: 1, b: 0, a: 1, nx: -0.577, ny: -0.577, nz:  0.577),
          Vertex(x: -10, y:  10, z:  10, r: 1, g: 1, b: 0, a: 1, nx: -0.577, ny:  0.577, nz:  0.577),
          Vertex(x: -10, y:  10, z: -10, r: 1, g: 1, b: 0, a: 1, nx: -0.577, ny:  0.577, nz: -0.577)
        ])
      ])
    
    return model
  }()
}

struct Span {
  var edges: [Edge] = []
  
  var left: Edge {
    return edges[0].x < edges[1].x ? edges[0] : edges[1]
  }
  
  var right: Edge {
    return edges[0].x < edges[1].x ? edges[1] : edges[0]
  }
}

struct Edge {
  let x: Int    // edge's x position
  
  let r: Float  // interpolated color
  let g: Float
  let b: Float
  let a: Float
  
  let z: Float  // for depth buffer
  
  let nx: Float // interpolated normal vector
  let ny: Float
  let nz: Float
}
