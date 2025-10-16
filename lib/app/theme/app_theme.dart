import 'package:bearnshare/generated/fonts.gen.dart';
import 'package:bearnshare/presentation/component/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

/// A class that defines the theme and styles for the application.
class AppTheme {
  //* -------------------- Color Palette -------------------- */
  static const Color primaryColor = Color(0xFF1A1A1A);
  static const Color secondaryColor = Colors.white;
  static const Color tertiaryColor = Color(0xFF55B685);
  static const Color amountPosTextColor = Color(0xff4CA054);
  static const Color amountNegTextColor = Color(0xffFF7E78);
  static const Color buttonCompleted = Color(0xFF40A1FB);
  static const Color labelTextColor = Color(0xFFB0B0B0);
  static const Color bottomBarImgColor = Color(0xff9CA6BB);

  static const Color splitBorderLineColor = Color(0xff4C4B4B);

  //* -------------------- Label Colors -------------------- */
  static const Color primaryLabelColor = Color(0xFFFFFFFF);
  static const Color secondaryLabelColor = Color(0x99EBEBF5);
  static const Color tertiaryLabelColor = Color(0x4DEBEBF5);
  static const Color loginBgColor = Color(0xffECFFED);

  //* -------------------- Background Colors -------------------- */

  static const Color primaryBackgroundColor = Color(0xFF000000);
  static const Color reportBtnColor = Color(0xff3366E3);
  static const Color tertiaryBackgroundColor = Color(0xFF2C2C2E);

  //* -------------------- Text Colors -------------------- */

  static const Color addExpenseBtnClr = Color(0xffDD524C);
  static const Color secondaryTextColor = Color(0x99EBEBF5);
  static const Color tertiaryTextColor = Color(0x4DEBEBF5);
  static const Color quaternaryTextColor = Color(0x29EBEBF5);
  static const Color tabDividerColor = Color(0xff303030);
  static const Color reportTabActiveColor = Color(0xff015D41);

  //* -------------------- Gradient Colors -------------------- */

  static const LinearGradient buttonGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF7316D0),
      Color(0xFF8C00E2),
      Color(0xFF5021FB),
    ],
    stops: [0.0, 0.2692, 1.0],
  );

  static const LinearGradient iconButtonGradiant = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF40A1FB),
      Color(0xFFAB0DD2),
      Color(0xFFF72585),
    ],
    stops: [0.0, 0.7, 1.0],
  );

  static const LinearGradient buttonGradientVibrant = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFFAF40FF),
      Color(0xFFC93FFF),
      Color(0xFFC74DFF),
    ],
    stops: [0.0, 0.2692, 1.0],
  );

  // Fill Colors for Filled Buttons
  static const Color boxEnabledFillColor = Color(0xFFECECEC);
  static const Color boxDisabledFillColor = AppTheme.tertiaryBackgroundColor;
  static const Color boxCompletedFillColor = Color(0xFF40A1FB);

// Fill Colors for Outlined Buttons
  static const Color boxEnabledOutlinedFillColor = Colors.transparent;
  static const Color boxDisabledOutlinedFillColor = Colors.transparent;
  static const Color boxCompletedOutlinedFillColor = Colors.transparent;

// Border Colors
  static const Color boxEnabledBorderColor = Color(0x33FFFFFF);
  static const Color boxDisabledBorderColor = Colors.grey;
  static const Color boxCompletedBorderColor = Color(0xFF40A1FB);

  // Button Colors
  static const Color buttonTextColor = Color(0xFF131314);
  static const Color buttonDisabledColor = Color(0xFF5D5D5D);
  static const Color buttonLoadingColor = Colors.white;
  static const Color buttonFillColor = Colors.white;
  static const Color buttonBorderColor = Color(0xFFB0E0E6);
  static const Color buttonCompletedTextColor = Colors.white;
  static const Color buttonCompletedFillColor = tertiaryColor;

  static const FontWeight textFieldFontWeight = FontWeight.w400;

  static const Color otpErrorBorderColor = Color(0xFF8A2A2A);
  static const Color otpErrorTextColor = Color(0xFFC84040);

  //* -------------------- Home Page Content Info -------------------- */
  static const Color homePageAppBarTitleColor = Colors.white;
  static const Color homePageCardBgColor = Color(0xff28272D);
  static const Color homePageSubtitleColor = Color(0xffC0C0C0);
  static const Color homePageContentInfoHeadingColor = Colors.white;
  static const Color homePageContentInfohashTagColor = Colors.white;
  static const Color homePageContentInfoButtonEnabledTextColor = Colors.white;
  static const Color profileTitleTextStyle = Color(0xffB8B8B8);
  static const Color searchTextColor = Color(0xffB2B5C2);
  static const Color homePageContentTopOverlayColor = Color(0xFF100C10);
  static const Color homePageContentBottomOverlayColor = Color(0x00100C10);

  //create profile colors
  static const Color genderInfoTextColor = Color(0xFF888888);

  //* -------------------- Common Styles -------------------- */
  static const Color gentleMessageBackgroundColor = Color(0x1AFFFFFF);
  static const Color gentleMessageTextColor = Colors.white;
  static const Color fabricNameBackgroundColor = Color(0xFF2C2C2E);
  static const Color loginHintTextColor = Color(0xFFA4A4A4);
  static const Color reportBackgroundColor = Color(0xff2C2C2E);
  static const Color noCreditTextColor = Color(0xFFEBEBF5);
  static const Color dialogPositiveTextColor = Color(0xFFFF2D55);

  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(vertical: 16.0);

  static TextStyle get regularPrimaryTextStyle => const TextStyle(
      fontSize: 16, fontWeight: FontWeight.normal, color: primaryColor);

  static TextStyle get gentleMessageTextStyle => _baseTextStyle(
        Colors.white,
        14,
        FontWeight.w400,
      );

  //* -------------------- AppBar Theme -------------------- */
  static const AppBarTheme _appBarTheme = AppBarTheme(
    color: Colors.transparent,
    elevation: 0,
    titleTextStyle: TextStyle(
      fontFamily: FontFamily.causten,
      color: Colors.white,
      fontSize: 18,
    ),
  );

  //* -------------------- Button Themes -------------------- */
  static ElevatedButtonThemeData _buttonTheme(
      Color backgroundColor, Color foregroundColor) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        textStyle: const TextStyle(
          fontFamily: FontFamily.causten,
          color: Colors.white,
        ),
        padding: buttonPadding,
      ),
    );
  }

  static TextButtonThemeData get _textButtonTheme => TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          textStyle: const TextStyle(fontFamily: FontFamily.causten),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: buttonPadding,
        ),
      );

  static OutlinedButtonThemeData get _outlinedButtonTheme =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          side: const BorderSide(color: primaryColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          textStyle: const TextStyle(fontFamily: FontFamily.causten),
        ),
      );

  //* -------------------- Search Bar Theme -------------------- */
  static SearchBarThemeData get _searchBarTheme => SearchBarThemeData(
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(horizontal: 16.0),
        ),
        textStyle: WidgetStateProperty.all<TextStyle>(
          regularPrimaryTextStyle.copyWith(
            color: primaryColor,
            fontFamily: FontFamily.causten,
          ),
        ),
      );

//* -------------------- Feed overLay -------------------- */
  static const double gradientTopStop = 0.8;
  static const double gradientBottomStop = 1.0;
  static Gradient get bottomGradient => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          homePageContentBottomOverlayColor,
          homePageContentTopOverlayColor.withValues(alpha: 0.7),
        ],
        stops: const [gradientTopStop, gradientBottomStop],
      );

  //* -------------------- Login Text Styles -------------------- */

  static TextStyle get loginText => _baseTextStyle(
        Colors.white,
        24,
        FontWeight.w500,
      );
  static TextStyle get bottomBarText => _baseTextStyle(
        Colors.white,
        10,
        FontWeight.w500,
      );
  static TextStyle get simpleWhiteTextStyle => _baseTextStyle(
        Colors.white,
        14,
        FontWeight.normal,
      );

  static TextStyle get loginEmailHint => _baseTextStyle(
        labelTextColor,
        16,
        FontWeight.normal,
      );

  //* -------------------- BoxDecoration Styles -------------------- */
// Enabled - Filled
  static BoxDecoration boxEnabledFilledDecoration({
    Color? backgroundColor,
    BorderRadius? borderRadius,
    BoxShape shape = BoxShape.circle,
  }) {
    return BoxDecoration(
      color: backgroundColor ?? boxEnabledFillColor,
      shape: shape,
    );
  }

// Enabled - Outlined
  static BoxDecoration boxEnabledOutlinedDecoration({
    Color? backgroundColor,
    Color? borderColor,
    double borderWidth = 2,
    BorderRadius? borderRadius,
    BoxShape shape = BoxShape.circle,
  }) {
    return BoxDecoration(
      color: backgroundColor ?? boxEnabledOutlinedFillColor,
      border: Border.all(
          color: borderColor ?? boxEnabledBorderColor, width: borderWidth),
      shape: shape,
    );
  }

// Disabled - Filled
  static BoxDecoration boxDisabledFilledDecoration({
    Color? backgroundColor,
    BorderRadius? borderRadius,
    BoxShape shape = BoxShape.circle,
  }) {
    return BoxDecoration(
      color: backgroundColor ?? boxDisabledFillColor,
      shape: shape,
    );
  }

// Disabled - Outlined
  static BoxDecoration boxDisabledOutlinedDecoration({
    Color? backgroundColor,
    Color? borderColor,
    double borderWidth = 2,
    BorderRadius? borderRadius,
    BoxShape shape = BoxShape.circle,
  }) {
    return BoxDecoration(
      color: backgroundColor ?? boxDisabledOutlinedFillColor,
      border: Border.all(
          color: borderColor ?? boxDisabledBorderColor, width: borderWidth),
      borderRadius: borderRadius ?? BorderRadius.circular(8),
      shape: shape,
    );
  }

// Completed - Filled
  static BoxDecoration boxCompletedFilledDecoration({
    Color? backgroundColor,
    BorderRadius? borderRadius,
    BoxShape shape = BoxShape.circle,
  }) {
    return BoxDecoration(
      color: backgroundColor ?? boxCompletedFillColor,
      shape: shape,
    );
  }

// Completed - Outlined
  static BoxDecoration boxCompletedOutlinedDecoration({
    Color? backgroundColor,
    Color? borderColor,
    double borderWidth = 2,
    BorderRadius? borderRadius,
    BoxShape shape = BoxShape.circle,
  }) {
    return BoxDecoration(
      color: backgroundColor ?? boxCompletedOutlinedFillColor,
      border: Border.all(
          color: borderColor ?? boxCompletedBorderColor, width: borderWidth),
      shape: shape,
    );
  }

  //* Main Function to Generate InputDecoration

  //* Default Colors
  static const Color defaultEnabledFillColor = Colors.white;
  static const Color defaultDisabledFillColor = Colors.grey;
  static const Color defaultFocusedFillColor = Colors.blue;

  static const Color defaultEnabledBorderColor = Color(0x26FFFFFF);
  static const Color defaultDisabledBorderColor = Colors.grey;
  static const Color defaultFocusedBorderColor = Colors.blue;

  static InputDecoration getInputDecoration({
    required TextFieldStyle style,
    required TextFieldState state,
    String? hintText,
    String? labelText,
    Widget? prefixIcon,
    String? prefixText,
    TextStyle? prefixStyle,
    Widget? suffixIcon,
    Color? fillColor,
    Color? borderColor,
    BorderRadius? borderRadius,
    double borderWidth = 2.0,
    bool filled = false,
    TextStyle? hintStyle,
    TextStyle? labelStyle,
    EdgeInsetsGeometry? contentPadding,
  }) {
    // Determine effective colors based on state
    Color effectiveFillColor;
    Color effectiveBorderColor;

    switch (state) {
      case TextFieldState.enabled:
        effectiveFillColor = fillColor ?? defaultEnabledFillColor;
        effectiveBorderColor = borderColor ?? defaultEnabledBorderColor;
        break;
      case TextFieldState.disabled:
        effectiveFillColor = fillColor ?? defaultDisabledFillColor;
        effectiveBorderColor = borderColor ?? defaultDisabledBorderColor;
        break;
      case TextFieldState.focused:
        effectiveFillColor = fillColor ?? defaultFocusedFillColor;
        effectiveBorderColor = borderColor ?? defaultFocusedBorderColor;
        break;
    }

    // Determine border radius
    borderRadius ??= BorderRadius.circular(8.0);

    // Return InputDecoration based on the TextFieldStyle
    switch (style) {
      case TextFieldStyle.filled:
        return InputDecoration(
          hintText: hintText,
          labelText: labelText,
          alignLabelWithHint: true,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          prefixText: prefixText,
          prefixStyle: prefixStyle,
          filled: true,
          fillColor: effectiveFillColor,
          hintStyle: hintStyle,
          labelStyle: labelStyle,
          contentPadding: contentPadding,
          border: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide:
                BorderSide(color: effectiveBorderColor, width: borderWidth),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide:
                BorderSide(color: effectiveBorderColor, width: borderWidth),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide:
                BorderSide(color: effectiveBorderColor, width: borderWidth),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide:
                BorderSide(color: effectiveBorderColor, width: borderWidth),
          ),
        );

      case TextFieldStyle.outlined:
        return InputDecoration(
          hintText: hintText,
          labelText: labelText,
          prefixIcon: prefixIcon,
          prefixText: prefixText,
          prefixStyle: prefixStyle,
          suffixIcon: suffixIcon,
          filled: filled || fillColor != null,
          fillColor: effectiveFillColor,
          hintStyle: hintStyle,
          labelStyle: labelStyle,
          contentPadding: contentPadding,
          border: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide:
                BorderSide(color: effectiveBorderColor, width: borderWidth),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide:
                BorderSide(color: effectiveBorderColor, width: borderWidth),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide:
                BorderSide(color: effectiveBorderColor, width: borderWidth),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide:
                BorderSide(color: effectiveBorderColor, width: borderWidth),
          ),
        );

      case TextFieldStyle.underlined:
        return InputDecoration(
          hintText: hintText,
          labelText: labelText,
          prefixIcon: prefixIcon,
          prefixText: prefixText,
          prefixStyle: prefixStyle,
          suffixIcon: suffixIcon,
          filled: filled || fillColor != null,
          fillColor: effectiveFillColor,
          hintStyle: hintStyle,
          labelStyle: labelStyle,
          contentPadding: contentPadding,
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: effectiveBorderColor,
              width: borderWidth,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: effectiveBorderColor, width: borderWidth),
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: effectiveBorderColor, width: borderWidth),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: effectiveBorderColor, width: borderWidth),
          ),
        );
    }
  }

  static InputDecoration filledEnabled = getInputDecoration(
    style: TextFieldStyle.filled,
    state: TextFieldState.enabled,
    fillColor: const Color(0x99272727),
    borderColor: const Color(0xFF6D6D6D),
    borderWidth: 0.8,
    contentPadding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
    borderRadius: const BorderRadius.all(
      Radius.circular(12),
    ),
    hintStyle: loginEmailHint,
  );

  static InputDecoration filledDisabled = getInputDecoration(
    style: TextFieldStyle.filled,
    state: TextFieldState.disabled,
    fillColor: const Color(0x99272727),
    borderColor: const Color(0xFF6D6D6D),
    contentPadding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
    borderRadius: const BorderRadius.all(
      Radius.circular(12),
    ),
    hintStyle: loginEmailHint,
  );

  static InputDecoration filledFocused = getInputDecoration(
    style: TextFieldStyle.filled,
    state: TextFieldState.focused,
    fillColor: Colors.blue.shade100,
  );

  static InputDecoration outlinedEnabled = getInputDecoration(
    style: TextFieldStyle.outlined,
    state: TextFieldState.enabled,
    borderRadius: BorderRadius.circular(12),
    borderWidth: 1,
  );

  static InputDecoration outlinedDisabled = getInputDecoration(
    style: TextFieldStyle.outlined,
    state: TextFieldState.disabled,
    borderColor: Colors.grey,
    borderRadius: BorderRadius.circular(10),
    borderWidth: 1.5,
  );

  static InputDecoration outlinedFocused = getInputDecoration(
    style: TextFieldStyle.outlined,
    state: TextFieldState.focused,
    borderColor: Colors.deepPurple,
    borderRadius: BorderRadius.circular(10),
    borderWidth: 2.0,
  );

  static InputDecoration underlinedEnabled = getInputDecoration(
    style: TextFieldStyle.underlined,
    state: TextFieldState.enabled,
    borderColor: const Color(0x66FFFFFF),
    borderWidth: 1,
  );

  static InputDecoration underlinedDisabled = getInputDecoration(
    style: TextFieldStyle.underlined,
    state: TextFieldState.disabled,
    borderColor: Colors.grey,
    borderWidth: 1.5,
  );

  static InputDecoration underlinedFocused = getInputDecoration(
    style: TextFieldStyle.underlined,
    state: TextFieldState.focused,
    borderColor: Colors.blue,
    borderWidth: 2.0,
  );

  //* -------------------- Button Style Themes -------------------- */
  static TextStyle get signoutEnabledTheme => _baseTextStyle(
        Colors.white,
        16,
        FontWeight.w600,
      );

  static TextStyle get textEnabledTheme => _baseTextStyle(
        buttonTextColor,
        16,
        FontWeight.w600,
      );

  static TextStyle get textDisabledTheme => textEnabledTheme.copyWith(
        color: tertiaryLabelColor,
      );

  static TextStyle get textLoadingTheme => textEnabledTheme.copyWith(
        color: buttonLoadingColor,
      );

  static TextStyle get textCompletedTheme => textEnabledTheme.copyWith(
        color: buttonCompletedTextColor,
      );

  static BoxDecoration get buttonEnabledFilled => _buttonDecoration(
        buttonFillColor,
      );

  static BoxDecoration get buttonDisabledFilled =>
      buttonEnabledFilled.copyWith(color: tertiaryBackgroundColor);

  static BoxDecoration get buttonLoadingFilled =>
      buttonEnabledFilled.copyWith(color: buttonCompletedFillColor);

  static BoxDecoration get buttonCompletedFilled =>
      buttonEnabledFilled.copyWith(color: buttonCompletedFillColor);

  static BoxDecoration get buttonCompletedFilledFabric => BoxDecoration(
        gradient: buttonGradient,
        borderRadius: BorderRadius.circular(30),
      );

  static BoxDecoration get iconButtonDecoration => BoxDecoration(
        gradient: iconButtonGradiant,
        borderRadius: BorderRadius.circular(30),
      );

  static BoxDecoration get buttonEnabledFilledFabric => BoxDecoration(
        color: tertiaryBackgroundColor,
        borderRadius: BorderRadius.circular(30),
      );

  static BoxDecoration get dialogCompletedFilled => BoxDecoration(
        gradient: buttonGradient,
        borderRadius: BorderRadius.circular(10),
      );

  static const LinearGradient feedButtonGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFF333333), Color(0xFF333333), Color(0xFF333333)],
    stops: [0.0, 0.2692, 1.0],
  );

  static BoxDecoration get feedEnabled => BoxDecoration(
        gradient: feedButtonGradient,
        borderRadius: BorderRadius.circular(30),
      );
  static BoxDecoration get buttonEnabledOutlined => _buttonDecoration(
        Colors.transparent,
        border: Border.all(
          color: buttonBorderColor,
          width: 2.0,
        ),
      );
  static BoxDecoration get buttonDisabledOutlined =>
      buttonEnabledOutlined.copyWith(
        border: Border.all(
          color: buttonDisabledColor,
          width: 2.0,
        ),
      );

  static BoxDecoration get buttonLoadingOutlined =>
      buttonEnabledOutlined.copyWith(
        border: Border.all(
          color: buttonCompletedFillColor,
          width: 2.0,
        ),
      );

  static BoxDecoration get buttonCompletedOutlined =>
      buttonEnabledOutlined.copyWith(
        border: Border.all(
          color: buttonCompletedTextColor,
          width: 2.0,
        ),
      );

  static BoxDecoration _buttonDecoration(
    Color color, {
    Border? border,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(30),
      border: border,
    );
  }

  //* -------------------- Text Field Themes -------------------- */
  // Text styles
  static TextStyle _baseTextStyle(
      Color color, double fontSize, FontWeight fontWeight) {
    return TextStyle(
      fontFamily: FontFamily.causten,
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  static InputDecoration getTextFieldInputDecoration({
    required TextFieldStyle type,
    required Color backgroundColor,
    required Color borderColor,
  }) {
    BorderSide borderSide = BorderSide(color: borderColor);

    OutlineInputBorder outlinedBorder = OutlineInputBorder(
      borderSide: borderSide,
    );
    UnderlineInputBorder underlinedBorder = UnderlineInputBorder(
      borderSide: borderSide,
    );

    return InputDecoration(
      filled: true,
      fillColor: backgroundColor,
      enabledBorder: type == TextFieldStyle.filled
          ? InputBorder.none
          : type == TextFieldStyle.outlined
              ? outlinedBorder
              : underlinedBorder,
      focusedBorder: type == TextFieldStyle.filled
          ? InputBorder.none
          : type == TextFieldStyle.outlined
              ? outlinedBorder
              : underlinedBorder,
      disabledBorder: type == TextFieldStyle.filled
          ? InputBorder.none
          : type == TextFieldStyle.outlined
              ? outlinedBorder
              : underlinedBorder,
    );
  }

  // TextStyle methods for specific combinations with customizable parameters
  static TextStyle getTextFieldTextStyle({
    required TextFieldState state,
    required Color color,
    double fontSize = 16.0,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  //* -------------------- OTP Pin Themes -------------------- */
  static const double otpWidth = 48;
  static const double otpHeight = 48;
  static const double otpBorderWidth = 1.0;
  static const double otpFocusedBorderWidth = 1.5;
  static const double otpErrorBorderWidth = 2.0;
  static const double otpBorderRadius = 12;

  static const TextStyle otpFieldText = TextStyle(
    fontFamily: 'Causten',
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle otpFieldErrorText = TextStyle(
    fontFamily: 'Causten',
    fontSize: 14,
    color: Colors.red,
    fontWeight: FontWeight.w500,
  );

  static final PinTheme otpDefaultPinTheme = PinTheme(
    width: otpWidth,
    height: otpHeight,
    textStyle: otpFieldText,
    decoration: BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(otpBorderRadius),
      border: Border.all(
        color: const Color(0xff2C2C2E),
        width: otpBorderWidth,
      ),
    ),
  );

  static final PinTheme otpFocusedPinTheme = otpDefaultPinTheme.copyWith(
    decoration: otpDefaultPinTheme.decoration?.copyWith(
      color: Colors.transparent,
      border: Border.all(
        color: const Color(0xFF7316D0),
        width: otpFocusedBorderWidth,
      ),
      boxShadow: [
        const BoxShadow(
          color: Colors.transparent,
          spreadRadius: 2,
          blurRadius: 4,
        ),
      ],
    ),
  );

  static final PinTheme otpSubmittedPinTheme = otpDefaultPinTheme.copyWith(
    decoration: otpDefaultPinTheme.decoration?.copyWith(
      color: Colors.transparent,
    ),
  );

  static final PinTheme otpErrorPinTheme = otpDefaultPinTheme.copyWith(
    decoration: otpDefaultPinTheme.decoration?.copyWith(
      color: Colors.transparent,
      border: Border.all(
        color: otpErrorBorderColor,
        width: otpErrorBorderWidth,
      ),
    ),
  );

  //* -------------------- Get Complete Theme -------------------- */
  static ThemeData getTheme() {
    return ThemeData(
      appBarTheme: _appBarTheme,
      scaffoldBackgroundColor: primaryBackgroundColor,
      elevatedButtonTheme: _buttonTheme(buttonCompleted, Colors.white),
      outlinedButtonTheme: _outlinedButtonTheme,
      textButtonTheme: _textButtonTheme,
      searchBarTheme: _searchBarTheme,
      useMaterial3: true,
      fontFamily: FontFamily.causten,
    );
  }

  //* -------------------- HomePageContentInfo -------------------- */

  static TextStyle homePageTitleTextStyle = _baseTextStyle(
    homePageAppBarTitleColor,
    14,
    FontWeight.w500,
  );

  static TextStyle homePageContentHeaderTextStyle = _baseTextStyle(
    homePageContentInfoHeadingColor,
    35,
    FontWeight.w600,
  );

  static TextStyle homePageContentAmntTextStyle = _baseTextStyle(
    homePageContentInfohashTagColor,
    16,
    FontWeight.w700,
  );

  static TextStyle ledgerTitleTextStyle = _baseTextStyle(
    homePageContentInfoButtonEnabledTextColor,
    16,
    FontWeight.w600,
  );

  static TextStyle ledgerSearchTextStyle = _baseTextStyle(
    searchTextColor,
    14,
    FontWeight.w500,
  );
  static TextStyle historyTextStyle = _baseTextStyle(
    homePageContentInfoButtonEnabledTextColor,
    14,
    FontWeight.w500,
  );
  static TextStyle historyAmntTextStyle = _baseTextStyle(
    homePageContentInfoButtonEnabledTextColor,
    14,
    FontWeight.w600,
  );
  static TextStyle profileTextStyle = _baseTextStyle(
    profileTitleTextStyle,
    14,
    FontWeight.w600,
  );
  /*-------------------- Prompt -------------------- */

  static TextStyle promptTextStyle = _baseTextStyle(
    Colors.white,
    16,
    FontWeight.w400,
  );

  static TextStyle promptHintTextStyle = promptTextStyle.copyWith(
    color: const Color(0xFF888888),
  );

//* -------------------- logout dialog -------------------- */

  static TextStyle get dialogTitleStyle => _baseTextStyle(
        Colors.white,
        20,
        FontWeight.w600,
      );
  static TextStyle get dialogMessageStyle => _baseTextStyle(
        genderInfoTextColor,
        14,
        FontWeight.w400,
      );
  static BoxDecoration get logoutButtonEnabledFilled => _buttonDecoration(
        otpErrorTextColor,
      );
  static BoxDecoration get logoutNegativeButtonEnabledFilled =>
      _buttonDecoration(
        Colors.transparent,
      );
//* -------------------- favorites -------------------- */

  static TextStyle get snackBarHeaderText => _baseTextStyle(
        Colors.white,
        14,
        FontWeight.w600,
      );
  static TextStyle get snackBarTitleText => _baseTextStyle(
        Colors.white,
        14,
        FontWeight.w400,
      );
  static TextStyle get snackBarChangeText => _baseTextStyle(
        Colors.white,
        14,
        FontWeight.w500,
      );
}
