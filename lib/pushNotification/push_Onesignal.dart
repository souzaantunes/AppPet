import 'package:onesignal_flutter/onesignal_flutter.dart';

class PushOnesignal {

  static void config() async {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    OneSignal.shared.setAppId("b5221896-045c-42e9-9155-6d68726f39ab");

    //Nota: Quando o aplicativo esta em primeiro plano
    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      event.complete(event.notification);
      var body = event.notification.body;
      print('chegou no evento foreground $body');
    });
    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
      // Will be called whenever the permission changes
      // (ie. user taps Allow on the permission prompt in iOS)
      print('chegou no evento permission oberser $changes');
    });

    permissao();
  }

  static void permissao() async {
    OneSignal.shared.promptUserForPushNotificationPermission();

// If you want to know if the user allowed/denied permission,
// the function returns a Future<bool>:
//     bool allowed = await OneSignal.shared.promptUserForPushNotificationPermission();

//    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
// //       print("Accepted permission: $accepted");
//     });
  }
}
