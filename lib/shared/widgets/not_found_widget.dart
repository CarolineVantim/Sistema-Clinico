import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NotFoundCard extends StatelessWidget {
  const NotFoundCard({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(16),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(
              height: MediaQuery.sizeOf(context).height * .33,
              width: double.maxFinite,
              fit: BoxFit.contain,
              'assets/images/shared/not_found.svg',
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 16.0),
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
