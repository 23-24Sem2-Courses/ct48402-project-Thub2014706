import 'package:flutter/material.dart';

Future<bool?> showConfirmDialog(BuildContext context, String messange) {
  return showDialog(
    context: context, 
    builder: (ctx) => AlertDialog(
      content: Text(messange, style: const TextStyle(fontSize: 18),),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: ActionButton(
                actionText: 'Huỷ',
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                }
              )
            ),
            Expanded(
              child: ActionButton(
                actionText: 'Đồng ý',
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                }
              )
            )
          ],
        )
      ],
    )
  );
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    this.actionText,
    this.onPressed,
  });

  final String? actionText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed, 
      child: Text(
        actionText ?? 'Okay',
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18
        ),
      )
    );
  }
}