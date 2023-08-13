import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

Future<void> initialize()async{
  const keyApplicationId = 'r1rdqzz2BmLpJpDx7DmBXZGhKoAzrdhK4TQZaAvF';
  const keyClientKey = 'bfjgKLl2rqoxSB1abReGCGh9oRLY70SA3FKEVVSs';
  const keyParseServerUrl = 'https://parseapi.back4app.com';
  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);
}