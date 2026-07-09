import SwiftUI

struct NegativeFixture: View {
    var body: some View {
        VStack {
            Image(systemName: "chevron.right")
                .accessibilityHidden(true)
            Button {
            } label: {
                Label("Add session", systemImage: "plus")
            }
        }
    }
}
