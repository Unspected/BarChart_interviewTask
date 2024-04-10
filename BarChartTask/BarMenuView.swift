//
//  BarMenuView.swift
//  BarChartTask
//
//  Created by Pavel Andreev on 4/9/24.
//

import Foundation
import SwiftUI

struct BarMenuView: View {
    
    @State private var value: Double
    @State private var color: Color
    
    let onSubmit: (BarModel) -> Void
    
    init(params: BarModel? = nil, onSubmit: @escaping (BarModel) -> Void) {
        self.onSubmit = onSubmit
        value = params?.value ?? 0.5
        color = params?.color ?? .black
    }
    
    var body: some View {
        List {
            Section("Initial properties") {
                RowView("Value") {
                    Slider(value: $value, in: 0...1)
                }
                ColorPicker("Color", selection: $color)
                Button("Save") {
                    onSubmit(.init(value: value, color: color))
                }
            }
        }
        .frame(idealWidth: 320, idealHeight: 200)
    }
    
    private func RowView<Content: View>(_ title: String, content: @escaping () -> Content) -> some View {
        HStack {
            Text(title)
            content()
        }
    }
}
