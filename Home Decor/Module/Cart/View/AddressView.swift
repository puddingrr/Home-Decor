//
//  AdressView.swift
//  Home Decor
//
//  Created by Dalynn on 5/28/26.
//

import SwiftUI
import MapKit

struct AddressView: View {
    var body: some View {
        VStack(spacing: 0) {
            CustomNavBar(title: "Submit order",isBack: true, isbackhColor: .red, isShadow: true)
                .background(Color(.systemBackground))
            Spacer()
        }
    }
}
struct AddressSection: View {
    var onAction: (() -> Void)?
    var body: some View {
        HStack(alignment: .center, spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.red.opacity(0.1))
                    .frame(width: 48, height: 48)
                Image(systemName: "camera")
                    .font(.system(size: 18))
                    .foregroundColor(.red.opacity(0.7))
            }

            VStack(alignment: .leading, spacing: 3) {
                Text("Khan Sensok Phnom Penh Phnom Penh Cambodia")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.primary)
                    .fixedSize(horizontal: false, vertical: true)
                Text("Dalyn, 855069680104")
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 13))
                .foregroundColor(.secondary)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
        .background(Color(.systemBackground))
        .onTapGesture {
            onAction?()
        }
    }
}

struct ChooseAddressView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedIndex: Int = 0
    @State private var showAddAddress = false
    
    let addresses: [AddressItem] = [
        AddressItem(
            fullAddress: "Khan Sensok Phnom Penh Phnom Penh Cambodia",
            contactName: "Mrs.Dalyn",
            phone: "855069680104",
            tags: ["Default", "Office"],
            isDefault: true
        ),
        AddressItem(
            fullAddress: "Phnom Penh Hanoi Friendship Blvd. (1019) Khan Sensok Phnom Penh Phnom Penh Cambodia",
            contactName: "Mrs.Dalyn",
            phone: "855069680104",
            tags: ["Home"],
            isDefault: false
        ),
        AddressItem(
            fullAddress: "Khan Doun Penh Phnom Penh Phnom Penh Cambodia មន្ទីរពេទ្យកាល់មែត",
            contactName: "Mrs.Dalin",
            phone: "855069680104",
            tags: [],
            isDefault: false
        )
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavBar(title: "Choose Address",isBack: true, isbackhColor: .red, isShadow: true)
                .background(Color(.systemBackground))
            RoundedRectangle(cornerRadius: 0)
                .frame(height: 1)
                .foregroundColor(Color.gray.opacity(0.3))
            VStack {
                Button {
                    showAddAddress = true
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "plus")
                            .foregroundColor(.brandYellow)
                            .fontWeight(.semibold)
                        TextSwifUI(title: "Add address", size: .other(16), weight: .medium)
                    }
                    .padding(8)
                    .frame(maxWidth: .infinity)
                    .background(.authTitle)
                    .cornerRadius(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.authBg.opacity(0.1), lineWidth: 1)
                    }
                    .padding(.bottom, 16)
                }
                HStack(spacing: 6) {
                    TextSwifUI(title: "My address", size: .other(16), weight: .bold)
                    Spacer()
                }
                ForEach(Array(addresses.enumerated()), id: \.element.id) { index, address in
                    AddressRow(
                        address: address,
                        isSelected: selectedIndex == index
                    ) {
                        selectedIndex = index
                    }
                    if index < addresses.count - 1 {
                        Divider()
                            .frame(height: 1)
                    }
                }
                
            }
            .padding(16)
            Spacer()
        }
        .sheet(isPresented: $showAddAddress) {
            AddAddressView()
        }
    }
}

struct AddressRow: View {
    let address: AddressItem
    let isSelected: Bool
    let onTap: () -> Void
    var body: some View {
        Button(action: onTap) {
            HStack(alignment: .top, spacing: 12) {
                ZStack {
                    Circle()
                        .strokeBorder(isSelected ? Color.brandYellow : Color.gray.opacity(0.4), lineWidth: 2)
                        .frame(width: 20, height: 20)
                    if isSelected {
                        Circle()
                            .fill(Color.brandYellow)
                            .frame(width: 10, height: 10)
                    }
                }
                .padding(.top, 2)

                VStack(alignment: .leading, spacing: 4) {
                    Text(address.fullAddress)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)

                    Text("\(address.contactName), \(address.phone)")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    if !address.tags.isEmpty {
                        HStack(spacing: 6) {
                            ForEach(address.tags, id: \.self) { tag in
                                TagBadge(label: tag)
                            }
                        }
                        .padding(.top, 2)
                    }
                }
                Spacer()
                Image(systemName: "square.and.pencil")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.top, 2)
            }
            .padding(.vertical, 4)
        }
        .buttonStyle(.plain)
    }
}

struct TagBadge: View {
    let label: String
    var body: some View {
        Text(label)
            .font(.caption2)
            .foregroundColor(.brandYellow)
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
            .overlay(
                Capsule()
                    .strokeBorder(Color.brandYellow, lineWidth: 0.8)
            )
    }
}

// MARK: - Add Address Screen
struct AddAddressView: View {
    @Environment(\.dismiss) var dismiss
    @State private var contactName: String = ""
    @State private var phoneNumber: String = ""
    @State private var address: String = ""
    @State private var detail: String = ""
    @State private var selectedGender: Gender = .mr
    @State private var selectedTag: AddressTag? = nil
    @State private var isDefault: Bool = false
    @State private var selectedPhotos: [UIImage] = []

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 11.5764, longitude: 104.9282),
        span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
    )

    enum Gender: String, CaseIterable {
        case mr = "MR"
        case ms = "MS"
    }

    enum AddressTag: String, CaseIterable {
        case home = "Home"
        case office = "Office"
        case school = "School"
        case other = "Other"
    }

    var body: some View {
        VStack(spacing: 0) {
            CustomNavBar(title: "Address View",isBack: true, isbackhColor: .red, isShadow: true)
                .background(Color(.systemBackground))
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    ZStack {
                        Map(coordinateRegion: $region)
                            .frame(height: 160)
                            .disabled(true)
                        
                        Image(systemName: "mappin.circle.fill")
                            .font(.system(size: 36))
                            .foregroundColor(.brandOrange)
                            .shadow(radius: 2)
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Street 1960")
                            .font(.headline)
                            .foregroundColor(.primary)
                        Text("Street 1960  Khan Sensok Phnom Penh Phnom Penh...")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Button {
                        } label: {
                            HStack(spacing: 6) {
                                Image(systemName: "location.circle")
                                    .foregroundColor(.brandOrange)
                                Text("Use current location")
                                    .font(.subheadline)
                                    .foregroundColor(.brandOrange)
                                    .fontWeight(.medium)
                            }
                        }
                        .padding(.top, 4)
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding(16)
                    .background(Color.fieldBackground)
                    Divider()
                    VStack(spacing: 0) {
                        FormRow {
                            Text("Contact")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .frame(width: 90, alignment: .leading)
                            TextField("Name", text: $contactName)
                                .font(.subheadline)
                            Spacer()
                            HStack(spacing: 12) {
                                ForEach(Gender.allCases, id: \.self) { gender in
                                    HStack(spacing: 4) {
                                        ZStack {
                                            Circle()
                                                .strokeBorder(
                                                    selectedGender == gender ? Color.brandOrange : Color.gray.opacity(0.4),
                                                    lineWidth: 1.5
                                                )
                                                .frame(width: 16, height: 16)
                                            if selectedGender == gender {
                                                Circle()
                                                    .fill(Color.brandOrange)
                                                    .frame(width: 8, height: 8)
                                            }
                                        }
                                        Text(gender.rawValue)
                                            .font(.caption)
                                            .foregroundColor(.primary)
                                    }
                                    .onTapGesture { selectedGender = gender }
                                }
                            }
                        }
                        
                        Divider().padding(.leading, 16)
                        
                        FormRow {
                            Text("Phone NO.")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .frame(width: 90, alignment: .leading)
                            HStack(spacing: 4) {
                                Text("855")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Image(systemName: "chevron.down")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                            }
                            TextField("Contact phone number", text: $phoneNumber)
                                .font(.subheadline)
                                .keyboardType(.phonePad)
                        }
                        
                        Divider().padding(.leading, 16)
                        
                        FormRow {
                            Text("Address")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .frame(width: 90, alignment: .leading)
                            TextField("Select Receiving Address", text: $address)
                                .font(.subheadline)
                            Spacer()
                            Image(systemName: "square.and.pencil")
                                .foregroundColor(.secondary)
                                .font(.caption)
                        }
                        
                        Divider().padding(.leading, 16)
                        
                        FormRow {
                            Text("Detail")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .frame(width: 90, alignment: .leading)
                            TextField("House number, floor, room, etc", text: $detail)
                                .font(.subheadline)
                        }
                        
                        Divider().padding(.leading, 16)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text("Tag")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .frame(width: 90, alignment: .leading)
                                HStack(spacing: 8) {
                                    ForEach(AddressTag.allCases, id: \.self) { tag in
                                        Text(tag.rawValue)
                                            .font(.caption)
                                            .foregroundColor(selectedTag == tag ? .white : .primary)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 5)
                                            .background(
                                                Capsule()
                                                    .fill(selectedTag == tag ? Color.brandOrange : Color.clear)
                                            )
                                            .overlay(
                                                Capsule()
                                                    .strokeBorder(
                                                        selectedTag == tag ? Color.clear : Color.gray.opacity(0.4),
                                                        lineWidth: 0.8
                                                    )
                                            )
                                            .onTapGesture {
                                                selectedTag = selectedTag == tag ? nil : tag
                                            }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(Color.fieldBackground)
                        
                        Divider().padding(.leading, 16)
                        
                        FormRow {
                            Text("Default Address")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Spacer()
                            Toggle("", isOn: $isDefault)
                                .labelsHidden()
                                .tint(.brandOrange)
                        }
                    }
                    .background(Color.fieldBackground)
                    
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Address Photos Up to 5")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        HStack(spacing: 10) {
                            VStack(spacing: 4) {
                                Image(systemName: "camera")
                                    .font(.title2)
                                    .foregroundColor(.secondary)
                                Text("add photo")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                            }
                            .frame(width: 72, height: 72)
                            .background(Color.gray.opacity(0.08))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .strokeBorder(Color.gray.opacity(0.3), lineWidth: 0.8)
                            )
                        }
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.pageBackground)
                    
                    Button {
                        dismiss()
                    } label: {
                        TextSwifUI(title: "Save", size: .other(16), color: .white)
                            .padding(.vertical, 16)
                            .frame(maxWidth: .infinity)
                            .background(UserPreference.shared.highlightColor.color)
                            .cornerRadius(30)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 16)
                    .background(Color.fieldBackground)
                }
            }
        }
    }
}

struct FormRow<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        HStack(spacing: 10) {
            content
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.fieldBackground)
    }
}
