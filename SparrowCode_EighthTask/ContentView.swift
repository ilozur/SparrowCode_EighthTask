//
//  ContentView.swift
//  SparrowCode_EighthTask
//
//  Created by Edmond Podlegaev on 21.12.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity)
                .blur(radius: 45, opaque: true)
                .clipped()
            
            VolumeSlider()
        }
        .ignoresSafeArea()
    }
}

struct VolumeSlider: View {
    @State private var volumeConfig: Config = .init()
    var body: some View {
        RoundedRectangle(cornerRadius: 35)
            .frame(width: 120, height: volumeConfig.viewHeight)
            .foregroundStyle(.thinMaterial)
            .environment(\.colorScheme, .dark)
            .gesture(DragGesture().onChanged({ value in
                let height = volumeConfig.currentSize - value.translation.height
                volumeConfig.viewSize = min(volumeConfig.viewHeight, max(0, height))
                
                if height > volumeConfig.viewHeight {
                    withAnimation {
                        volumeConfig.scaleEffect = min(0.1, 1 - volumeConfig.viewHeight / height)
                    }
                } else if height < 0 {
                    withAnimation {
                        volumeConfig.scaleEffect = -min(0.1, 1 - volumeConfig.viewHeight / (volumeConfig.viewHeight + abs(height)))
                    }
                } else {
                    withAnimation {
                        volumeConfig.scaleEffect = 0
                    }
                }
            }).onEnded({ _ in
                volumeConfig.scaleEffect = 0
                volumeConfig.currentSize = volumeConfig.viewSize
            }))
            .overlay(alignment: .bottom) {
                Rectangle()
                  .foregroundStyle(.white)
                  .frame(height: volumeConfig.viewSize)
                  .allowsHitTesting(false)
            }
            .mask(RoundedRectangle(cornerRadius: 35))
            .scaleEffect(CGSize(width: 1.0 - abs(volumeConfig.scaleEffect) / 2, height: 1.0 + abs(volumeConfig.scaleEffect)), anchor: volumeConfig.scaleEffect >= 0 ? .bottom : .top)
    }
}

struct Config {
    var currentSize: CGFloat = 0
    var viewSize: CGFloat = 0
    var viewHeight: CGFloat = 275
    var scaleEffect: CGFloat = 0
}

#Preview {
    ContentView()
}
