import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  const Tag({
    super.key,
    required this.text,
    required this.onTap,
    this.isCancel = false,
  });
  final String text;
  final Function()? onTap;
  final bool isCancel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '#$text',
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(
              width: 4,
            ),
            Icon(
              !isCancel ? Icons.add_circle : Icons.cancel,
              size: 14.0,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
