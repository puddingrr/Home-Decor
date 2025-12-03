//
//  FlowLayoutView.swift
//  Home Decor
//
//  Created by Dalynn on 8/27/25.
//
import SwiftUI

struct FlowLayout: Layout {
    var spacing: CGFloat = 8
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        var width: CGFloat = 0
        var height: CGFloat = 0
        var currentLineHeight: CGFloat = 0
        
        let maxWidth = proposal.width ?? .infinity
        
        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            
            if width + size.width + spacing > maxWidth {
                width = 0
                height += currentLineHeight + spacing
                currentLineHeight = 0
            }
            
            width += size.width + spacing
            currentLineHeight = max(currentLineHeight, size.height)
        }
        
        height += currentLineHeight
        return CGSize(width: maxWidth, height: height)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var x = bounds.minX
        var y = bounds.minY
        var currentLineHeight: CGFloat = 0
        
        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            
            if x + size.width + spacing > bounds.maxX {
                x = bounds.minX
                y += currentLineHeight + spacing
                currentLineHeight = 0
            }
            
            subview.place(at: CGPoint(x: x, y: y), proposal: ProposedViewSize(size))
            x += size.width + spacing
            currentLineHeight = max(currentLineHeight, size.height)
        }
    }
}
