//
//  CameraView.swift
//  RecordIt
//
//  Created by 이진 on 4/17/24.
//

import SwiftUI

struct CameraView: View {
    @StateObject private var model = FrameHandler()
    
    
    var body: some View {
        FrameView(image: model.frame)
            .ignoresSafeArea()
    }
}

#Preview {
    CameraView()
}
