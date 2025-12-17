import 'package:my_test_project/gift.dart';

class GiftRouter {
  static String route(Gift? gift) {
    if (gift == null) return "ERROR";
    if (gift.zone == null || gift.zone!.trim().isEmpty) return "WORKSHOP-HOLD";
    return switch ((gift.fragile, gift.weightKg, gift.zone!)) {
      (true, <= 2.0, _) || (false, <= 10.0, "EU") || (false, <= 10.0, "NA") => "REINDEER-EXPRESS",
      _ => "SLED",
    };
  }
}
