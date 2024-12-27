import SwiftUI

struct ConsumptionCard: View {

    let consumption: Consumption
    let decrement: () -> Void
    let increment: () -> Void
    
    var body: some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 7) {
                
                Text(consumption.name)
                    .font(.system(size: 22, weight: .regular))
                    .foregroundColor(.white)
                    .frame(width: 190, height: 33)
                    .background(Color.c174123244)
                    .cornerRadius(10, corners: .bottomRight)
                
                HStack(spacing: 6) {
                    Text("Date of purchase: ")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(width: 136)
                    Text(consumption.date)
                        .font(.system(size: 17, weight: .regular))
                        .foregroundColor(.black)
                }
                .padding(.leading, 8)
                   
                HStack(spacing: 6) {
                    Text("Best before date: ")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(width: 136)
                    Text(consumption.term)
                        .font(.system(size: 17, weight: .regular))
                        .foregroundColor(.black)
                }
                .padding(.leading, 8)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 11)
            
            VStack(spacing: 10) {
                Text("\(consumption.quantity) pieces")
                    .font(.system(size: 22, weight: .regular))
                    .foregroundColor(.black)
                
                HStack(spacing: 0) {
                    Button {
                       decrement()
                    } label: {
                        Image(systemName: "minus")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .disabled(consumption.quantity <= 0)
                    .opacity(consumption.quantity <= 0 ? 0.5 : 1)
                    
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.black)
                        .frame(width: 1, height: 18)
                    
                    Button {
                        increment()
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
                .frame(width: 94, height: 32)
                .background(Color.c120120128.opacity(0.12))
                .clipShape(.rect(cornerRadius: 8))
            }
            .padding(.trailing, 8)
        }
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.c174123244, lineWidth: 2)
        )
    }
}

#Preview {
    ConsumptionCard(consumption: Consumption(uuid: UUID(), quantity: 15, name: "Name", date: "11.11.1111", term: "22.22.2222"), decrement: {}, increment: {})
        .padding()
        .background(Color.c226226226)
}

struct RoundedCorner: Shape {
    let radius: CGFloat
    let corners: UIRectCorner

    init(radius: CGFloat = .infinity, corners: UIRectCorner = .allCorners) {
        self.radius = radius
        self.corners = corners
    }

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
    func cornerRadius(_ radius: CGFloat, firstOrLastElement isFirst: Bool?) -> some View {
        guard let isFirst = isFirst else { return cornerRadius(radius, corners: [.allCorners]) }
        if isFirst {
            return cornerRadius(radius, corners: [.topLeft, .topRight])
        } else {
            return cornerRadius(radius, corners: [.bottomLeft, .bottomRight])
        }
    }
}
