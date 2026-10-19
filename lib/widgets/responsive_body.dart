import 'package:flutter/material.dart';

import '../core/utils/responsive.dart';

/// Pembungkus body halaman: aman dari notch, dapat di-scroll,
/// dan konten dibatasi lebarnya agar rapi di tablet/web.
class ResponsiveBody extends StatelessWidget {
  final Widget child;

  const ResponsiveBody({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: Responsive.horizontalPadding(context)
                .copyWith(top: 16, bottom: 24),
            child: ConstrainedBox(
              // Agar konten pendek tetap berada di tengah layar
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight - 40,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: Responsive.maxContentWidth,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: child,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
