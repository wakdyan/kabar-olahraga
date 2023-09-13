import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class EmptyWidget extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final String subtitle;
  final bool isThreeLine;

  const EmptyWidget({
    super.key,
    this.imageUrl,
    required this.title,
    required this.subtitle,
    this.isThreeLine = false,
  });

  const factory EmptyWidget.withButton({
    Key? key,
    String imageUrl,
    required String title,
    required String subtitle,
    required ButtonStyleButton button,
    bool isThreeLine,
  }) = _EmptyViewWithButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        imageUrl == null
            ? const SizedBox()
            : SvgPicture.asset(
                imageUrl!,
                height: Get.width / 2 - 32,
                width: Get.width / 2 - 32,
              ),
        ListTile(
          isThreeLine: isThreeLine,
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          subtitle: Text(
            subtitle,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}

class _EmptyViewWithButton extends EmptyWidget {
  final ButtonStyleButton button;

  const _EmptyViewWithButton({
    super.key,
    super.imageUrl,
    required super.title,
    required super.subtitle,
    super.isThreeLine,
    required this.button,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        super.build(context),
        Padding(
          padding: EdgeInsets.only(top: isThreeLine ? 0 : 16),
          child: button,
        ),
      ],
    );
  }
}
