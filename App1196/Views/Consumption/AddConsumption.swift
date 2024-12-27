import SwiftUI

struct AddConsumption: View {
    
    @EnvironmentObject var source: Source
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    @State var name = ""
    @State var quantity = ""
    @State var date = ""
    @State var term = ""
    
    var body: some View {
        ZStack {
            Color.c219236255.ignoresSafeArea()
            
            Color.c204120254
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
                                .foregroundColor(.c13152178)
                            
                            Text("Back")
                                .font(.system(size: 17, weight: .regular))
                                .foregroundColor(.c13152178)
                        }
                        .padding(EdgeInsets(top: 11, leading: 8, bottom: 11, trailing: 8))
                    }
                    Spacer()
                    
                    Button {
                        if let quantity = Int(quantity) {
                            source.save(Consumption(uuid: UUID(), quantity: quantity, name: name, date: date, term: term))
                        }
                        
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Done")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(.c13152178)
                            .padding(EdgeInsets(top: 11, leading: 8, bottom: 11, trailing: 8))
                    }
                    .opacity(disabled ? 0.5 : 1)
                    .disabled(disabled)
                }
                .frame(height: 44)
                .background(Color.c244244244)
                
                Text("Consumption")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(.c13152178)
                    .padding(EdgeInsets(top: 3, leading: 16, bottom: 8, trailing: 16))
                    .frame(maxWidth: .infinity)
                    .background(Color.c244244244)
                
                VStack(spacing: 0) {
                    TextFieldCustom(text: $name, prefix: "Name", placeholder: "Ingredient name")
                    Divider()
                        .padding(.leading, 16)
                    TextFieldCustom(text: $quantity, prefix: "Quantity", placeholder: "Number of ingredients")
                        .keyboardType(.numberPad)
                        .onChange(of: quantity, perform: { newValue in
                            quantityValidation(newValue)
                        })
                    Divider()
                        .padding(.leading, 16)
                    TextFieldCustom(text: $date, prefix: "Date", placeholder: "Date of purchase")
                        .keyboardType(.numberPad)
                        .onChange(of: date, perform: { newValue in
                            dateValidation(newValue)
                        })
                    Divider()
                        .padding(.leading, 16)
                    TextFieldCustom(text: $term, prefix: "Term", placeholder: "Best before date")
                        .keyboardType(.numberPad)
                        .onChange(of: term, perform: { newValue in
                            termValidation(newValue)
                        })
                }
                .background(Color.white)
                .clipShape(.rect(cornerRadius: 10))
                .padding(EdgeInsets(top: 26, leading: 16, bottom: 0, trailing: 16))
                
                Image("consumptionImage2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 259)
                    .frame(maxHeight: .infinity, alignment: .bottom)
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
    
    private var disabled: Bool {
        name == "" || quantity == "" || date.count < 10 || term.count < 10
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
    
    private func quantityValidation(_ newValue: String) {
        let filtered = newValue.filter { Set("0123456789").contains($0) }
        
        if filtered != "" {
            quantity = filtered
        } else  {
            quantity = ""
        }
    }
    
    private func termValidation(_ newValue: String) {
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
            term = value
        } else  {
            term = ""
        }
    }
}

#Preview {
    AddConsumption()
        .environmentObject(Source())
}
