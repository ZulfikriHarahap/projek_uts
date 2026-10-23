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
          // Jarak atas-bawah dihitung dari skala layar, bukan angka tetap
          final vertical = Responsive.scale(context, 16);
          return SingleChildScrollView(
            padding: Responsive.horizontalPadding(context)
                .copyWith(top: vertical, bottom: vertical * 1.5),
            child: ConstrainedBox(
              // Agar konten pendek tetap berada di tengah layar
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight - vertical * 2.5,
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
