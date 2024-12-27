import SwiftUI

struct ContentView: View {
    @EnvironmentObject var source: Source
    @State var screen: Screen = .splash
    
    var body: some View {
        switch screen {
        case .splash:
            Splash(screen: $screen)
        case .main:
            Tab()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(Source())
}

enum Screen {
    case splash
    case main
}


