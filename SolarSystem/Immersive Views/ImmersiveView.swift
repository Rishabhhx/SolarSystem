//
//  ImmersiveView.swift
//  SolarSystem
//
//  Created by Rishabh Sharma(Personal) on 04/02/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    var body: some View {
        ZStack {
            Starfield()
            RealityView { content in
                // Add the initial RealityKit content
                if let scene = try? await Entity(named: "Immersive", in: realityKitContentBundle) {
                    content.add(scene)
                }
            }
        }
    }
}

#Preview {
    ImmersiveView()
        .previewLayout(.sizeThatFits)
}

struct Starfield: View {
    var body: some View {
        RealityView { content in
            // Create a material with a star field on it.
            guard let resource = try? await TextureResource(named: "Starfield") else {
                // If the asset isn't available, something is wrong with the app.
                fatalError("Unable to load starfield texture.")
            }
            var material = UnlitMaterial()
            material.color = .init(texture: .init(resource))

            // Attach the material to a large sphere.
            let entity = Entity()
            entity.components.set(ModelComponent(
                mesh: .generateSphere(radius: 1000),
                materials: [material]
            ))

            // Ensure the texture image points inward at the viewer.
            entity.scale *= .init(x: -1, y: 1, z: 1)

            content.add(entity)
        }
    }
}
