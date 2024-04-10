//
//  ChartView.swift
//  BarChartTask
//
//  Created by Pavel Andreev on 4/9/24.
//

import Foundation
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ChartView()
                .navigationTitle("ChartView")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ChartView: View {
    
    @State private var isMenuPresented: Bool = false
    @State private var selectedBar: BarModel?
    @State private var bars: [BarModel] = []
    
    var body: some View {
        HStack {
            ForEach(bars) { bar in
                BarView(bar: bar) { result in
                    updateBar(result)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.yellow)
        .toolbar(content: {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button(action: {
                    isMenuPresented = true
                }, label: {
                    Image(systemName: "plus.square")
                })
                .popover(isPresented: $isMenuPresented, content: {
                    BarMenuView { result in
                        bars.append(result)
                        isMenuPresented = false
                    }
                })
            }
        })
    }
    
    private func updateBar(_ bar: BarModel) {
        if let index = bars.firstIndex(where: { $0.id == bar.id }) {
            bars[index] = bar
        }
    }
}

struct BarView: View {
    
    @State private var isMenuPresented: Bool = false
    
    let bar: BarModel
    let onChaged: (BarModel) -> Void
    
    // Square 
    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(bar.color)
                .frame(
                    height: bar.value * geometry.size.height
                )
                .popover(isPresented: $isMenuPresented, content: {
                    BarMenuView(params: bar) { result in
                        onChaged(bar.with(
                            value: result.value,
                            color: result.color
                        ))
                        isMenuPresented = false
                    }
                })
                .offset(
                    y: geometry.size.height - bar.value * geometry.size.height
                )
                .animation(.easeInOut, value: bar)
                .onTapGesture {
                    isMenuPresented.toggle()
                }
        }
    }
}

#Preview {
    ContentView()
}

