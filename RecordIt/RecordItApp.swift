//
//  RecordItApp.swift
//  RecordIt
//
//  Created by 이진 on 4/12/24.
//

import SwiftUI

@main
struct RecordItApp: App {
    var body: some Scene {
        
        @State var fileName = ""
        
        WindowGroup {
            ContentView(audioRecorder: AudioRecorder())
//            CameraView()
        }
    }
}
