import 'package:flutter/material.dart';
import 'package:front/colors.dart';

class ProfileCard extends StatelessWidget {
  void Function()? onPressed;
  ProfileCard({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 60,
        height: 60,
        // margin: const EdgeInsets.only(left: defaultPadding),

        decoration: BoxDecoration(
          color: secondaryColor.withOpacity(0.5),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: Colors.white10),
        ),
        child: const Center(
          child: Icon(Icons.menu),
        ),
      ),
    );
  }
}
