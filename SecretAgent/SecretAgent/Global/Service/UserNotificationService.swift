//
//  UserNotificationManager.swift
//  SecretAgent
//
//  Created by taekkim on 2022/11/19.
//

import Foundation
import UserNotifications

struct UserNotificationManager {
    private let center = UNUserNotificationCenter.current()

    func grant(of options: UNAuthorizationOptions = [.alert, .sound, .badge]) {
        center.getNotificationSettings { setting in
            guard setting.authorizationStatus == .notDetermined else { return }

            center.requestAuthorization(options: options) { _, _ in }
        }
    }

    func setOnce(after seconds: TimeInterval, title: String, body: String, uuid: String) {
        let content = UNMutableNotificationContent()

        content.title = title
        content.body = body

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
        let request = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)

        center.add(request)
    }

    func setEvery(at hour: Int, title: String, body: String, uuid: String) {
        let content = UNMutableNotificationContent()

        content.title = title
        content.body = body

        let dateComponents = DateComponents(calendar: Calendar.current, hour: hour)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)

        center.add(request)
    }

    func cancel(at uuid: String) {
        center.removePendingNotificationRequests(withIdentifiers: [uuid])
    }
}
