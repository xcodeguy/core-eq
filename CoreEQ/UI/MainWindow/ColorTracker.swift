//
//  ColorTracker.swift
//  CoreEQ
//
//  Created by David Ferrell on 10/13/26.
//

import Combine
import SwiftUI  // Assuming you use standard SwiftUI types

@MainActor
class ColorTracker: ObservableObject {
    // Use @Published so that any View observing this object is notified when these values change.
    @Published var redValue: CGFloat = 0.1
    @Published var greenValue: CGFloat = 0.2
    @Published var blueValue: CGFloat = 0.3
    @Published var finalColor: Color = Color(red: 0.0, green: 0.0, blue: 0.0)

    /// Increments all RGB components and returns the calculated color for this cycle.
    func incrementAndGetColor() -> Color {
        // Increase values by a defined step (e.g., 0.1)
        self.redValue = min(1.0, self.redValue + 0.15)
        self.greenValue = min(1.0, self.greenValue + 0.15)
        self.blueValue = min(1.0, self.blueValue + 0.15)

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            // Create the color based on the newly incremented values
            finalColor = Color(
                red: self.redValue / 255, green: self.greenValue / 255, blue: self.blueValue / 255)

        }
        
        return finalColor

    }
}
