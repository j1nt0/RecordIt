//
//  InstrumentRegistrationView.swift
//  RecordIt
//
//  Created by 이진 on 4/13/24.
//

import SwiftUI

struct InstrumentRegistrationView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var model = FrameHandler()
    
        var backButton : some View {
            Button{
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                HStack {
                    Image(systemName: "chevron.left")
                        .aspectRatio(contentMode: .fit)
                    Text("악기 등록")
                        .font(.system(size: 23, weight: .semibold))
                }
                .foregroundStyle(.black)
            }
        }
    
    var body: some View {
//        VStack {
//            Text("악기 등록 페이지")
//        }
        ZStack {
            ZStack {
                FrameView(image: model.frame)
                    .ignoresSafeArea()
                    .padding()
                    .navigationBarBackButtonHidden(true)
                    .navigationBarItems(leading: backButton)
                    .frame(width: 250, height: 250)
                    .cornerRadius(15)
                    .offset(y: -50)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color("RecordGray"), lineWidth: 2)
                            .frame(width: 265, height: 265)
                            .offset(y: -50)
                    }
                VStack {
                    Spacer()
                    Divider()
                    Spacer()
                    Divider()
                    Spacer()
                }
                .frame(width: 250, height: 250)
                .offset(y: -50)
                HStack {
                    Spacer()
                    Divider()
                    Spacer()
                    Divider()
                    Spacer()
                }
                .frame(width: 250, height: 250)
                .offset(y: -50)
            }
            VStack {
                Spacer()
                Button {
                    
                } label: {
                    ZStack {
                        Circle()
                            .foregroundStyle(Color("RecordGray"))
                            .frame(width: 80)
                        Circle()
                            .stroke(Color("RecordGray"), lineWidth: 2)
                            .frame(width: 95)
                    }
                }
            }
        }
    }
}

#Preview {
    InstrumentRegistrationView()
}
