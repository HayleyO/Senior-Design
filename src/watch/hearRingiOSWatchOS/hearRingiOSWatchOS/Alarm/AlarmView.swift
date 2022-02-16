//
//  AlarmView.swift
//  hearRingiOSWatchOS
//
//  Created by Ashley Palmer on 2/14/22.
//

import SwiftUI
import CoreData

/*private class AlarmsViewModel: ObservableObject {
  @Published var alarms: [Alarm] = Alarm.samples
}*/

struct AlarmView: View {
  @FetchRequest(sortDescriptors: []) var alarms: FetchedResults<AlarmEntity>
  @Environment(\.managedObjectContext) var moc
  //@StateObject fileprivate var viewModel = AlarmsViewModel()
  //@State private var alarmsState = alarms
  var body: some View {
      NavigationView{
          //List(viewModel.alarms) { alarm in
          List(alarms) { alarm in
            NavigationLink{
                AlarmEdit(alarm: alarm)
            } label: {
                if (alarm.isEnabled)
                {
                    HStack(alignment: .top) {
                      VStack(alignment: .leading) {
                        Text(alarm.alarmTime ?? "TimeUnknown")
                          .font(.headline)
                        Text(alarm.name ?? "NameUnknown")
                          .font(.subheadline)
                      }
                      Spacer()
                    }
                }
                else {
                    HStack(alignment: .top) {
                      VStack(alignment: .leading) {
                        Text(alarm.alarmTime ?? "TimeUnknown")
                          .font(.headline)
                          .foregroundColor(.secondary)
                        Text(alarm.name ?? "NameUnknown")
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
