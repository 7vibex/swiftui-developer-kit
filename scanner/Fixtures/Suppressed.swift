import SwiftUI

struct SuppressedFixture: View {
    var body: some View {
        Button(action: {}) {
            Image(systemName: "wand.and.stars")
        }
        // swiftui-kit:disable fixed-frame-dynamic-type-risk
        .frame(width: 80)
    }
}
