//
//  SearchView.swift
//  Home Decor
//
//  Created by Dalynn on 8/26/25.
//

import SwiftUI

struct SearchView: View {
    
    @State var searchText: String = ""
    @State var isfillter: Bool = false
    @FocusState private var isSearchFocused: Bool

    let list: [String] = ["Bed", "Lamp", "Plastic Plants", "Carpet", "Sofa", "Blue Chairs"]

    var filteredList: [String] {
        if searchText.isEmpty {
            return list
        } else {
            return list.filter {
                $0.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    var body: some View {
        VStack(spacing: 0) {
            if !isSearchFocused {
                CustomNavBar(title: "Search",trailingBtnIcon: .filtter, isShadow: true, actionTrailingIcon: {
                    isfillter.toggle()
                })
            }
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    TextSwifUI(title: "Top Searches", size: .large, color: .selectPink, weight: .bold)
                        .padding(EdgeInsets(top: 16, leading: 0, bottom: 10, trailing: 0))
                    ForEach(0..<list.count, id: \.self) { i in
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color.lightOrange)
                            .frame(height: 52)
                            .overlay {
                                HStack(spacing: 16) {
                                    Image(.search)
                                        .frame(width: 26, height: 26)
                                    TextSwifUI(title: list[i], size: .medium)
                                    Spacer()
                                }
                                .padding(.horizontal, 16)
                            }
                    }
                }
                .padding(.horizontal, 16)
            }
            Spacer()
        }
        .searchable(
            text: $searchText,
            prompt: "Search furniture"
        )
        .focused($isSearchFocused)
        .navigationBarHidden(true)
        .sheet(isPresented: $isfillter) {
            SearchFiltterView()
                .presentationDetents([.height(600), .large])
            .presentationDragIndicator(.hidden)
        }
        .onTapGesture {
            Utilize.hideKeyboard()
        }
    }
}
