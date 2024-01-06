//
//  SegmentedControlView.swift
//  NavigatonStackAndPagination
//
//  Created by Mакс T on 06.01.2024.
//

import SwiftUI

struct SegmentedControlView: View {
    @State private var selectedCountry = "russia"
    
    var body: some View {
        VStack {
            Text("News about:")
            Picker("Choose country", selection: $selectedCountry) {
                Text("Russia").tag("russia")
                Text("Usa").tag("usa")
                Text("Japan").tag("japan")
            }
            .pickerStyle(.segmented)
            .padding(.all, 10)

            CountryView(country: selectedCountry)

            Spacer()
        }
    }
}

#Preview {
    SegmentedControlView()
}
