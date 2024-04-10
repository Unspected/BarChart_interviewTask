//
//  BarModel.swift
//  BarChartTask
//
//  Created by Pavel Andreev on 4/9/24.
//

import Foundation
import SwiftUI

struct BarModel: Identifiable, Equatable {
    let id: UUID
    let value: Double
    let color: Color
    
    init(id: UUID = UUID(), value: Double, color: Color) {
        self.id = id
        self.value = value
        self.color = color
    }
    
    func with(value: Double? = nil, color: Color? = nil) -> Self {
        .init(id: id, value: value ?? self.value, color: color ?? self.color)
    }
}
