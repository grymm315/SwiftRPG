//
//  FireMTKView.swift
//  TurnBasedRPG
//
//  Created by System on 1/18/25.
//  Copyright © 2025 Chris Phillips. All rights reserved.
//


import MetalKit

class FireMTKView: MTKView, MTKViewDelegate {
    private var deviceMetal: MTLDevice!
    private var commandQueue: MTLCommandQueue!
    private var pipelineState: MTLRenderPipelineState!
    private var vertexBuffer: MTLBuffer!
    private var time: Float = 0.0
    let pipelineDescriptor = MTLRenderPipelineDescriptor()


    required init(coder: NSCoder) {
        super.init(coder: coder)

        // Set up Metal device
        guard let device = MTLCreateSystemDefaultDevice() else {
            fatalError("Metal is not supported on this device")
        }
        self.deviceMetal = device
        self.device = device

        // Initialize Metal
        setupMetal()

        // Set the view delegate
        self.delegate = self
    }

    private func setupMetal() {
        // Create a command queue
        commandQueue = deviceMetal.makeCommandQueue()

        // Load the shader functions
        guard let library = deviceMetal.makeDefaultLibrary(),
              let vertexFunction = library.makeFunction(name: "vertex_main"),
              let fragmentFunction = library.makeFunction(name: "fragment_main") else {
            fatalError("Unable to load Metal shaders")
        }

        // Set up the vertex descriptor
        let vertexDescriptor = MTLVertexDescriptor()

        // Describe the layout of the vertex buffer
        vertexDescriptor.attributes[0].format = .float2 // position
        vertexDescriptor.attributes[0].offset = 0
        vertexDescriptor.attributes[0].bufferIndex = 0

        vertexDescriptor.attributes[1].format = .float2 // texCoord
        vertexDescriptor.attributes[1].offset = MemoryLayout<Float>.size * 2
        vertexDescriptor.attributes[1].bufferIndex = 0

        vertexDescriptor.layouts[0].stride = MemoryLayout<Float>.size * 4 // 2 for position + 2 for texCoord
        vertexDescriptor.layouts[0].stepFunction = .perVertex

        // Set up the pipeline descriptor
        pipelineDescriptor.vertexFunction = vertexFunction
        pipelineDescriptor.fragmentFunction = fragmentFunction
        pipelineDescriptor.colorAttachments[0].pixelFormat = self.colorPixelFormat
        pipelineDescriptor.vertexDescriptor = vertexDescriptor // Attach the vertex descriptor here

        // Create the pipeline state
        do {
            pipelineState = try deviceMetal.makeRenderPipelineState(descriptor: pipelineDescriptor)
        } catch {
            fatalError("Unable to create pipeline state: \(error)")
        }

        // Define vertex data
        let vertices: [Float] = [
            -1.0, -1.0, 0.0, 1.0, // Bottom-left (position + texCoord)
             1.0, -1.0, 1.0, 1.0, // Bottom-right (position + texCoord)
            -1.0,  1.0, 0.0, 0.0, // Top-left (position + texCoord)
             1.0,  1.0, 1.0, 0.0  // Top-right (position + texCoord)
        ]

        // Create a vertex buffer
        vertexBuffer = deviceMetal.makeBuffer(
            bytes: vertices,
            length: vertices.count * MemoryLayout<Float>.size,
            options: []
        )
    }


    // MARK: MTKViewDelegate Methods

    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        // Handle view resizing if necessary
    }

    func draw(in view: MTKView) {
        guard let drawable = self.currentDrawable,
              let renderPassDescriptor = self.currentRenderPassDescriptor else {
            return
        }

        time += 0.016 // Assuming ~60 FPS

        let commandBuffer = commandQueue.makeCommandBuffer()!
        let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor)!
    
        renderEncoder.setRenderPipelineState(pipelineState)
        renderEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderEncoder.setFragmentBytes(&time, length: MemoryLayout<Float>.size, index: 0)
        renderEncoder.drawPrimitives(type: .triangleStrip, vertexStart: 0, vertexCount: 4)

        renderEncoder.endEncoding()
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }

}
