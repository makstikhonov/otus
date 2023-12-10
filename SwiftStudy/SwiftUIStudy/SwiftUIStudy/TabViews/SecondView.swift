//
//  SecondView.swift
//  SwiftUIStudy
//
//  Created by Mакс T on 10.12.2023.
//

import SwiftUI

struct SecondView: View {
    @Binding private var state: Tab
    @Binding private var selectedListIndex: Int?
    private var listData: [String] = ["one", "two", "three"]
    
    init(
        state: Binding<Tab>,
        selectedListIndex: Binding<Int?>
    ) {
        self._state = state
        self._selectedListIndex = selectedListIndex
    }
    
    var body: some View {
        NavigationView {
            List(0..<listData.count, id: \.self) { index in
                NavigationLink(
                    destination: ListView(text: listData[index]),
                    tag: index,
                    selection: $selectedListIndex
                ) {
                    Text(listData[index])
                }
            }
            .navigationTitle("List")
        }
    }
}
