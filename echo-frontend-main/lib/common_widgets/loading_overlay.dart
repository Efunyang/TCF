import 'package:echo_frontend/constants/app_sizes.dart';
import 'package:echo_frontend/localization/string_hardcoded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({
    super.key,
    this.loadingText,
  });
  final String? loadingText;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Opacity(
          opacity: 0.5,
          child: ModalBarrier(
            dismissible: false,
            color: Colors.black,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitCircle(
              size: 80,
              itemBuilder: (context, index) {
                final colors = [
                  Colors.white,
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                ];
                final color = colors[index % colors.length];
                return DecoratedBox(
                  decoration: BoxDecoration(color: color),
                );
              },
            ),
            gapH16,
            Text(
              loadingText ?? "Loading...".hcd,
              style: const TextStyle(
                fontSize: Sizes.p16,
                color: Colors.white,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
