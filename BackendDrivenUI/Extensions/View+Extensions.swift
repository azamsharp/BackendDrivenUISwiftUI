//
//  View+Extensions.swift
//  BackendDrivenUI
//
//  Created by Mohammad Azam on 10/13/20.
//

import Foundation
import SwiftUI

extension View {
    func toAnyView() -> AnyView {
        AnyView(self)
    }
}
