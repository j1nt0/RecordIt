//
//  RecordingList.swift
//  RecordIt
//
//  Created by 이진 on 4/15/24.
//

import SwiftUI

struct MyRecordingsList: View {
    
    @ObservedObject var audioRecorder: AudioRecorder
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var version = false
    var tempDate = Date()
    
    var backButton : some View {
        Button{
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            HStack {
                Image(systemName: "chevron.left")
                    .aspectRatio(contentMode: .fit)
                Text("보관함")
                    .font(.system(size: 23, weight: .semibold))
            }
            .foregroundStyle(.black)
        }
    }
    
    var body: some View {
        
        List {
            let dateToUrllistDic: [String: [URL]] = {
                var tempData: [String: [URL]] = [:]
                audioRecorder.recordings.forEach{
                    let stringDate = $0.createdAt.toString(dateFormat: "YY-MM-dd")
//                                        tempData[stringDate, default: []].append(recording.fileURL)
                    tempData[stringDate] = tempData[stringDate, default: []] + [$0.fileURL]
                }
                
                return tempData
            }()
            
            ForEach(dateToUrllistDic.keys.map{ $0 }, id: \.self) { date in
                //                Text(date)
                if version {
                    if date == String(tempDate.description.prefix(10).suffix(8)) {
                        Section(date) {
                            ForEach(dateToUrllistDic[date] ?? [], id: \.self) { url in
                                MyRecordingRow(audioURL: url)
                            }
                            .onDelete(perform: delete)
                        }
                    } //진토 어디갔어! 돌아와! 싸와디깝~~!
                } else {
                    Section(date) {
                        ForEach(dateToUrllistDic[date] ?? [], id: \.self) { url in
                            MyRecordingRow(audioURL: url)
                        }
                        .onDelete(perform: delete)
                    }
                }
            }
        }
//        .listStyle(.grouped)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
    }
    
    func delete(at offsets: IndexSet) {
        var urlsToDelete = [URL]()
        for index in offsets {
            urlsToDelete.append(audioRecorder.recordings[index].fileURL)
        }
        audioRecorder.deleteRecording(urlsToDelete: urlsToDelete)
        print(audioRecorder.recordings)
    }
}

struct MyRecordingRow: View {
    
    var audioURL: URL
    
    @ObservedObject var audioPlayer = AudioPlayer()
    
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                let audioName = audioURL.lastPathComponent
                
                let audioNameTempOne = audioName.suffix(24)
                let audioNameTempTwo = audioNameTempOne.prefix(8)
                
                let audioNameTempThree = audioName.split(separator: "|")[0]
                
                Text("\(audioNameTempThree)")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.black)
//                Text("\(audioNameTempTwo)")
//                    .font(.system(size: 15, weight: .medium))
//                    .foregroundStyle(.gray)
            }
            Spacer()
            if audioPlayer.isPlaying == false {
                Button {
                    self.audioPlayer.startPlayback(audio: self.audioURL)
                } label: {
                    Image(systemName: "play.circle")
                }
            } else {
                Button {
                    self.audioPlayer.stopPlayback()
                } label: {
                    Image(systemName: "stop.fill")
                }
            }
        }
        .frame(height: 50)
    }
}


#Preview {
    MyRecordingsList(audioRecorder: AudioRecorder())
}
