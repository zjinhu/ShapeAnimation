//
//  ContentView.swift
//  ShapeAnimation
//
//  Created by iOS on 2024/8/22.
//

import SwiftUI
import BrickKit
struct ContentView: View {
    
    @Namespace var animationNamespace
    
    var body: some View {
        ViewModelContent(namespace: animationNamespace) { vm in
            ZStack {
                if vm.isFullScreen{
                    PlayView(vm: vm)
                }else{
                    DragableView(vm: vm)
                        .disabled(!vm.isCircle)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                vm.isFullScreen.toggle()
                            }
                        }
                }
                
                VStack{
                    Button("scroll") {
                        vm.isCircle.toggle()
                        if vm.isCircle{
                            vm.state = .leftCircle
                        }else{
                            vm.state = .rectangle
                        }
                    }
                    .hidden(vm.isCircle)
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    ContentView()
}

