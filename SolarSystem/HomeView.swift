//
//  HomeView.swift
//  SolarSystem
//
//  Created by Rishabh Sharma(Personal) on 04/02/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct HomeView: View {
    let columns : [GridItem] = [GridItem(.adaptive(minimum: 250),spacing: 30)]
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVGrid(columns: columns,spacing: 30) {
                        ForEach(solarSystemObj, id: \.self) { item in
                            EntityView(obj: item)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Welcome to Our Solar System")
        }
    }
}

#Preview(windowStyle: .automatic) {
    HomeView()
}

struct EntityView: View {
    
    var obj: SolarSystemModel = SolarSystemModel(entityName: "", planetName: "", planetSubHeading: "", planetDesc: "")
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State var deg = 0
    @State var moveToDetail = false
    var body: some View {
        VStack(alignment: .center,spacing: 20) {
            RealityView { content in
                guard let entity = try? await Entity(named: obj.entityName, in: realityKitContentBundle) else {
                    return
                }
                entity.scale = .init(repeating: 0.4)
                content.add(entity)
            }
            .onReceive(timer) { _ in
                self.deg += 1
            }
            .rotation3DEffect(.degrees(Double(deg)), axis: (x: 0, y: 1, z: 0))
            .frame(width: 100,height: 100)
            .frame(depth: 100)
            Text(obj.planetName)
                .font(.title)
            Text(obj.planetSubHeading)
                .font(.headline)
                .multilineTextAlignment(.center)
        }
        .frame(width: 250,height: 250)
        .glassBackgroundEffect()
        .navigationDestination(isPresented: $moveToDetail) {
            PlanetDetailView(obj: obj)
        }
        .onTapGesture {
            moveToDetail.toggle()
        }
    }
}

