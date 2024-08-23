//
//  DragableView.swift
//  ShapeAnimation
//
//  Created by iOS on 2024/8/22.
//

import SwiftUI
import BrickKit
struct DragableView: View {
    
    @ObservedObject var vm: ViewModel
    
    var body: some View {
        GeometryReader { geometry in
            
            ZStack{
                PlayBarView(vm: vm)
                    .matchedGeometryEffect(id: "animation", in: vm.namespace)
                    .frame(width: vm.isCircle ? 50 : Screen.width, height: 50)
                    .animation(.smooth(duration: 0.5), value: vm.isCircle)
                    .position(vm.dragAmount ?? (vm.isCircle ? CGPoint(x: geometry.size.width-25, y: geometry.size.height-100) : CGPoint(x: geometry.size.width/2, y: geometry.size.height-100)))
                    .gesture(
                        DragGesture()
                            .onChanged {
                                vm.dragAmount = $0.location
                                vm.state = .circle
                            }
                            .onEnded { value in
                                var currentPostion = value.location
                                
                                if currentPostion.x > (geometry.size.width/2) {
                                    currentPostion.x = geometry.size.width-25
                                } else {
                                    currentPostion.x = 25
                                }
                                
                                withAnimation(.easeOut(duration: 0.3), after: 0.3) {
                                    
                                    vm.dragAmount = currentPostion
                                    
                                } completion: {
                                    if currentPostion.x > (geometry.size.width/2) {
                                        vm.state = .leftCircle
                                    }else{
                                        vm.state = .rightCircle
                                    }
                                }
                                
                            }
                    )
                
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    DragablePreviewContainer()
}

struct DragablePreviewContainer: View {
    
    @Namespace var animationNamespace
    
    var body: some View {
        ViewModelContent(namespace: animationNamespace) { vm in
            VStack{
                DragableView(vm: vm)
                    .disabled(!vm.isCircle)
                
                Button("change") {
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
    }
}
