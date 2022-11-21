//
//  UserNotificationManager.swift
//  SecretAgent
//
//  Created by taekkim on 2022/11/19.
//

import Foundation
import UserNotifications

struct UserNotificationManager {
    private var center = UNUserNotificationCenter.current()

    func grant(of options: UNAuthorizationOptions = [.alert, .sound, .badge]) {
        center.getNotificationSettings { setting in
            guard setting.authorizationStatus == .notDetermined else { return }

            center.requestAuthorization(options: options) { _, _ in }
        }
    }

    func setOnce(after seconds: TimeInterval, title: String, body: String) {
        center.getPendingNotificationRequests { requests in
            for request in requests where request.content.title == title {
                center.removePendingNotificationRequests(withIdentifiers: [request.identifier])
            }
            let content = UNMutableNotificationContent()

            content.title = title
            content.body = body

            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
            let uuidString = UUID().uuidString
            let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)

            center.add(request)
            // 추후에 사이렌 중지를 누르는 상황에서 불필요한 알림을 보내지 않기 위해 User Default에 저장해 놓았습니다.
            saveToUserDefaults(of: uuidString)
            removeUserDefaults(of: uuidString, after: seconds + 5)
        }
    }

    func setEvery(at hour: Int, title: String, body: String) {
        center.getPendingNotificationRequests { requests in
            for request in requests where request.content.title == title {
                return
            }
            let content = UNMutableNotificationContent()

            content.title = title
            content.body = body

            let dateComponents = DateComponents(calendar: Calendar.current, hour: hour)
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            let uuidString = UUID().uuidString
            let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)

            center.add(request)
        }
    }

    func cancel(at uuid: String) {
        center.removePendingNotificationRequests(withIdentifiers: [uuid])
    }

    private func saveToUserDefaults(of uuid: String) {
        UserDefaults.standard.set(uuid, forKey: "pendingSirenUUID")
    }

    private func removeUserDefaults(of uuid: String, after seconds: Double) {
        // 15분 이내에 새로운 사이렌이 등록되었으면 삭제하지 않음
        DispatchQueue.global(qos: .background).asyncAfter(deadline: DispatchTime.now() + seconds) {
            if let savedUUID = UserDefaults.standard.string(forKey: "pendingSirenUUID"), savedUUID == uuid {
                UserDefaults.standard.removeObject(forKey: "pendingSirenUUID")
            }
        }
    }
}
