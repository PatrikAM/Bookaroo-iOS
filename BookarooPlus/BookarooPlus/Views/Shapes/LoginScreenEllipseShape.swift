//
//  LoginScreenEllipseShape.swift
//  BookarooPlus
//
//  Created by Marek Glas on 05.01.2024.
//

import Foundation
import SwiftUI

struct LoginScreenEllipseShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0, y: 0.08607*height))
        path.addLine(to: CGPoint(x: 0, y: 1.01913*height))
        path.addLine(to: CGPoint(x: width, y: 1.01913*height))
        path.addLine(to: CGPoint(x: width, y: 0.08607*height))
        path.addCurve(to: CGPoint(x: 0.50254*width, y: 0), control1: CGPoint(x: width, y: 0.08607*height), control2: CGPoint(x: 0.69932*width, y: 0.00034*height))
        path.addCurve(to: CGPoint(x: 0, y: 0.08607*height), control1: CGPoint(x: 0.30381*width, y: -0.00034*height), control2: CGPoint(x: 0, y: 0.08607*height))
        path.closeSubpath()
        return path
    }
}
