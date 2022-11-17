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
  var cameraY: Float = 20
  var cemeraZ: Float = -20
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
  
  var specularR: Float = 0.3
  var specularG: Float = 0.3
  var specularB: Float = 0.3
}

protocol Primitive {
  var vertices: [Vertex] { get set }
}

protocol Model {
  var triangles: [Triangle] { get set }
  var transoform: ModelTransformation { get set }
}

struct Triangle: Primitive {
  var vertices: [Vertex]
}

struct Cube: Model {
  var transoform =  ModelTransformation()
  var triangles: [Triangle]
  
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
