import 'package:hooks_riverpod/hooks_riverpod.dart';

final radiusZeroProvider = Provider<int>((ref) {
  return 0;
});

final radiusSmallProvider = Provider<int>((ref) {
  return 3;
});

final radiusMeddimProvider = Provider<int>((ref) {
  return 7;
});

final radiusBigProvider = Provider<int>((ref) {
  return 10;
});
