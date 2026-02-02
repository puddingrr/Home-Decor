//
//  View+Ex.swift
//  InfoWebiOS
//
//  Created by lyborey on 29/11/23.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
    func roundedCorner(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
    
    func border(width: CGFloat, edges: [Edge], color: Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
    
    func customSheet<Content, Background>(isPresented: Binding<Bool>,
                                          backgroundColor: Background? = Color.red,
                                          @ViewBuilder content: @escaping () -> Content) -> some View where Content: View, Background: View {
        return self.sheet(isPresented: isPresented) {
            ZStack {
                backgroundColor
                    .ignoresSafeArea()
                SheetContent(content: content)
            }
        }
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension UIViewController {
    class func topMostViewController() -> UIViewController? {
        
        // In iOS 13.0 and later,
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let windows = windowScene.windows
            // Access windows specific to the scene
            if let keyWindow = windows.first(where: { $0.isKeyWindow }) {
                var topController = keyWindow.rootViewController
                while let presentedViewController = topController?.presentedViewController {
                    topController = presentedViewController
                }
                return topController
            }
        }
        return nil
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct EdgeBorder: Shape {
    var width: CGFloat
    var edges: [Edge]

    func path(in rect: CGRect) -> Path {
        edges.map { edge -> Path in
            switch edge {
            case .top: return Path(.init(x: rect.minX, y: rect.minY, width: rect.width, height: width))
            case .bottom: return Path(.init(x: rect.minX, y: rect.maxY - width, width: rect.width, height: width))
            case .leading: return Path(.init(x: rect.minX, y: rect.minY, width: width, height: rect.height))
            case .trailing: return Path(.init(x: rect.maxX - width, y: rect.minY, width: width, height: rect.height))
            }
        }.reduce(into: Path()) { $0.addPath($1) }
    }
}

struct SheetContent<Content: View>: View {
    @ViewBuilder var content: Content
    @State private var contentHeight: CGFloat = 300 // Default height

    var body: some View {
        content
//        .presentationDetents([.height(contentHeight)])
        .background(
            GeometryReader { geometry in
                Color.clear
                    .onAppear {
                        contentHeight = geometry.size.height
                    }
                    .onChange(of: geometry.size.height) { _ in
                        contentHeight = geometry.size.height
                    }
            }
        )
    }
}

extension View {
    func navigationBarColor(backgroundColor: Color, titleColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, titleColor: titleColor))
    }
    func scrollToOffset(contentOffset: Binding<CGPoint?>) -> some View {
        return self.background {
            InternalScrollViewHelper(contentOffset: contentOffset)
        }
    }
}
struct InternalScrollViewHelper: UIViewRepresentable {
    @Binding var contentOffset: CGPoint?

    class Coordinator {
        var scrollView: UIScrollView?
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    func makeUIView(context: Context) -> UIView {
        let view = ScrollViewIdentifier()
        view.scrollViewCompletion = { scrollView in
            context.coordinator.scrollView = scrollView
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        if let offset = contentOffset {
            // Always scroll, even to same value
            DispatchQueue.main.async {
                context.coordinator.scrollView?.setContentOffset(offset, animated: true)
            }
        }
    }
}

final class ScrollViewIdentifier: UIView {
    var scrollViewCompletion: ((UIScrollView) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override func didMoveToWindow() {
        guard let scrollView = superview?.superview?.superview as? UIScrollView else {
            return
        }
        self.scrollViewCompletion?(scrollView)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

struct NavigationBarModifier: ViewModifier {

    var backgroundColor: UIColor?
    var titleColor: UIColor?

    init(backgroundColor: Color, titleColor: UIColor?) {
        self.backgroundColor = UIColor(backgroundColor)
        
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = .clear // The key is here. Change the actual bar to clear.
        coloredAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .white]
        coloredAppearance.shadowColor = .clear
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().tintColor = titleColor
    }

    func body(content: Content) -> some View {
        ZStack {
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}
