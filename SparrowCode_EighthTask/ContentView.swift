//
//  ContentView.swift
//  SparrowCode_EighthTask
//
//  Created by Edmond Podlegaev on 21.12.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader {
            let size = $0.size
            ZStack {
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width)
                    .blur(radius: 45, opaque: true)
                    .clipped()
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    ContentView()
}
