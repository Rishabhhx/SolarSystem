//
//  ImmersiveControlsView.swift
//  SolarSystem
//
//  Created by Rishabh Sharma(Personal) on 07/02/24.
//

import SwiftUI

struct ImmersiveControlsView: View {
    @Environment(AppViewModel.self) private var appViewModel
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace

    var body: some View {
        VStack {
            Spacer()
            VStack {
                Text("Lets go back to the Reality")
                Button {
                    appViewModel.inImmersiveView = false
                    Task {
                        await dismissImmersiveSpace()
                    }
                } label: {
                    Text("Exit Immersive View")
                }
                .glassBackgroundEffect()
            }
            .frame(width: 250,height: 150)
            .glassBackgroundEffect()
            .padding()
        }
    }
}

#Preview {
    ImmersiveControlsView()
        .environment(AppViewModel())
}
