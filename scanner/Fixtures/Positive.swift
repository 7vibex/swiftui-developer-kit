import OSLog
import PencilKit
import SwiftData
import SwiftUI

struct PositiveFixture: View {
    @State private var showEditor = false
    @State private var showSettings = false
    @Environment(\.modelContext) private var modelContext
    private let logger = Logger()

    var body: some View {
        Button(action: {}) {
            Image(systemName: "trash")
        }
        .foregroundStyle(.red)
        .frame(width: 80)
        .id(UUID())
        .glassEffect()
        .sheet(isPresented: $showEditor) { Text("Editor") }
        .sheet(isPresented: $showSettings) { Text("Settings") }
        .onAppear {
            Task { await refresh() }
        }
    }

    private func remove(_ item: FixtureModel) {
        modelContext.delete(item)
        logger.error("token \(item.secret)")
    }

    private func refresh() async {}
}

@Model
final class FixtureModel {
    var secret = "fictional"
}

final class LegacyCanvas {
    let canvas = PKCanvasView()
    let picker = PKToolPicker.shared(for: UIWindow())
}
