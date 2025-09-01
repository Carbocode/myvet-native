//
//  AppDelegate.swift
//  myvet-native
//
//  Created by Ligmab Allz on 11/07/25.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

import UserNotifications

import Firebase
import FirebaseMessaging

#if os(iOS)
class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
        )
        application.registerForRemoteNotifications()
        Messaging.messaging().delegate = self

        return true
    }
    
    // MARK: - FCM Token Helpers

    /// Chiama questo dopo login per rigenerare e inviare il token
    static func generateAndSendFCMToken() {
        Messaging.messaging().deleteToken { error in
            if let error = error {
                print("Errore nell'eliminare il token FCM: \(error)")
            }
            Messaging.messaging().token { token, error in
                if let error = error {
                    print("Errore nella generazione del nuovo token FCM: \(error)")
                } else if let token = token {
                    print("Nuovo token FCM: \(token)")
                    Task {
                        do {
                            _ = try await NotificationAction.create(tokenNotifiche: token)
                        } catch {
                            print("Failed to register notification token: \(error)")
                        }
                    }
                } else {
                    print("Token FCM non disponibile")
                }
            }
        }
    }
    
    /// Chiama questo dopo logout per eliminare il token (e facoltativamente notifica il server)
    static func deleteFCMToken() {
        Messaging.messaging().deleteToken { error in
            if let error = error {
                print("Errore nell'eliminare il token FCM: \(error)")
            } else {
                print("Token FCM eliminato dal device")
                // Se vuoi notificare il backend che il device è deregistrato, fallo qui.
            }
        }
    }
    
    // Delegate FCM token
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("FCM registration token (delegate): \(String(describing: fcmToken))")
        Task {
            do {
                _ = try await NotificationAction.create(tokenNotifiche: fcmToken ?? "")
            } catch {
                print("Failed to register notification token: \(error)")
            }
        }
    }

    // Gestione notifiche foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                               willPresent notification: UNNotification,
                               withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .list, .badge, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                               didReceive response: UNNotificationResponse,
                               withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}
#elseif os(macOS)
class AppDelegate: NSObject, NSApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        FirebaseApp.configure()
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
        )
        NSApplication.shared.registerForRemoteNotifications(matching: [.alert, .badge, .sound])
        Messaging.messaging().delegate = self
    }

    // MARK: - FCM Token Helpers

    /// Chiama questo dopo login per rigenerare e inviare il token
    static func generateAndSendFCMToken() {
        Messaging.messaging().deleteToken { error in
            if let error = error {
                print("Errore nell'eliminare il token FCM: \(error)")
            }
            Messaging.messaging().token { token, error in
                if let error = error {
                    print("Errore nella generazione del nuovo token FCM: \(error)")
                } else if let token = token {
                    print("Nuovo token FCM: \(token)")
                    Task {
                        do {
                            _ = try await NotificationAction.create(tokenNotifiche: token)
                        } catch {
                            print("Failed to register notification token: \(error)")
                        }
                    }
                } else {
                    print("Token FCM non disponibile")
                }
            }
        }
    }
    
    /// Chiama questo dopo logout per eliminare il token (e facoltativamente notifica il server)
    static func deleteFCMToken() {
        Messaging.messaging().deleteToken { error in
            if let error = error {
                print("Errore nell'eliminare il token FCM: \(error)")
            } else {
                print("Token FCM eliminato dal device")
                // Se vuoi notificare il backend che il device è deregistrato, fallo qui.
            }
        }
    }

    // Delegate FCM token
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("FCM registration token (delegate): \(String(describing: fcmToken))")
        Task {
            do {
                _ = try await NotificationAction.create(tokenNotifiche: fcmToken ?? "")
            } catch {
                print("Failed to register notification token: \(error)")
            }
        }
    }

    // Gestione notifiche foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                               willPresent notification: UNNotification,
                               withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .list, .badge, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                               didReceive response: UNNotificationResponse,
                               withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}
#endif

