import SwiftUI

struct Splash: View {
    
    @EnvironmentObject var source: Source
    @State var value: Double = 0
    @Binding var screen: Screen
    
    var body: some View {
        ZStack {
            Image("SplashBackground")
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 4) {
                Image("SplashImage4")
                    .resizable()
                    .scaledToFit()
            }
        }
        .onAppear {
            source.load {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    screen = .main
                }
            }
        }
    }
}

struct Splash_Preview: PreviewProvider {
    
    @State static var splash: Screen = .splash
    
    static var previews: some View {
        Splash(screen: $splash)
            .environmentObject(Source())
    }
}

extension View {
    public func gradientForeground(colors: [Color]) -> some View {
        self.overlay(
            LinearGradient(
                colors: colors,
                startPoint: .top,
                endPoint: .bottom)
        )
            .mask(self)
    }
}
