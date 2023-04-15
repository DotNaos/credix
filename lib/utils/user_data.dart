class UserData {
  // random 16bit id
  static int id = 0x7fff & (DateTime.now().millisecondsSinceEpoch >> 16);

  static String name = 'John Doe';

  // Random value between 600 and 1300
  static int points = 600 + (DateTime.now().millisecondsSinceEpoch % 700);

  static int pointsLost = 0;
  static int pointsGained = 0;

  static int violations = 0;
  static int goodBehaviors = 0;

  static void generateRandomData() {
    id = 0x7fff & (DateTime.now().millisecondsSinceEpoch >> 16);
    name = 'John Doe';
    points = 600 + (DateTime.now().millisecondsSinceEpoch % 700);

    // if the points are above 1000 the user will likely have gained some points
    if (points > 1000) {
      pointsGained = 100 + (DateTime.now().millisecondsSinceEpoch % 900);
      pointsLost = points - pointsGained;
    } else {
      pointsLost = 100 + (DateTime.now().millisecondsSinceEpoch % 900);
      pointsGained = points + pointsLost;
    }

    // if the points are above 1000 the user will likely has done a good behavior
    if (points > 1000) {
      goodBehaviors = 1 + (DateTime.now().millisecondsSinceEpoch % 10).floor();
      violations = 0;
    } else {
      violations = 1 + (DateTime.now().millisecondsSinceEpoch % 10).floor();
      goodBehaviors = 0;
    }
  }
}
