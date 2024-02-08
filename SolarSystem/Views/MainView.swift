//
//  MainView.swift
//  SolarSystem
//
//  Created by Rishabh Sharma(Personal) on 07/02/24.
//

import SwiftUI

struct MainView: View {
    @Environment(AppViewModel.self) private var appViewModel

    var body: some View {
        TabView {
            SolarSystemView()
                .tabItem { Label("Solar System", systemImage: "sunrise.circle") }
                .environment(appViewModel)
            HomeView()
                .tabItem { Label("Planet List", systemImage: "square.stack") }
                .environment(appViewModel)
        }
    }
}

#Preview {
    MainView()
        .environment(AppViewModel())
}
