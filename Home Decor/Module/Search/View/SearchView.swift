//
//  SearchView.swift
//  Home Decor
//
//  Created by Dalynn on 8/26/25.
//

import SwiftUI

struct SearchView: View {
    @State var searchText: String = ""
    let list: [String] = ["Bed", "Lamp", "Plastic Plants", "Carpet", "Sofa", "Blue Chairs"]
    @State var isfillter: Bool = false
    var body: some View {
        VStack(spacing: 0) {
            CustomNavBar(title: "Search")
            VStack {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.selectPink, lineWidth: 1)
                    .frame(height: 35)
                    .overlay {
                        HStack {
                            TextField("Search", text: $searchText)
                                .textFieldStyle(.plain)
                                .foregroundColor(.white)
                            
                            Button {
                                isfillter.toggle()
                            } label: {
                                Image(.filtter)
                                    .frame(width: 26, height: 26)
                            }
                        }
                        .padding(.leading, 16)
                        .padding(.trailing, 5)
                    }
            }
            .padding(.top, 12)
            .padding(.horizontal, 16)
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
                .padding(.top, 12)
                .padding(.horizontal, 16)
            }
        }
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
