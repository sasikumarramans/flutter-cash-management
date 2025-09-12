enum Flavor {
  staging,
  demo,
  prod,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.staging:
        return 'EV Test Staging';
      case Flavor.demo:
        return 'EV Test Demo';
      case Flavor.prod:
        return 'EV Test Prod';
      default:
        return 'title';
    }
  }
}
