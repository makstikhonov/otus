//
//  MainView.swift
//  SwiftUIStudy
//
//  Created by Mакс T on 10.12.2023.
//

import SwiftUI

enum Tab: Int {
    case first
    case second
    case third
}

struct MainView: View {
    @State private var selectedTab: Tab = .first
    @State private var selectedListIndex: Int? = nil
    @State private var isModalShown: Bool = false
    
    var body: some View {
        TabView(selection: $selectedTab) {
            FirstView(state: $selectedTab, selectedListIndex: $selectedListIndex)
                .tabItem {
                    Image(systemName: "1.circle")
                    Text("Tab 1")
                }
                .tag(Tab.first)
            
            SecondView(state: $selectedTab, selectedListIndex: $selectedListIndex)
                .tabItem {
                    Image(systemName: "2.circle")
                    Text("Tab 2")
                }
                .tag(Tab.second)
            
            ThirdView(isModalShown: $isModalShown)
                .tabItem {
                    Image(systemName: "3.circle")
                    Text("Tab 3")
                }
                .tag(Tab.second)
        }
        .animation(.easeInOut)
        .sheet(isPresented: $isModalShown, content: {
            ListView(text: "Modal")
        })
    }
}
