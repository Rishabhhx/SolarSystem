//
//  Planet.swift
//  SolarSystem
//
//  Created by Rishabh Sharma(Personal) on 07/02/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct Planet: View {
    @Environment(AppViewModel.self) private var appViewModel
    
    @State var deg = 0

    let timer = Timer.publish(every: 0.04, on: .main, in: .common).autoconnect()
    
    var body: some View {
        RealityView { content in
            guard let entity = try? await Entity(named: appViewModel.presentCurrentPlanet, in: realityKitContentBundle) else {
                return
            }
            entity.scale = .init(repeating: 1.5)
            content.add(entity)
        }
        .onReceive(timer) { _ in
            self.deg += 1
        }
        .rotation3DEffect(.degrees(Double(deg)), axis: (x: 0, y: 1, z: 0))
        .frame(width: 450,height: 450)
        .frame(depth: 400)
    }
}

#Preview {
    Planet()
}
