import 'package:echo_frontend/common_widgets/responsive_center.dart';
import 'package:echo_frontend/constants/app_sizes.dart';
import 'package:echo_frontend/constants/breakpoints.dart';
import 'package:flutter/material.dart';

/// Scrollable widget that shows a responsive card with a given child widget.
/// Useful for displaying forms and other widgets that need to be scrollable.
class ResponsiveScrollableCard extends StatelessWidget {
  const ResponsiveScrollableCard({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constraints.maxHeight - MediaQuery.of(context).viewInsets.bottom,
            minWidth: constraints.maxWidth,
          ),
          child: ResponsiveCenter(
            maxContentWidth: Breakpoint.tablet,
            child: Padding(
              padding: const EdgeInsets.all(Sizes.p16),
              child: Card(
                color: Colors.transparent,
                shadowColor: Colors.transparent,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
