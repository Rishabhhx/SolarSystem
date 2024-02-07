//
//  SolarSystemView.swift
//  SolarSystem
//
//  Created by Rishabh Sharma(Personal) on 07/02/24.
//

import SwiftUI

struct SolarSystemView: View {
    @Environment(AppViewModel.self) private var appViewModel
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    
    var body: some View {
        ZStack {
            ImmersiveControlsView()
                .environment(appViewModel)
                .opacity(appViewModel.inImmersiveView ? 1 : 0)
            VStack {
                Text("Solar System")
                    .font(.system(size: 60))
                    .fontWeight(.black)
                    .padding(.top, 60)
                HStack {
                    ScrollView(.vertical) {
                        VStack(alignment: .leading) {
                            Text("Every 365¼ days, Earth and its satellites completely orbit the Sun — the star that anchors our solar system. It’s a journey of about 940 million kilometers a year!\n\nOn its journey, the Earth moves counter-clockwise in a slightly elliptical orbit. It travels a path called the ecliptic plane — an important part of how we navigate through our solar system.\n\nWant to explore Earth’s orbit in detail? Take a trip to the solar system and watch how Earth and its satellites move around the Sun.")
                                .font(.title3)
                                .fontWeight(.medium)
                            Button("View Solar System") {
                                appViewModel.inImmersiveView = true
                                Task {
                                    await openImmersiveSpace(id: "ImmersiveSpace")
                                }
                            }
                            .padding()
                        }
                    }
                    .padding()
                    Spacer()
                    Image("SolarHero")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 360,height: 260)
                }
                .padding(.horizontal, 50)
            }
            .background() {
                Image("backGround")
                    .resizable()
                    .scaledToFill()
                    .overlay {
                        Rectangle()
                            .fill(.black.opacity(0.4))
                    }
            }
            .glassBackgroundEffect()
            .opacity(appViewModel.inImmersiveView ? 0 : 1)
        }
    }
}

#Preview {
    SolarSystemView()
        .environment(AppViewModel())
}
