import 'package:ayurvedic/core/utlis/media_query_helper.dart';
import 'package:flutter/widgets.dart';

class AppSpacing {
  AppSpacing._();

  // SIZEDBOX - HEIGHT
  static SizedBox h4() => SizedBox(height: 4);
  static SizedBox h8() => SizedBox(height: 8);
  static SizedBox h12() => SizedBox(height: 12);
  static SizedBox h16() => SizedBox(height: 16);
  static SizedBox h20() => SizedBox(height: 20);
  static SizedBox h24() => SizedBox(height: 24);
  static SizedBox h32() => SizedBox(height: 32);
  static SizedBox hMq(BuildContext context, double percent) =>
      SizedBox(height: MQ.h(context, percent));

  // SIZEDBOX - WIDTH
  static SizedBox w4() => SizedBox(width: 4);
  static SizedBox w8() => SizedBox(width: 8);
  static SizedBox w12() => SizedBox(width: 12);
  static SizedBox w16() => SizedBox(width: 16);
  static SizedBox w20() => SizedBox(width: 20);
  static SizedBox w24() => SizedBox(width: 24);
  static SizedBox w32() => SizedBox(width: 32);
  static SizedBox wMq(BuildContext context, double percent) =>
      SizedBox(width: MQ.h(context, percent));
}

class AppPadding {
  const AppPadding._();

  // All sides
  static const p4 = EdgeInsets.all(4);
  static const p6 = EdgeInsets.all(6);
  static const p8 = EdgeInsets.all(8);
  static const p12 = EdgeInsets.all(12);
  static const p14 = EdgeInsets.all(14);
  static const p16 = EdgeInsets.all(16);
  static const p18 = EdgeInsets.all(18);
  static const p20 = EdgeInsets.all(20);
  static const p24 = EdgeInsets.all(24);
  static const p32 = EdgeInsets.all(32);

  // Horizontal
  static const h8 = EdgeInsets.symmetric(horizontal: 8);
  static const h12 = EdgeInsets.symmetric(horizontal: 12);
  static const h14 = EdgeInsets.symmetric(horizontal: 14);
  static const h16 = EdgeInsets.symmetric(horizontal: 16);
  static const h24 = EdgeInsets.symmetric(horizontal: 24);

  // Vertical
  static const v8 = EdgeInsets.symmetric(vertical: 8);
  static const v12 = EdgeInsets.symmetric(vertical: 12);
  static const v14 = EdgeInsets.symmetric(vertical: 14);
  static const v16 = EdgeInsets.symmetric(vertical: 16);
  static const v24 = EdgeInsets.symmetric(vertical: 24);

  // Horizontal + Vertical
  static EdgeInsets hv(double h, double v) =>
      EdgeInsets.symmetric(horizontal: h, vertical: v);

  // Only
  static EdgeInsets only({
    double left = 0,
    double right = 0,
    double top = 0,
    double bottom = 0,
  }) => EdgeInsets.only(left: left, right: right, top: top, bottom: bottom);
}

class AppRadius {
  AppRadius._();

  // RADIUS
  static Radius r3() => Radius.circular(3);
  static Radius r6() => Radius.circular(6);
  static Radius r8() => Radius.circular(8);
  static Radius r12() => Radius.circular(12);
  static Radius r16() => Radius.circular(16);
  static Radius r24() => Radius.circular(24);
  static Radius rFull() => Radius.circular(999);

  // BORDER RADIUS
  static BorderRadius br3() => BorderRadius.all(Radius.circular(3));
  static BorderRadius br6() => BorderRadius.all(Radius.circular(6));
  static BorderRadius br8() => BorderRadius.all(Radius.circular(8));
  static BorderRadius br12() => BorderRadius.all(Radius.circular(12));
  static BorderRadius br16() => BorderRadius.all(Radius.circular(16));
  static BorderRadius br24() => BorderRadius.all(Radius.circular(24));
  static BorderRadius brFull() => BorderRadius.all(Radius.circular(999));
}

class AppSizes {
  AppSizes._();

  // SIZES
  static double s4() => 4;
  static double s8() => 8;
  static double s12() => 12;
  static double s16() => 16;
  static double s20() => 20;
  static double s24() => 24;
  static double s32() => 32;
}

class FontScale {
  static double scale(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width < 360) return 0.9;
    if (width < 600) return 1.0;
    if (width < 900) return 1.1;
    return 1.2; // large screens
  }
}

class HeightScale {
  static double button(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    if (h < 600) return 44;
    if (h < 800) return 48;
    if (h < 1000) return 52;
    return 56;
  }
}
