//
//  AlarmView.swift
//  hearRingiOSWatchOS
//
//  Created by Ashley Palmer on 2/14/22.
//

import SwiftUI

/*private class AlarmsViewModel: ObservableObject {
  @Published var alarms: [Alarm] = Alarm.samples
}*/

struct AlarmView: View {
  //@StateObject fileprivate var viewModel = AlarmsViewModel()
  @State private var alarmsState = alarms
  var body: some View {
      NavigationView{
          //List(viewModel.alarms) { alarm in
          List(alarmsState) { alarm in
            NavigationLink{
                AlarmEdit(alarm: alarm)
            } label: {
                if (alarm.isEnabled)
                {
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
                else {
                    HStack(alignment: .top) {
                      VStack(alignment: .leading) {
                        Text(alarm.alarmTime)
                          .font(.headline)
                          .foregroundColor(.secondary)
                        Text(alarm.name)
                          .font(.subheadline)
                          .foregroundColor(.secondary)
                      }
                      Spacer()
                    }
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
