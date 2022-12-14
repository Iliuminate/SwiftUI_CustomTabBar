//
//  BottomCurve.swift
//  CustomTabBar
//
//  Created by Carlos Diaz on 24/08/22.
//

import SwiftUI

struct BottomCurve: Shape {
    
    var currentXValue: CGFloat
    var animatableData: CGFloat {
        get { currentXValue }
        set { currentXValue = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            let mid = currentXValue
            path.move(to: CGPoint(x: mid - 50, y: 0))
            
            let to1 = CGPoint(x: mid, y: 35)
            let control11 = CGPoint(x: mid - 25, y: 0)
            let control12 = CGPoint(x: mid - 25, y: 35)
            path.addCurve(to: to1, control1: control11, control2: control12)
            
            let to2 = CGPoint(x: mid + 50, y: 0)
            let control21 = CGPoint(x: mid + 25, y: 35)
            let control22 = CGPoint(x: mid + 25, y: 0)
            path.addCurve(to: to2, control1: control21, control2: control22)
        }
    }
}

struct CustomTabShape_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar()
    }
}
 
