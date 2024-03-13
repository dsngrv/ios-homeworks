//
//  LocalNotificationsService.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 05.03.2024.
//

import Foundation
import UserNotifications

final class LocalNotificationsService {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    
    func registerForLatestUpdatesIfPossible() {
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized:
                self.addNotification()
            case .notDetermined:
                self.notificationCenter.requestAuthorization(options: [ .alert, .sound, .provisional, .badge]) { didAllow, error in
                    if didAllow {
                        self.addNotification()
                    }
                }
            default:
                return
            }
        }
    }
    
    func addNotification() {
        
        let identifier = "notification"
        
        let content = UNMutableNotificationContent()
        content.title = NSLocalizedString("hi", comment: "")
        content.body = NSLocalizedString("checkUpdates", comment: "")
        content.sound = .default
        
        let calendar = Calendar.current
        var dateComponents = DateComponents(calendar: calendar, timeZone: TimeZone.current)
        dateComponents.hour = 19
        dateComponents.minute = 00
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        notificationCenter.add(request)
    }
    
    
}
