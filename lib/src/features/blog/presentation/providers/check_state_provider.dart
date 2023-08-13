import 'package:flutter_riverpod/flutter_riverpod.dart';

final tabIndex = StateProvider<int?>(
      (ref) => 0,
);

// final stageProvider = StateProvider<String?>(
//       (ref) => StageKeys.splash.name,
// );

// enum StageKeys{
//   login,
//   dashboard,
//   splash
// }