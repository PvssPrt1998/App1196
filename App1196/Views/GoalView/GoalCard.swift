import SwiftUI

struct GoalCard: View {
    let goal: Goal
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 8) {
                Text(goal.idea)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.c1188642)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(goal.date)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.c1188642)
            }
            .frame(height: 30)
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            .background(Color.c255249133)
            
            Text(goal.description)
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(.black)
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 14, trailing: 10))
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white)
            
            Text(goal.endDate)
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(.c1188642)
                .frame(maxWidth: .infinity)
                .frame(height: 30)
                .background(Color.c255249133)
        }
        .clipShape(.rect(cornerRadius: 12))
    }
}

#Preview {
    GoalCard(goal: Goal(uuid: UUID(), idea: "Idea", description: "Description", date: "11.11.1111", endDate: "22.22.2222"))
        .padding()
        .background(Color.c226226226)
}
