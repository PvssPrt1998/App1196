import SwiftUI

struct ConsumptionView: View {
    
    @EnvironmentObject var source: Source
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
                    Text("Consumption")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 3, leading: 16, bottom: 8, trailing: 16))
                        .frame(maxWidth: .infinity)
                        .background(Color.c204120254)
                    
                    if source.consumptions.isEmpty {
                        emptyView
                    } else {
                        ScrollView(.vertical) {
                            LazyVStack(spacing: 15) {
                                ForEach(0..<source.consumptions.count, id: \.self) { index in
                                    NavigationLink {
                                        EditConsumption(consumption: source.consumptions[index])
                                    } label: {
                                        ConsumptionCard(consumption: source.consumptions[index]) {
                                            source.decrementConsumption(index)
                                        } increment: {
                                            source.incrementConsumption(index)
                                        }
                                    }
                                    

                                }
                            }
                            .padding(EdgeInsets(top: 26, leading: 16, bottom: 80, trailing: 16))
                        }
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
                
                NavigationLink {
                    AddConsumption()
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.c174123244)
                        .clipShape(.rect(cornerRadius: 12))
                }
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 15, trailing: 16))
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
    }
    
    private var emptyView: some View {
        HStack(spacing: 0) {
            Image("consumptionImage1")
                .resizable()
                .scaledToFit()
                .frame(width: 168)
            VStack {
                Text("How convenient it would be to calculate ingredients")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.c9242161)
                    .multilineTextAlignment(.center)
                Image("consumptionArrow1")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
            }
        }
        .padding(EdgeInsets(top: 96, leading: 16, bottom: 80, trailing: 16))
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
}

#Preview {
    ConsumptionView()
        .environmentObject(Source())
}
