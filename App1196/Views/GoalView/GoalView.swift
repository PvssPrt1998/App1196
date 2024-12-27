import SwiftUI

struct GoalView: View {
    
    @EnvironmentObject var source: Source
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.c226226226.ignoresSafeArea()
                
                Color.c255235125
                    .frame(height: safeAreaInsets.top)
                .frame(maxHeight: .infinity, alignment: .top)
                .ignoresSafeArea(.container, edges: .top)
                
                VStack(spacing: 0) {
                    Text("Goals")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.c19114684)
                        .padding(EdgeInsets(top: 3, leading: 16, bottom: 8, trailing: 16))
                        .frame(maxWidth: .infinity)
                        .background(Color.c255235125)
                    
                    if source.goals.isEmpty {
                        emptyView
                    } else {
                        ScrollView(.vertical) {
                            LazyVStack(spacing: 15) {
                                ForEach(0..<source.goals.count, id: \.self) { index in
                                    NavigationLink {
                                        EditGoal(goal: source.goals[index])
                                    } label: {
                                        GoalCard(goal: source.goals[index])
                                    }
                                }
                            }
                            .padding(EdgeInsets(top: 26, leading: 16, bottom: 80, trailing: 16))
                        }
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
                
                NavigationLink {
                    AddGoal()
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundColor(.c19114684)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.c255249133)
                        .clipShape(.rect(cornerRadius: 12))
                }
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 15, trailing: 16))
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
    }
    
    private var emptyView: some View {
        VStack(spacing: 0) {
            Text("I want to set a\ngoal for myself")
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(.c19114684)
                .multilineTextAlignment(.center)
                .padding(.leading, 120)
            Image("GoalImage1")
                .resizable()
                .scaledToFit()
                .frame(width: 193)
        }
        .padding(EdgeInsets(top: 96, leading: 16, bottom: 80, trailing: 16))
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
}

#Preview {
    GoalView()
        .environmentObject(Source())
}
