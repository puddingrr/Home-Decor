//
//  BedRoom.swift
//  Home Decor
//
//  Created by Dalynn on 10/22/25.
//

import SwiftUI

struct CategoryMenuView: View {
    var body: some View {
        VStack {
            CustomNavBar(title: "Bedroom")
            VStack {
                VStack {
                    TextSwifUI(title: "BedRoom")
                        .padding(4)
                        .frame(width: 100, height: 100)
                        .background(Color.main.cornerRadius(12))
                }
                
                HStack {
                    VStack {
                        TextSwifUI(title: "BedRoom")
                            .padding(4)
                            .frame(width: 100, height: 100)
                            .background(Color.main.cornerRadius(12))
                    }
                    VStack {
                        TextSwifUI(title: "BedRoom")
                            .padding(4)
                            .frame(width: 100, height: 100)
                            .background(Color.main.cornerRadius(12))
                    }
                }
                TextSwifUI(title: "BedRoom")
                    .padding(4)
                    .frame(width: 100, height: 100)
                    .background(Color.main.cornerRadius(12))
            }
        }
    }
}

enum ListItem: String {
    case decorativeLight = "Decorative Light"
    case beds = "Beds"
    case chairs = "Chairs"
    case sofa = "Sofa"
    case tables = "Tables"
    case cupboard = "Cupboard"
}
