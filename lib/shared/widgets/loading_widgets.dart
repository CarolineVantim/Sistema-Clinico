import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 100,
        height: 100,
        child: LoadingIndicator(
          indicatorType: Indicator.ballRotateChase,
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary.withAlpha(150),
            Theme.of(context).colorScheme.primary.withAlpha(125),
            Theme.of(context).colorScheme.primary.withAlpha(100),
            Theme.of(context).colorScheme.primary.withAlpha(75),
            Theme.of(context).colorScheme.primary.withAlpha(50),
            Theme.of(context).colorScheme.primary.withAlpha(25),
          ],
        ),
      ),
    );
  }
}
