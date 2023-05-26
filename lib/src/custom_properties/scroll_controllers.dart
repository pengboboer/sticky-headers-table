import 'package:flutter/widgets.dart';

typedef CustomNotificationListener = bool Function({
  required ScrollNotification notification,
  required ScrollController controller,
});

class ScrollControllers {
  ScrollControllers({
    ScrollController? verticalTitleController,
    ScrollController? verticalBodyController,
    ScrollController? horizontalBodyController,
    ScrollController? horizontalTitleController,
  })  : this.verticalTitleController = verticalTitleController ?? ScrollController(),
        this.verticalBodyController = verticalBodyController ?? ScrollController(),
        this.horizontalBodyController = horizontalBodyController ?? ScrollController(),
        this.horizontalTitleController = horizontalTitleController ?? ScrollController();

  final ScrollController verticalTitleController;
  final ScrollController verticalBodyController;

  final ScrollController horizontalBodyController;
  final ScrollController horizontalTitleController;

  CustomNotificationListener? customNotificationListener;

  void dispose() {
    verticalBodyController.dispose();
    verticalTitleController.dispose();

    horizontalBodyController.dispose();
    horizontalTitleController.dispose();
  }
}
