//
//  TabScreenView.swift
//  RecordIt
//
//  Created by 이진 on 4/12/24.
//

import SwiftUI

struct TabScreenView: View {
    
    @Binding var selectedTab: Tab
        
        var body: some View {
            NavigationStack {
                TabView(selection: $selectedTab) {
                    
                    Text("1")
                        .tabItem {
                            Image(systemName: "circle.circle")
                        }
                        .tag(Tab.home)
                    
                    Text("1")
                        .tabItem {
                            Image(systemName: "person")
                        }
                        .tag(Tab.profile)
                }
            }
        }
}

#Preview {
    TabScreenView(selectedTab: .constant(.home))
}
