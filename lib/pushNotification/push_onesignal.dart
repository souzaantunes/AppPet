import 'package:onesignal_flutter/onesignal_flutter.dart';

class PushOnesignal {


  static void config() async {
    //log para verificar se esta funcionando
   await OneSignal.shared.setLogLevel(OSLogLevel.info, OSLogLevel.none);
   //Inicializacao do onesignal
   await OneSignal.shared.setAppId("b5221896-045c-42e9-9155-6d68726f39ab");
    OneSignal.shared.setLocationShared(false);
    permissaoDePush();
    pushDePrimeiroPlano();
  }

  static void permissaoDePush() {
    OneSignal.shared.promptUserForPushNotificationPermission();
    //permissao do ios quando é mudado no prompt
    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
      print('chegou no evento permission oberser $changes');
    });
  }

  static void pushDePrimeiroPlano() {
    //Nota: Quando o aplicativo esta em primeiro plano
   OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      event.complete(event.notification);
      var body = event.notification.body;
      print('chegou no evento foreground $body');
    });
   OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
     print('NOTIFICATION OPENED HANDLER CALLED WITH: ${result}');
   });
  }
}
