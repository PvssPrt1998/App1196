import SwiftUI

struct PriceView: View {
    
    @EnvironmentObject var source: Source
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.c226226226.ignoresSafeArea()
                
                Color.c0171244
                    .frame(height: safeAreaInsets.top)
                .frame(maxHeight: .infinity, alignment: .top)
                .ignoresSafeArea(.container, edges: .top)
                
                VStack(spacing: 0) {
                    Text("Price")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 3, leading: 16, bottom: 8, trailing: 16))
                        .frame(maxWidth: .infinity)
                        .background(Color.c0171244)
                    
                    if source.prices.isEmpty {
                        emptyView
                    } else {
                        ScrollView(.vertical) {
                            LazyVStack(spacing: 15) {
                                ForEach(0..<source.prices.count, id: \.self) { index in
                                    NavigationLink {
                                        EditPrice(price: source.prices[index])
                                    } label: {
                                        PriceCard(price: source.prices[index])
                                    }
                                }
                            }
                            .padding(EdgeInsets(top: 26, leading: 16, bottom: 80, trailing: 16))
                        }
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
                
                NavigationLink {
                    AddPrice()
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.c0171244)
                        .clipShape(.rect(cornerRadius: 12))
                }
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 15, trailing: 16))
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
    }
    
    private var emptyView: some View {
        VStack(spacing: 0) {
            Text("It would be great to\ncalculate the cost\nof goods")
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(.c085122)
                .multilineTextAlignment(.center)
                .padding(.trailing, 100)
            Image("priceImage1")
                .resizable()
                .scaledToFit()
                .frame(width: 190)
        }
        .padding(EdgeInsets(top: 96, leading: 16, bottom: 80, trailing: 16))
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
}

#Preview {
    PriceView()
        .environmentObject(Source())
}
