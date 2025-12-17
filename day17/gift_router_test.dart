void main() {
  group('GiftRouter', () {
    test('Null gift', () {
      final result = GiftRouter.route(null);
      expect(result, "ERROR");
    });

    test('Invalid Zone', () {
      var zones = [null, "", " ", "   ", "\t"];
      for (var zone in zones) {
        expect(GiftRouter.route(Gift(1.0, true, zone)), "WORKSHOP-HOLD");
      }
    });

    test('REINDEER-EXPRESS', () {
      var gifts = [
        Gift(2.0, true, "EU"),
        Gift(9.9, false, "EU"),
        Gift(9.9, false, "NA"),
      ];
      for (var gift in gifts) {
        expect(GiftRouter.route(gift), "REINDEER-EXPRESS");
      }
    });

    test('SLED', () {
      var gifts = [
        Gift(2.1, true, "EU"),
        Gift(10.1, false, "EU"),
        Gift(9.9, false, "APAC"),
      ];
      for (var gift in gifts) {
        expect(GiftRouter.route(gift), "SLED");
      }
    });
  });
}
