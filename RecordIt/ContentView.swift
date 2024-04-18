//
//  ContentView.swift
//  RecordIt
//
//  Created by 이진 on 4/12/24.
//  08:55 https://www.youtube.com/watch?v=UZI2dvLoPr8&t=376s

import SwiftUI

enum Tab {
    case home, storage, profile
}

struct ContentView: View {
    
    @State var currentDate = Date()
    @ObservedObject var audioRecorder: AudioRecorder
    @State var isAnimating = false
    @State var isShowingAlert = false
    @State var recordingName = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                TitleView()
                    .padding(.horizontal)
                Spacer()
                    .frame(height: 50)
                GuideSentence(audioRecorder: audioRecorder)
                    .padding(.horizontal)
                Spacer()
                    .frame(height: 40)
//                CalenderrView()
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0)
                        .foregroundStyle(.white)
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.1), radius: 10)
                    CalendarView(currentDate: $currentDate, audioRecorder: audioRecorder)
                        .padding()
                }
                .padding()
                .frame(height: 380)
                Spacer()
                if audioRecorder.recording == false {
                    ZStack {
                        Button {
                            isShowingAlert.toggle()
                        } label: {
                            RecordCircle()
                        }
                        .alert("오늘의 연주곡", isPresented: $isShowingAlert, actions: {
                                    TextField("", text: $recordingName)

                            Button("Register", action: {
                                self.audioRecorder.startRecording(name: recordingName)
                                recordingName = ""
                                withAnimation(.easeInOut(duration: 1).repeatForever()) {
                                    isAnimating.toggle()
                                }})
                                    Button("Cancel", role: .cancel, action: {})
                                }, message: {
                                    Text("녹음할 연주곡을 입력해주세요.")
                                })
                    }
                    .frame(height: 130)
                }
//                if audioRecorder.recording == false {
//                    ZStack {
//                        Button {
//                            self.audioRecorder.startRecording(name: "dd")
//                            withAnimation(.easeInOut(duration: 1).repeatForever()) {
//                                isAnimating.toggle()
//                            }
//                        } label: {
//                            RecordCircle()
//                        }                    
//                    }
//                    .frame(height: 130)
//                } 
                else {
                    ZStack {
                        Circle()
                            .frame(width: 130)
                            .foregroundStyle(Color("RecordGray"))
                            .opacity(isAnimating ? 0.3 : 0)
                        Circle()
                            .frame(width: 105)
                            .foregroundStyle(Color("RecordGray"))
                            .opacity(isAnimating ? 0.5 : 0)
                        Button {
                            self.audioRecorder.stopRecording()
                        } label: {
                            RecordRectangle()
                        }
                    }
                    .frame(height: 130)
                }
//                .popover(isPresented: $isShowing, content: {
//                    // 여기 아래부터 RecordView(audioRecorder: AudioRecorder())로 대체
//                    VStack {
//                        RoundedRectangle(cornerRadius: 100)
//                            .frame(width: 80, height: 5)
//                            .foregroundStyle(.gray)
//                        Spacer()
//                            .frame(height: 30)
//                        Text("오늘의 연주")
//                            .font(.system(size: 20, weight: .medium))
//                        Spacer()
//                        RoundedRectangle(cornerRadius: 20)
//                            .frame(height: 150)
//                            .foregroundStyle(Color("RecordGray"))
//                            .padding(.horizontal)
//                        Spacer()
//                        Button {
//                            self.audioRecorder.stopRecording()
//                        } label: {
//                            if audioRecorder.recording {
//                                RecordRectangle()
//                            } else {
//                                RecordCircle()
//                            }
//                        }
//                    }
//                    // 여기 위까지
//                    .padding()
//                    .presentationDetents([.medium])
//                })
                Spacer()
                    .frame(height: 50)
            }
            .ignoresSafeArea(.all, edges: .bottom)
            .padding(.horizontal)
        }
    }
}

#Preview {
    ContentView(audioRecorder: AudioRecorder())
}




struct TitleView: View {
    var body: some View {
        HStack {
            Image("RecordItLogo")
                .resizable()
                .scaledToFit()
                .frame(height: 31)
            Spacer()
            NavigationLink {
                ProfileView()
            } label: {
                ZStack {
                    Image("Profile")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40)
                }
            }
        }
    }
}
//RecordingsList(audioRecorder: audioRecorder)
struct GuideSentence: View {
    
    @ObservedObject var audioRecorder: AudioRecorder
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("진토님")
                    .font(.system(size: 25, weight: .bold))
                HStack {
                    Text("오늘도 선율을 연주해요 ~ ")
                    NavigationLink {
                        MyRecordingsList(audioRecorder: audioRecorder)
                    } label: {
                        Text("🎶")
                    }

                }
                    .font(.system(size: 20, weight: .medium))
            }
            Spacer()
        }
    }
}

struct CalenderrView: View {
    var body: some View {
        Image("Calender")
            .resizable()
            .frame(height: 350)
            .cornerRadius(20)
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.1), radius: 10)
    }
}

struct RecordCircle: View {
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 80)
                .foregroundStyle(Color("RecordGray"))
//                .shadow(radius: 5, y: 5) // ⭐️
            Circle()
                .frame(width: 40)
                .foregroundStyle(Color("RecordRed"))
        }
    }
}

struct RecordRectangle: View {
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 80)
                .foregroundStyle(Color("RecordGray"))
//                .shadow(radius: 5, y: 5) // ⭐️
            Rectangle()
                .frame(width: 30, height: 30)
                .foregroundStyle(Color("RecordRed"))
        }
    }
}

//struct RecordView: View {
//    
//    @ObservedObject var audioRecorder: AudioRecorder
//    
//    var body: some View {
//        VStack {
//            RoundedRectangle(cornerRadius: 100)
//                .frame(width: 80, height: 5)
//                .foregroundStyle(.gray)
//            Spacer()
//                .frame(height: 30)
//            Text("오늘의 연주")
//                .font(.system(size: 20, weight: .medium))
//            Spacer()
//            RoundedRectangle(cornerRadius: 20)
//                .frame(height: 150)
//                .foregroundStyle(Color("RecordGray"))
//                .padding(.horizontal)
//            Spacer()
//            ZStack {
//                Button {
//                    self.audioRecorder.stopRecording()
//                } label: {
//                    RecordCircle()
//                }
//                HStack {
//                    Spacer()
//                    Button {
//                        
//                    } label: {
//                        Circle()
//                            .frame(width: 50)
//                            .foregroundStyle(Color("RecordGray"))
////                            .shadow(radius: 5, y: 5) // ⭐️
//                    }
//                }
//                .padding(.horizontal)
//            }
//        }
//    }
//}
