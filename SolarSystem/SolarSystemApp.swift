//
//  SolarSystemApp.swift
//  SolarSystem
//
//  Created by Rishabh Sharma(Personal) on 04/02/24.
//

import SwiftUI

@main
struct SolarSystemApp: App {
    @State private var currentStyle: ImmersionStyle = .full
    @State private var appViewModel = AppViewModel()
    
    var body: some Scene {
        
        WindowGroup {
            MainView()
                .environment(appViewModel)
        }
        .windowStyle(.plain)
        
        WindowGroup(id: "planet") {
            Planet()
                .environment(appViewModel)
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 0.8, height: 0.3, depth: 0.3, in: .meters)
        
        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
        .immersionStyle(selection: $currentStyle, in: .full)
    }
}
