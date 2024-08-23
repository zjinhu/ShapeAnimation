//
//  FullScreenView.swift
//  ShapeAnimation
//
//  Created by iOS on 2024/8/22.
//

import SwiftUI
 
#Preview {
    FullScreenAnimationView()
}

struct FullScreenAnimationView: View {
    @Namespace private var animationNamespace
    @State private var isFullScreen = false

    var body: some View {
        ZStack {
            if isFullScreen {
                FullScreenView(isFullScreen: $isFullScreen, animationNamespace: animationNamespace)
                    .edgesIgnoringSafeArea(.all)
            } else {
 
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.blue)
                        .matchedGeometryEffect(id: "animation", in: animationNamespace)
                        .frame(width: 100, height: 50)
                        .position(CGPoint(x: 100.0, y: 10.0))
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                isFullScreen.toggle()
                            }
                        }
 
            }
        }
    }
}

struct FullScreenView: View {
    @Binding var isFullScreen: Bool
    var animationNamespace: Namespace.ID

    var body: some View {
        ZStack(alignment: .topTrailing) {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.blue)
                .matchedGeometryEffect(id: "animation", in: animationNamespace)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay(Text("Full Screen").foregroundColor(.white).font(.largeTitle))

            Button(action: {
                withAnimation(.easeInOut(duration: 0.5)) {
                    isFullScreen.toggle()
                }
            }) {
                Image(systemName: "xmark.circle.fill")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
            }
        }
    }
}
