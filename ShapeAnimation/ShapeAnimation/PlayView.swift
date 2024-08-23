//
//  PlayView.swift
//  ShapeAnimation
//
//  Created by iOS on 2024/8/22.
//

import SwiftUI

struct PlayView: View {
    
    @ObservedObject var vm: ViewModel
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.blue)
                .matchedGeometryEffect(id: "animation", in: vm.namespace)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay(
                    Text("Full Screen")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                )
            
            Button{
                withAnimation(.easeInOut(duration: 0.5)) {
                    vm.isFullScreen.toggle()
                }
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(40)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    PlayViewPreviewContainer()
}

struct PlayViewPreviewContainer: View {
    
    @Namespace var animationNamespace
    
    var body: some View {
        PlayView(vm: ViewModel(namespace: animationNamespace))
    }
}
