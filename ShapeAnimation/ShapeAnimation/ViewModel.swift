//
//  ViewModel.swift
//  ShapeAnimation
//
//  Created by iOS on 2024/8/22.
//

import SwiftUI

enum PlayBarState{
    case rectangle
    case leftCircle
    case rightCircle
    case circle
}

class ViewModel: ObservableObject {

    @Published var isCircle: Bool = false
    @Published var state: PlayBarState = .rectangle
    @Published var isFullScreen: Bool = false
    @Published var dragAmount: CGPoint?
    
    let namespace: Namespace.ID
    
    init(namespace: Namespace.ID) {
        self.namespace = namespace
    }
}

struct ViewModelContent<Content: View>: View {
    let content: (ViewModel) -> Content
    @ObservedObject var vm: ViewModel
    
    init(namespace: Namespace.ID, content: @escaping (ViewModel) -> Content) {
        self.content = content
        self.vm = ViewModel(namespace: namespace)
    }
    
    var body: some View {
        content(vm)
    }
}
