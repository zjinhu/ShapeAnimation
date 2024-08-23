//
//  PlayBarView.swift
//  ShapeAnimation
//
//  Created by iOS on 2024/8/22.
//

import SwiftUI
import BrickKit

struct PlayBarView: View {
    @ObservedObject var vm: ViewModel
    
    var body: some View {
        
        ZStack{
            Color.blue
            
            if vm.state == .rectangle{
                Text("Player")
                    .foregroundStyle(.white)
            }else{
                Circle()
                    .fill(.red)
                    .frame(width: 30, height: 30)
            }
        }
        .ss.cornerRadius(vm.state == .rectangle ? 0 : 25, corners: getCorners(state: vm.state))
        
    }
    
    func getCorners(state: PlayBarState) -> UIRectCorner{
        
        switch state {
        case .rectangle:
                .allCorners
        case .leftCircle:
            [.topLeft, .bottomLeft]
        case .rightCircle:
            [.topRight, .bottomRight]
        case .circle:
                .allCorners
        }
    }
}


#Preview {
    
    PlayBarViewPreviewContainer()
        .height(50)
    
}


struct PlayBarViewPreviewContainer: View {
    
    @Namespace var animationNamespace
    
    var body: some View {
        PlayBarView(vm: ViewModel(namespace: animationNamespace))
    }
}
