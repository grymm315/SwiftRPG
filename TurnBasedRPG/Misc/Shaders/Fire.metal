#include <metal_stdlib>
using namespace metal;

// Vertex input structure
struct VertexIn {
    float2 position [[attribute(0)]]; // Vertex position (float2)
    float2 texCoord [[attribute(1)]]; // Texture coordinates (float2)
};

vertex float4 vertex_main(VertexIn in [[stage_in]]) {
return float4(in.position, 0.0, 1.0);
}

fragment float4 fragment_main(float time [[uniform]]) {
// Example fragment shader (fire effect here)
return float4(abs(sin(time)), 0.3, 0.1, 1.0);
}

// Vertex output structure
struct VertexOut {
    float4 position [[position]];    // Clip-space position
    float2 texCoord;                 // Texture coordinates
};

// Vertex shader
//vertex VertexOut vertex_main(VertexIn in [[stage_in]]) {
//    VertexOut out;
//    
//    // Convert float2 position to float4 for clip space
//    out.position = float4(in.position.xy, 0.0, 1.0);
//    out.texCoord = in.texCoord;
//    
//    return out;
//}

// Function to generate 2D noise
float noise(float2 coord) {
    return fract(sin(dot(coord, float2(12.9898, 78.233))) * 43758.5453);
}

// Fragment shader: Fire effect
//fragment float4 fragment_main(VertexOut in [[stage_in]],
//                              constant float &time [[buffer(0)]]) {
//    float2 uv = in.texCoord;
//
//    // Scale UV coordinates for the effect
//    uv.y += time * 0.2; // Animate upward motion for fire
//    float intensity = 0.0;
//
//    // Create layers of noise for a fire-like effect
//    for (int i = 1; i < 5; i++) {
//        float scale = float(i) * 0.5;
//        intensity += noise(uv * scale) / scale;
//    }
//
//    // Fire gradient: From black to yellow to red
//    float3 color = mix(float3(0.0, 0.0, 0.0), float3(1.0, 0.5, 0.0), intensity);
//    color = mix(color, float3(1.0, 0.1, 0.0), intensity * intensity);
//
//    // Fade out fire at the top
//    color *= smoothstep(1.0, 0.5, uv.y);
//
//    return float4(color, 1.0); // Output final color with alpha
//}
