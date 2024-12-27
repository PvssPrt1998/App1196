import SwiftUI

struct EditGoal: View {
    
    @EnvironmentObject var source: Source
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    let uuid: UUID
    @State var idea: String
    @State var description: String
    @State var date: String
    @State var endDate: String
    
    init(goal: Goal) {
        uuid = goal.uuid
        idea = goal.idea
        description = goal.description
        date = goal.date
        endDate = goal.endDate
    }
    
    var body: some View {
        ZStack {
            Color.c255250220.ignoresSafeArea()
            
            Color.c255249133
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
                                .foregroundColor(.c19114684)
                            
                            Text("Back")
                                .font(.system(size: 17, weight: .regular))
                                .foregroundColor(.c19114684)
                        }
                        .padding(EdgeInsets(top: 11, leading: 8, bottom: 11, trailing: 8))
                    }
                    Spacer()
                    
                    Button {
                        source.edit(Goal(uuid: uuid, idea: idea, description: description, date: date, endDate: endDate))
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Done")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(.c19114684)
                            .padding(EdgeInsets(top: 11, leading: 8, bottom: 11, trailing: 8))
                    }
                    .opacity(disabled ? 0.5 : 1)
                    .disabled(disabled)
                }
                .frame(height: 44)
                .background(Color.c244244244)
                
                Text("Edit goal")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(.c19114684)
                    .padding(EdgeInsets(top: 3, leading: 16, bottom: 8, trailing: 16))
                    .frame(maxWidth: .infinity)
                    .background(Color.c244244244)
                
                VStack(spacing: 0) {
                    TextFieldCustom(text: $idea, prefix: "Name", placeholder: "Name of the goals")
                    Divider()
                        .padding(.leading, 16)
                    TextFieldCustom(text: $description, prefix: "Description", placeholder: "Description of your goal")
                    Divider()
                        .padding(.leading, 16)
                    TextFieldCustom(text: $date, prefix: "Date", placeholder: "Start date")
                        .keyboardType(.numberPad)
                        .onChange(of: date, perform: { newValue in
                            dateValidation(newValue)
                        })
                    Divider()
                        .padding(.leading, 16)
                    TextFieldCustom(text: $endDate, prefix: "End date", placeholder: "By what do you set your goal?")
                        .keyboardType(.numberPad)
                        .onChange(of: endDate, perform: { newValue in
                            endDateValidation(newValue)
                        })
                }
                .background(Color.white)
                .clipShape(.rect(cornerRadius: 10))
                .padding(EdgeInsets(top: 26, leading: 16, bottom: 0, trailing: 16))
                
                Image("GoalImage2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
    
    private var disabled: Bool {
        idea == "" || description == "" || date.count < 10 || endDate.count < 10
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
    
    private func endDateValidation(_ newValue: String) {
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
            endDate = value
        } else  {
            endDate = ""
        }
    }
}

#Preview {
    EditGoal(goal: Goal(uuid: UUID(), idea: "Idea", description: "Descr", date: "11.11.1111", endDate: "12.12.1212"))
        .environmentObject(Source())
}
