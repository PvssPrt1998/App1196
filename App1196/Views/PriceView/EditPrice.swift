import SwiftUI

struct EditPrice: View {
    
    @EnvironmentObject var source: Source
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    let uuid: UUID
    @State var name: String
    @State var description: String
    @State var date: String
    @State var price: String
    @State var benefit: String
    
    init(price: Price) {
        uuid = price.uuid
        name = price.name
        description = price.description
        date = price.date
        self.price = price.price
        benefit = price.benefit
    }
    
    var body: some View {
        ZStack {
            Color.c242221255.ignoresSafeArea()
            
            Color.c0171244
                .frame(height: safeAreaInsets.top)
            .frame(maxHeight: .infinity, alignment: .top)
            .ignoresSafeArea(.container, edges: .top)
            
            VStack(spacing: 0) {
                HStack {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack(spacing: 3) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.c085122)
                            
                            Text("Back")
                                .font(.system(size: 17, weight: .regular))
                                .foregroundColor(.c085122)
                        }
                        .padding(EdgeInsets(top: 11, leading: 8, bottom: 11, trailing: 8))
                    }
                    Spacer()
                    
                    Button {
                        source.edit(Price(uuid: uuid, name: name, description: description, date: date, price: price, benefit: benefit))
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Done")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(.c085122)
                            .padding(EdgeInsets(top: 11, leading: 8, bottom: 11, trailing: 8))
                    }
                    .opacity(disabled ? 0.5 : 1)
                    .disabled(disabled)
                }
                .frame(height: 44)
                .background(Color.c244244244)
                
                Text("Edit price")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(.c085122)
                    .padding(EdgeInsets(top: 3, leading: 16, bottom: 8, trailing: 16))
                    .frame(maxWidth: .infinity)
                    .background(Color.c244244244)
                
                VStack(spacing: 0) {
                    TextFieldCustom(text: $name, prefix: "Name", placeholder: "Ingredient name")
                    Divider()
                        .padding(.leading, 16)
                    TextFieldCustom(text: $description, prefix: "Description", placeholder: "Product Description")
                    Divider()
                        .padding(.leading, 16)
                    TextFieldCustom(text: $date, prefix: "Date", placeholder: "Date of purchase")
                        .keyboardType(.numberPad)
                        .onChange(of: date, perform: { newValue in
                            dateValidation(newValue)
                        })
                    Divider()
                        .padding(.leading, 16)
                    TextFieldCustom(text: $price, prefix: "Price", placeholder: "Product price")
                    Divider()
                        .padding(.leading, 16)
                    TextFieldCustom(text: $benefit, prefix: "Benefit", placeholder: "Product price benefit")
                }
                .background(Color.white)
                .clipShape(.rect(cornerRadius: 10))
                .padding(EdgeInsets(top: 26, leading: 16, bottom: 0, trailing: 16))
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
    
    private var disabled: Bool {
        name == "" || description == "" || date.count < 10 || price == "" || benefit == ""
    }
    
    private func dateValidation(_ newValue: String) {
        let filtered = newValue.filter { Set("0123456789").contains($0) }
        
        if filtered != "" {
            var filterIterable = filtered.makeIterator()
            var index = 0
            var value = ""
            while let c = filterIterable.next() {
                if index == 0 || index == 1 || index == 3 || index == 5 || index == 6 || index == 7 {
                    value = value + "\(c)"
                }
                if index == 2 || index == 4 {
                    value = value + ".\(c)"
                }
                index += 1
            }
            date = value
        } else  {
            date = ""
        }
    }
}

#Preview {
    EditPrice(price: Price(uuid: UUID(), name: "Name", description: "Description", date: "11.11.1111", price: "150$", benefit: "50$"))
        .environmentObject(Source())
}
