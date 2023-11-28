//
//  SystemStatistics.swift
//  ServerlessSmarthome
//
//  Created by Hlib Anisimov on 28.11.2023.
//

import SwiftUI
import SwiftData
import Charts

struct SystemStatistics: View {
    @Environment(\.modelContext) private var modelContext
    
    @Bindable var smartSystem: SmartSystem
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                Chart {
                    ForEach(smartSystem.devices) { device in
                        ForEach(device.dataDict.sorted(by: >), id: \.key) { date, value in
                            PointMark(
                                x: .value("Creation time", date.toString(format: .chart)),
                                y: .value("Value", value)
                            )
                            .foregroundStyle(by: .value("Device", device.name))
                            .shadow(color: .black, radius: 1)
                        }
                    }
                }
                .chartXAxis {
                    AxisMarks() {
                        AxisGridLine(centered: true, stroke: StrokeStyle(dash: [4.0, 4.0]))
                        AxisValueLabel()
                            .font(.footnote.weight(.semibold))
                            .foregroundStyle(.black)
                    }
                }
                .chartYAxis {
                    AxisMarks() {
                        AxisGridLine(centered: true, stroke: StrokeStyle(dash: [4.0, 4.0]))
                        AxisValueLabel()
                            .font(.footnote.weight(.semibold))
                            .foregroundStyle(.black)
                    }
                }
                .chartScrollableAxes([.horizontal, .vertical])
                .frame(height: proxy.size.height / 2 - 8)
                Divider()
                Chart {
                    ForEach(smartSystem.devices) { device in
                        ForEach(device.dataValCountDict.sorted(by: >), id: \.key) { value, count in
                            BarMark(
                                x: .value("Value", value),
                                y: .value("Count", count)
                            )
                            .foregroundStyle(by: .value("Device", device.name))
                            .shadow(color: .black, radius: 1)
                        }
                    }
                }
                .chartScrollableAxes(.horizontal)
                .chartXAxis {
                    AxisMarks() {
                        AxisGridLine(centered: true, stroke: StrokeStyle(dash: [4.0, 4.0]))
                        AxisValueLabel()
                            .font(.footnote.weight(.semibold))
                            .foregroundStyle(.black)
                    }
                }
                .chartYAxis {
                    AxisMarks() {
                        AxisGridLine(centered: true, stroke: StrokeStyle(dash: [4.0, 4.0]))
                        AxisValueLabel()
                            .font(.footnote.weight(.semibold))
                            .foregroundStyle(.black)
                    }
                }
                .frame(height: proxy.size.height / 2 - 8)
                .chartLegend(.visible)
            }
            .scrollContentBackground(.hidden)
        }
        .navigationTitle("Statistics")
    }
}
