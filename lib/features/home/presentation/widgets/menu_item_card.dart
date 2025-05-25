import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:sistema_clinico/shared/constants/constants.dart';
import 'package:sistema_clinico/shared/constants/coLORS.dart';

class MenuItemCard extends StatelessWidget {
  const MenuItemCard({
    super.key,
    required this.titulo,
    required this.resourceEnum,
    required this.route,
  });

  final String titulo;
  final ImageResourceEnum resourceEnum;
  final String route;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(route);
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        color: tCardBgColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SvgPicture.asset(
                resourceEnum.path,
                fit: BoxFit.fitWidth,
                // height: 75,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Text(
                titulo,
                style: Theme.of(context).textTheme.bodyLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
