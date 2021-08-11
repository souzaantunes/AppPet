import 'package:firebase_core/firebase_core.dart';

class AccessToken{

  // FirebaseOptions options = FirebaseOptions.builder()
  //     .setCredentials(GoogleCredentials.getApplicationDefault())
  //     .setDatabaseUrl("https://<DATABASE_NAME>.firebaseio.com/")
  //     .build();

  private static String getAccessToken() {
  GoogleCredentials googleCredentials = GoogleCredentials
      .fromStream(new FileInputStream("service-account.json"))
      .createScoped(Arrays.asList(SCOPES));
  googleCredentials.refreshAccessToken();
  return googleCredentials.getAccessToken().getTokenValue();
}

}