import SwiftUI

struct PriceCard: View {
    
    let price: Price
    
    var body: some View {
        VStack(spacing: 0) {
            Text(price.name)
                .font(.system(size: 28, weight: .regular))
                .foregroundColor(.white)
                .padding(EdgeInsets(top: 5, leading: 119, bottom: 0, trailing: 20))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .frame(height: 50)
                .background(Color.c0146209)
                .overlay(
                    Text(price.price)
                        .font(.system(size: 28, weight: .regular))
                        .foregroundColor(.c085122)
                        .frame(width: 111, height: 39)
                        .background(Color.white)
                        .cornerRadius(12, corners: .bottomRight)
                    ,alignment: .topLeading
                )
            Text(price.description)
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(.black)
                .padding(EdgeInsets(top: 10, leading: 15, bottom: 6, trailing: 15))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .frame(height: 54)
            
            HStack(spacing: 8) {
                Text(price.date)
                    .font(.system(size: 20, weight: .regular))
                    .foregroundColor(.c085122)
                    .padding(EdgeInsets(top: 0, leading: 15, bottom: 7, trailing: 0))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(price.benefit)
                    .font(.system(size: 20, weight: .regular))
                    .foregroundColor(.white)
                    .frame(width: 149, height: 39)
                    .background(Color.c0146209)
                    .cornerRadius(12, corners: .topLeft)
            }
            
        }
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 12))
    }
}

#Preview {
    PriceCard(price: Price(uuid: UUID(), name: "Name", description: "Description", date: "11.11.1111", price: "80$", benefit: "50% benefit"))
        .padding()
        .background(Color.c226226226)
}
