//
//  ContentView.swift
//  ChallengeFour
//
//  Created by Ivan Pryhara on 09/03/2024.
//

import SwiftUI

struct ChallengeButtonStyle: ButtonStyle {
    
    @State private var opacity: Double = 0
    @State private var scale: Double = 1
    private let duration: Double = 0.22
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .padding()
            .background {
                Circle()
                    .foregroundStyle(.secondary.opacity(0.1))
                    .opacity(opacity)
            }
            .scaleEffect(scale)
            .onChange(of: configuration.isPressed) { oldValue, newValue in
                if newValue {
                    withAnimation(.easeInOut(duration: duration)) {
                        opacity = 1
                        scale = 0.86
                    } completion: {
                        withAnimation(.easeInOut(duration: duration)) {
                            opacity = 0
                            scale = 1
                        }
                    }
                }
            }
    }
}

struct ContentView: View {
    
    @State private var performAnimation: Bool = false
    
    var body: some View {
        Button {
            if !performAnimation {
                withAnimation(.interpolatingSpring(stiffness: 170, damping: 15)) {
                    performAnimation = true
                } completion: {
                    performAnimation = false
                }
            }
        } label: {
            GeometryReader { proxy in
                let width = proxy.size.width / 2
                let systemName = "play.fill"
                
                HStack(alignment: .center, spacing: 0) {
                    Image(systemName: systemName)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: performAnimation ? width : .zero)
                        .opacity(performAnimation ? 1 : .zero)
                    Image(systemName: systemName)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: width)
                    Image(systemName: systemName)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: width)
                        .frame(width: performAnimation ? 0.5 : width)
                        .opacity(performAnimation ? .zero : 1)
                }
                .frame(maxHeight: .infinity, alignment: .center)
            }
        }
        .frame(maxWidth: 70)
        .buttonStyle(ChallengeButtonStyle())
    }
}

#Preview {
    ContentView()
}

