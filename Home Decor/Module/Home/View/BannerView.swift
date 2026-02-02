//
//  BannerView.swift
//  Home Decor
//
//  Created by Dalynn on 1/31/26.
//

import SwiftUI
import Combine

struct BannerView: View {
    let images: [String]
    let height: CGFloat
    let interval: TimeInterval

    @State private var pageIndex: Int = 0
    private let timer: Publishers.Autoconnect<Timer.TimerPublisher>

    init(
        images: [String],
        height: CGFloat = 140,
        interval: TimeInterval = 2
    ) {
        self.images = images
        self.height = height
        self.interval = interval
        self.timer = Timer.publish(every: interval, on: .main, in: .common).autoconnect()
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $pageIndex) {
                ForEach(images.indices, id: \.self) { i in
                    Image(images[i])
                        .resizable()
                        .frame(maxWidth: .infinity)
                        .frame(height: height)
                        .cornerRadius(10)
                        .tag(i)
                }
            }
            .frame(height: height)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .onReceive(timer) { _ in
                guard !images.isEmpty else { return }
                pageIndex = (pageIndex + 1) % images.count
            }

            HStack(spacing: 6) {
                ForEach(images.indices, id: \.self) { i in
                    Capsule()
                        .fill(pageIndex == i ? Color.black.opacity(0.5) : Color.white)
                        .frame(width: 10, height: 6)
                        .animation(.easeInOut(duration: 0.6), value: pageIndex)
                }
            }
            .padding(.bottom, 4)
        }
        .padding(.horizontal, 16)
    }
}
