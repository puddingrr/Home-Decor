//
//  RatingView.swift
//  Home Decor
//
//  Created by Dalynn on 5/28/26.
//
import SwiftUI

struct StarRatingView: View {
    var rating: CGFloat
    var maxRating: Int = 5
    var size: CGFloat = 16
    
    var body: some View {
        // Background: empty stars
        ZStack(alignment: .leading) {
            HStack(spacing: 0) {
                ForEach(0..<maxRating, id: \.self) { _ in
                    Image(.starNotActive)
                        .resizable()
                        .frame(width: size, height: size)
                }
            }
            
            // Foreground: filled stars
            HStack(spacing: 0) {
                ForEach(0..<maxRating, id: \.self) { _ in
                    Image(.starActive)
                        .resizable()
                        .frame(width: size, height: size)
                }
            }
            // Mask only the needed width
            .mask(
                HStack(spacing: 5) {
                    Spacer(minLength: 0)
                    Rectangle()
                        .frame(width: size * rating)
                }
            )
        }
    }
}
