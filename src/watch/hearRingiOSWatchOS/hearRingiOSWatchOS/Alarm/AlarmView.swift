//
//  AlarmView.swift
//  hearRingiOSWatchOS
//
//  Created by Ashley Palmer on 2/14/22.
//

import SwiftUI

private class AlarmsViewModel: ObservableObject {
  @Published var alarms: [Alarm] = Alarm.samples
}

struct AlarmView: View {
  @StateObject fileprivate var viewModel = AlarmsViewModel()
  var body: some View {
      NavigationView{
        List(viewModel.alarms) { alarm in
            NavigationLink{
                AlarmEdit(alarm: alarm)
            } label: {
              HStack(alignment: .top) {
                VStack(alignment: .leading) {
                  Text(alarm.alarmTime)
                    .font(.headline)
                  Text(alarm.name)
                    .font(.subheadline)
                }
                Spacer()
              }
            }
        }
        .navigationTitle("Alarms")
      }
}
}

struct AlarmView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmView()
    }
}
