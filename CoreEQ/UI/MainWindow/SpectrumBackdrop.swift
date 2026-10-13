import SwiftUI
import Foundation

struct SpectrumBackdrop: View {
    @ObservedObject var spectrum: SpectrumAnalyzer
    let axis: ResponseAxis
    let plotHeight: CGFloat

    var body: some View {
        Canvas { context, _ in

            let points = spectrum.points
            // Silence would otherwise stroke a flat line along the floor of the
            // plot, which reads as a stray rule under the frequency labels.
            guard points.count > 1, points.contains(where: { $0.level > 0.02 }) else { return }

            var line = Path()
            for (index, point) in points.enumerated() {
                let position = CGPoint(
                    x: axis.x(point.frequency), y: plotHeight * (1 - CGFloat(point.level)))
                if index == 0 {
                    line.move(to: position)
                } else {
                    line.addLine(to: position)
                }
            }

            var fill = line
            fill.addLine(to: CGPoint(x: axis.x(points[points.count - 1].frequency), y: plotHeight))
            fill.addLine(to: CGPoint(x: axis.x(points[0].frequency), y: plotHeight))
            fill.closeSubpath()

            // Deliberately faint: the analyzer is context for the curve, not a
            // second subject.
            //context.fill(fill, with: .color(.primary.opacity(0.05)))
            //context.stroke(line, with: .color(.primary.opacity(0.13)), lineWidth: 1)

            //dpf mods
            //255, 51, 184
            //53, 255, 46
            //46, 234, 255
            //0, 255, 8
            //225, 255, 0 - yellow
            //15, 239, 255 - cyan
            //let myColor1 = Color(red: 15/255, green: 239/255, blue: 255/255)
            //let myColor2 = Color(red: 15/255, green: 239/255, blue: 255/255)
            
            
            // Define the boundaries
            let minRangeValue: CGFloat = 0.0
            let maxRangeValue: CGFloat = 255.0

            // Generate and assign the random value
            let rndRed: CGFloat = Double.random(in: minRangeValue...maxRangeValue)
            let rndGrn: CGFloat = Double.random(in: minRangeValue...maxRangeValue)
            let rndBlu: CGFloat = Double.random(in: minRangeValue...maxRangeValue)
            
            
            
            
            let waveFormTrim = Color(red: rndRed/255, green: rndGrn/255, blue: rndBlu/255)
            let waveFormFill = Color(red: rndRed/255, green: rndGrn/255, blue: rndBlu/255)
            
            context.fill(fill, with: .color(waveFormTrim.opacity(0.05)))
            context.stroke(line, with: .color(waveFormFill.opacity(0.50)), lineWidth: 1)
        }
        .allowsHitTesting(false)
    }
}
