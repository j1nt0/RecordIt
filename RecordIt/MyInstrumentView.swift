//
//  MyInstrumentView.swift
//  RecordIt
//
//  Created by 이진 on 4/12/24.
//

import SwiftUI

struct MyInstrumentView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var instruments: [InstrumentModel] = []
    
        var backButton : some View {
            Button{
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                HStack {
                    Image(systemName: "chevron.left")
                        .aspectRatio(contentMode: .fit)
                    Text("나의 악기")
                        .font(.system(size: 23, weight: .semibold))
                }
                .foregroundStyle(.black)
            }
        }
    
    var body: some View {
        
        VStack {
            Spacer()
            if instruments.count == 0 {
                Text("악기가 없습니다.")
                    .font(.system(size: 20))
                    .foregroundStyle(.secondary)
            } else {
                
            }
            Spacer()
            HStack {
                NavigationLink {
                    InstrumentRegistrationView()
                } label: {
                    Text("악기 등록하기")
                        .fontWeight(.bold)
                        .underline()
                        .foregroundStyle(.black)
                }
                Spacer()
            }
            
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
    }
}

#Preview {
    MyInstrumentView()
}
