import SwiftUI

struct Tab: View {
    
    @State var selection = 0
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor(rgbColorCodeRed: 153, green: 153, blue: 153, alpha: 1)
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(rgbColorCodeRed: 153, green: 153, blue: 153, alpha: 1)]

        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(rgbColorCodeRed: 139, green: 90, blue: 243, alpha: 1)
        //UIColor(rgbColorCodeRed: 57, green: 229, blue: 123, alpha: 1)
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(rgbColorCodeRed: 139, green: 90, blue: 243, alpha: 1)]
        appearance.backgroundColor = UIColor.white
        appearance.shadowColor = .white.withAlphaComponent(0.15)
        appearance.shadowImage = UIImage(named: "tab-shadow")?.withRenderingMode(.alwaysTemplate)
        UITabBar.appearance().backgroundColor = UIColor.white
        UITabBar.appearance().standardAppearance = appearance
    }
    
    var body: some View {
        ZStack {
            TabView(selection: $selection) {
                ConsumptionView()
                    .tabItem { VStack {
                        tabViewImage("fork.knife")
                        Text("Consumption") .font(.system(size: 10, weight: .medium))
                    } }
                    .tag(0)
                PriceView()
                    .tabItem { VStack {
                        tabViewImage("list.bullet.rectangle.portrait")
                        Text("Price") .font(.system(size: 10, weight: .medium))
                    } }
                    .tag(1)
                GoalView()
                    .tabItem { VStack{
                        tabViewImage("highlighter")
                        Text("Goals")
                            .font(.system(size: 10, weight: .medium))
                    }
                    }
                    .tag(2)
                SettingsView()
                    .tabItem {
                        VStack {
                            tabViewImage("gear")
                            Text("Settings") .font(.system(size: 10, weight: .medium))
                        }
                    }
                    .tag(3)
            }
        }
        .onAppear {
            AppDelegate.orientationLock = .portrait
        }
    }
    
    @ViewBuilder func tabViewImage(_ systemName: String) -> some View {
        if #available(iOS 15.0, *) {
            Image(systemName: systemName)
                .font(.system(size: 18, weight: .medium))
                .environment(\.symbolVariants, .none)
        } else {
            Image(systemName: systemName)
                .font(.system(size: 18, weight: .medium))
        }
    }
}

#Preview {
    Tab()
        .environmentObject(Source())
}



extension UIColor {
   convenience init(rgbColorCodeRed red: Int, green: Int, blue: Int, alpha: CGFloat) {

     let redPart: CGFloat = CGFloat(red) / 255
     let greenPart: CGFloat = CGFloat(green) / 255
     let bluePart: CGFloat = CGFloat(blue) / 255

     self.init(red: redPart, green: greenPart, blue: bluePart, alpha: alpha)
   }
}

extension UITabBarController {
    var height: CGFloat {
        return self.tabBar.frame.size.height
    }
    
    var width: CGFloat {
        return self.tabBar.frame.size.width
    }
}
