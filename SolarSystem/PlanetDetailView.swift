//
//  PlanetDetailView.swift
//  SolarSystem
//
//  Created by Rishabh Sharma(Personal) on 05/02/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct PlanetDetailView: View {
    
    @Environment(AppViewModel.self) private var appViewModel
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    
    @State var obj : SolarSystemModel = SolarSystemModel(entityName: "Sun", planetName: "FSDDFDS", planetSubHeading: "DSFSDFSD", planetDesc: "FSDFDFFDS")
    @State var deg = 0
    
    let timer = Timer.publish(every: 0.04, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        HStack(spacing: 60) {
            VStack(alignment: .leading,spacing: 20) {
                Text(obj.planetSubHeading)
                    .font(.system(size: 55))
                    .fontWeight(.bold)
                Text(obj.planetDesc)
                    .font(.system(size: 30))
                    .fontWeight(.regular)
                HStack {
                    Button {
                        openWindow(id: "planet")
                        appViewModel.presentCurrentPlanet = obj.entityName
                    } label: {
                        Text("Add planet in your room")
                            .multilineTextAlignment(.center)
                    }
                    .glassBackgroundEffect()
                }
            }
            .padding()
            RealityView { content in
                guard let entity = try? await Entity(named: obj.entityName, in: realityKitContentBundle) else {
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
        .padding(.horizontal,50)
        .navigationTitle(obj.entityName)
    }
}

#Preview {
    PlanetDetailView()
        .environment(AppViewModel())
}
