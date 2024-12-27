import SwiftUI
import StoreKit

struct SettingsView: View {
    
    @EnvironmentObject var source: Source
    @Environment(\.openURL) var openURL
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.c226226226.ignoresSafeArea()
                
                Color.c204120254
                    .frame(height: safeAreaInsets.top)
                .frame(maxHeight: .infinity, alignment: .top)
                .ignoresSafeArea(.container, edges: .top)
                
                VStack(spacing: 0) {
                    Text("Settings")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 3, leading: 16, bottom: 8, trailing: 16))
                        .frame(maxWidth: .infinity)
                        .background(Color.c204120254)

                    VStack(spacing: 8) {
                        Button {
                            if let url = URL(string: "https://www.termsfeed.com/live/268dd584-18ca-4d91-9400-629253817c4c") {
                                openURL(url)
                            }
                        } label: {
                            HStack(spacing: 10) {
                                Image(systemName: "doc.fill")
                                    .font(.system(size: 17, weight: .semibold))
                                    .foregroundColor(.c13152178)
                                
                                Text("Usage Policy")
                                    .font(.system(size: 17, weight: .regular))
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity)
                                
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 17, weight: .semibold))
                                    .foregroundColor(.c158158158)
                            }
                            .padding(.horizontal, 16)
                            .frame(height: 44)
                            .background(Color.white)
                            .clipShape(.rect(cornerRadius: 10))
                        }
                        .padding(.horizontal, 16)
                        Button {
                            actionSheet()
                        } label: {
                            HStack(spacing: 10) {
                                Image(systemName: "square.and.arrow.up.fill")
                                    .font(.system(size: 17, weight: .semibold))
                                    .foregroundColor(.c13152178)
                                
                                Text("Share our app")
                                    .font(.system(size: 17, weight: .regular))
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity)
                                
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 17, weight: .semibold))
                                    .foregroundColor(.c158158158)
                            }
                            .padding(.horizontal, 16)
                            .frame(height: 44)
                            .background(Color.white)
                            .clipShape(.rect(cornerRadius: 10))
                        }
                        .padding(.horizontal, 16)
                        Button {
                            SKStoreReviewController.requestReviewInCurrentScene()
                        } label: {
                            HStack(spacing: 10) {
                                Image(systemName: "star.fill")
                                    .font(.system(size: 17, weight: .semibold))
                                    .foregroundColor(.c13152178)
                                
                                Text("Rate us")
                                    .font(.system(size: 17, weight: .regular))
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity)
                                
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 17, weight: .semibold))
                                    .foregroundColor(.c158158158)
                            }
                            .padding(.horizontal, 16)
                            .frame(height: 44)
                            .background(Color.white)
                            .clipShape(.rect(cornerRadius: 10))
                        }
                        .padding(.horizontal, 16)
                    }
                    .padding(EdgeInsets(top: 26, leading: 16, bottom: 0, trailing: 16))
                }
                .frame(maxHeight: .infinity, alignment: .top)
            }
        }
    }
    
    func actionSheet() {
        guard let urlShare = URL(string: "https://apps.apple.com/us/app/sweet-goals-tracker/id6739846551")  else { return }
        let activityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
        if #available(iOS 15.0, *) {
            UIApplication
            .shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }?.rootViewController?
            .present(activityVC, animated: true, completion: nil)
        } else {
            UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(Source())
}

extension SKStoreReviewController {
    public static func requestReviewInCurrentScene() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            DispatchQueue.main.async {
                requestReview(in: scene)
            }
        }
    }
}

import SwiftUI

extension UIApplication {
    var keyWindow: UIWindow? {
        connectedScenes
            .compactMap {
                $0 as? UIWindowScene
            }
            .flatMap {
                $0.windows
            }
            .first {
                $0.isKeyWindow
            }
    }
}

private struct SafeAreaInsetsKey: EnvironmentKey {
    static var defaultValue: EdgeInsets {
        UIApplication.shared.keyWindow?.safeAreaInsets.swiftUiInsets ?? EdgeInsets()
    }
}

extension EnvironmentValues {
    var safeAreaInsets: EdgeInsets {
        self[SafeAreaInsetsKey.self]
    }
}

private extension UIEdgeInsets {
    var swiftUiInsets: EdgeInsets {
        EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}
