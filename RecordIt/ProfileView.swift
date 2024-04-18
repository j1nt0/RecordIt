//
//  ProfileView.swift
//  RecordIt
//
//  Created by 이진 on 4/12/24.
//

import SwiftUI

struct ProfileView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

        var backButton : some View {
            Button{
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                HStack {
                    Image(systemName: "chevron.left")
                        .aspectRatio(contentMode: .fit)
                    Text("프로필")
                        .font(.system(size: 23, weight: .semibold))
                }
                .foregroundStyle(.black)
            }
        }
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 50)
            Image("Profile")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)
                .foregroundStyle(.gray)
            Spacer()
                .frame(height: 20)
            Text("진토")
                .font(.system(size: 25, weight: .bold))
            Spacer()
                .frame(height: 50)
            NavigationLink {
                MyInstrumentView()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0)
                        .frame(width: 320, height: 70)
                        .foregroundStyle(.white)
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.1), radius: 10)
                    Text("나의 악기")
                        .font(.system(size: 23, weight: .semibold))
                        .foregroundStyle(.black)
                }
            }

            Spacer()
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
    }
}

#Preview {
    ProfileView()
}
