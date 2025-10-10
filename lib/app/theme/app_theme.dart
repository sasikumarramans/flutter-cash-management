import 'package:ev_flutter_app/generated/fonts.gen.dart';
import 'package:ev_flutter_app/presentation/component/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

/// A class that defines the theme and styles for the application.
class AppTheme {
  //* -------------------- Color Palette -------------------- */
  static const Color primaryColor = Color(0xFF1A1A1A);
  static const Color secondaryColor = Colors.white;
  static const Color tertiaryColor = Color(0xFF40A1FB);
  static const Color buttonCompleted = Color(0xFF40A1FB);
  static const Color labelTextColor = Color(0xFFB0B0B0);
  static const Color createProfileSaveTextColor = Color(0xFF454545);
  static const Color loginButtonTextColor = primaryColor;
  static const Color loginButtonBackgroundColor = buttonCompleted;

  static const Color fabricTextColor = Color(0xFFFF9F0A);

  //* -------------------- Label Colors -------------------- */
  static const Color primaryLabelColor = Color(0xFFFFFFFF);
  static const Color secondaryLabelColor = Color(0x99EBEBF5);
  static const Color tertiaryLabelColor = Color(0x4DEBEBF5);
  static const Color loginBgColor = Color(0xffECFFED);

  //* -------------------- Background Colors -------------------- */

  static const Color primaryBackgroundColor = Color(0xFF000000);
  static const Color secondaryBackgroundColor = Color(0xFF1C1C1E);
  static const Color tertiaryBackgroundColor = Color(0xFF2C2C2E);

  //* -------------------- Text Colors -------------------- */

  static const Color primaryTextColor = Color(0xFFFFFFFF);
  static const Color secondaryTextColor = Color(0x99EBEBF5);
  static const Color tertiaryTextColor = Color(0x4DEBEBF5);
  static const Color quaternaryTextColor = Color(0x29EBEBF5);
  static const Color tabDividerColor = Color(0x808080B2);

  //* -------------------- Gradient Colors -------------------- */

  static const LinearGradient colorfulGradient = LinearGradient(
    begin: Alignment(-0.121, -1.0),
    end: Alignment(1.0, 0.26),
    colors: [
      Color(0xFF40A1FB),
      Color(0xFFAB0DD2),
      Color(0xFFF72585),
    ],
    stops: [0.0, 0.573, 1.0],
  );

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

  //* -------------------- Box Decoration Colors -------------------- */

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

  // Border width default
  static const double defaultBorderWidth = 2.0;

  // Button Colors
  static const Color buttonTextColor = Color(0xFF131314);
  static const Color buttonDisabledColor = Color(0xFF5D5D5D);
  static const Color buttonLoadingColor = Colors.white;
  static const Color buttonFillColor = Colors.white;
  static const Color buttonDisabledFillColor = Colors.black;
  static const Color buttonBorderColor = Color(0xFFB0E0E6);
  static const Color buttonCompletedTextColor = Colors.white;
  static const Color buttonCompletedFillColor = tertiaryColor;

  // TextField Colors
  //*------------------ Text Field Text Colors ------------------ */
  // Text colors
  static const Color textFieldEnabledTextColor = Colors.white;
  static const Color textFieldDisabledTextColor = Color(0xFF5D5D5D);
  static const Color textFieldCompletedTextColor = Colors.green;

  // Background colors
  static const Color textFieldFilledEnabledColor = Colors.white;
  static const Color textFieldFilledDisabledColor = Color(0xFFBDBDBD);
  static const Color textFieldFilledCompletedColor = Color(0xFF4CAF50);

  static const Color textFieldOutlinedEnabledColor = Colors.white;
  static const Color textFieldOutlinedDisabledColor = Color(0xFFE0E0E0);
  static const Color textFieldOutlinedCompletedColor = Color(0xFF388E3C);

  static const Color textFieldUnderlinedEnabledColor = Colors.transparent;
  static const Color textFieldUnderlinedDisabledColor = Color(0xFFB0BEC5);
  static const Color textFieldUnderlinedCompletedColor = Colors.green;

  // Border colors for each text field type and state
  static const Color textFieldOutlinedEnabledBorderColor = Colors.grey;
  static const Color textFieldOutlinedDisabledBorderColor = Color(0xFF757575);
  static const Color textFieldOutlinedCompletedBorderColor = Colors.green;

  static const Color textFieldUnderlinedEnabledBorderColor = Colors.grey;
  static const Color textFieldUnderlinedDisabledBorderColor = Color(0xFF757575);
  static const Color textFieldUnderlinedCompletedBorderColor = Colors.green;

  // Font size and weight
  static const double textFieldFontSize = 16.0;
  static const FontWeight textFieldFontWeight = FontWeight.w400;

  // OTP Colors
  static const Color otpTextEnabledColor = Colors.white;
  static const Color otpDefaultBorderColor = Color(0xFF3D3D3D);
  static const Color otpFocusedBorderColor = Color(0xFF40A1FB);
  static const Color otpErrorBorderColor = Color(0xFF8A2A2A);
  static const Color otpErrorTextColor = Color(0xFFC84040);

  // OTP Background Colors
  static const Color otpDefaultBackgroundColor = Color(0xFF272727);
  static const Color otpFocusedBackgroundColor = Color(0xFF272727);
  static const Color otpSubmittedBackgroundColor = Color(0xFF272727);
  static const Color otpErrorBackgroundColor = Color(0x4DFF3737);
  static const Color otpResendDisabledBackgroundColor = Color(0xFF272727);

  // Dashboard Colors
  static const Color dashboardBottomBarBackgroundColor = Color(0xFF131314);

  static const Color dashboardBottomBarUnselectedIconColor = Color(0x80FFFFFF);
  static const Color dashboardBottomBarSelectedIconColor = Color(0xFFDA328D);
  static const Color dashboardBottomBarDisabledIconColor = Colors.grey;

  static const Color dashboardBottomBarUnselectedTextColor = Color(0x80FFFFFF);
  static const Color dashboardBottomBarSelectedTextColor = Color(0xFFDA328D);
  static const Color dashboardBottomBarDisabledTextColor = Colors.grey;

  //* -------------------- Home Page Content Info -------------------- */
  static const Color homePageAppBarTitleColor = Colors.white;
  static const Color homePageContentInfoHeadingColor = Colors.white;
  static const Color homePageContentInfohashTagColor = Colors.white;
  static const Color homePageContentInfoButtonEnabledTextColor = Colors.white;
  static const Color homePageContentInfoDurationTextColor = Colors.white;
  static const Color homePageContentInfoButtonEnabledFilledColor =
      Color(0x40131314);
  static const Color homePageContentTopOverlayColor = Color(0xFF100C10);
  static const Color homePageContentBottomOverlayColor = Color(0x00100C10);

  //create profile colors
  static const Color createProfileBackgroundPurpleColor = Color(0xFFAB0DD2);
  static const Color genderInfoTextColor = Color(0xFF888888);
  static const Color userNameHintTextColor = Color(0xFF6D6D6D);

  //medical disclaimer
  static const Color medicalDisclaimerDiverColor = Color(0xFF272727);
  static const Color disclaimerTextColor = Color(0xFFDFDFDF);

  //* -------------------- Settings -------------------- */
  static const Color settingsTitleTextColor = Color(0xFF8E8E93);
  static const Color imageSelectionBackgroundColor = Color(0xFF252525);
  static const Color profileBorderColor = Color(0x4CEBEBF5);

  //* -------------------- Settings -------------------- */
  static const Color mediaDurationText = Color(0xFFF8F7F8);

  //* -------------------- Home Page Mood Dialog -------------------- */
  static const Color homePageMoodDialogHeadingTextColor = Colors.white;
  static const Color homePageMoodDialogMoodsTextColor = Colors.white;
  static const Color homePageMoodDialogMoodsEnabledBorderColor =
      Color(0x33FFFFFF);
  static const Color homePageMoodDialogMoodsCompletedBorderColor =
      Color(0xFF40A1FB);
  static const Color homePageMoodDialogBadgeBorderColor = Color(0xCC131314);
  static const Color homePageMoodDialogBadgeColor = Color(0xFF40A1FB);
  static const Color purple = Color(0xff9D31F5);

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

  //* -------------------- Welcome Video Overlay Styles -------------------- */
  static BoxDecoration get welcomeVideoOverlay => const BoxDecoration(
        color: Color(0x95131314),
      );

  static BoxDecoration get welcomeVideoOverlaySemi => const BoxDecoration(
        color: Color(0x80131314),
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

  // Welcome Overlay Text Styles
  static TextStyle get welcomeOverlayText {
    return const TextStyle(
      fontFamily: 'Causten',
      fontWeight: FontWeight.w600,
      fontSize: 48,
      height: 1.25,
      letterSpacing: -0.02,
    );
  }

  static TextStyle get welcomeOverlaySwipeUpText => _baseTextStyle(
        Colors.white,
        14,
        FontWeight.normal,
      );
  static TextStyle get feedUserNameText => _baseTextStyle(
        Colors.white,
        16,
        FontWeight.w600,
      );
  //* -------------------- Login Text Styles -------------------- */
  static TextStyle get loginButtonText => _baseTextStyle(
        loginButtonTextColor,
        16,
        FontWeight.w500,
      );

  static TextStyle get loginText => _baseTextStyle(
        Colors.white,
        24,
        FontWeight.w500,

      );

  static TextStyle get simpleWhiteTextStyle => _baseTextStyle(
        Colors.white,
        14,
        FontWeight.normal,
      );

  static TextStyle get simpleHintTextStyle => _baseTextStyle(
        const Color(0x4DEBEBF5),
        14,
        FontWeight.normal,
      );

  static TextStyle get loginEmailHint => _baseTextStyle(
        labelTextColor,
        16,
        FontWeight.normal,
      );

  static TextStyle get loginEmailValue => loginEmailHint.copyWith(
        color: Colors.white,
      );

  static TextStyle get loginSignInOrCreateAnAccountText => _baseTextStyle(
        Colors.white,
        24,
        FontWeight.w500,
      );

  static TextStyle get loginTermsAndConditions => _baseTextStyle(
        labelTextColor,
        12,
        FontWeight.w400,
      );

  //* -------------------- OTP Text Styles -------------------- */
  static TextStyle get otpCheckYourEmail => loginSignInOrCreateAnAccountText;

  static TextStyle get otpEnterTheCode => _baseTextStyle(
        labelTextColor,
        14,
        FontWeight.w500,
      );

  static TextStyle get otpResend => otpEnterTheCode.copyWith(
        color: otpTextEnabledColor,
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
      Radius.circular(30),
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
      Radius.circular(30),
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
    borderRadius: BorderRadius.circular(30),
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

  static BoxDecoration _signOutButtonDecoration(
    Color color, {
    Border? border,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10),
      border: border,
    );
  }

  static BoxDecoration _fabricCreationDecoration(
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

  //* -------------------- Dashboard -------------------- */

  static TextStyle dashboardBottomBarUnselectedTextStyle = _baseTextStyle(
    dashboardBottomBarUnselectedTextColor,
    12,
    FontWeight.w400,
  );

  static TextStyle dashboardBottomBarSelectedTextStyle = _baseTextStyle(
    dashboardBottomBarSelectedTextColor,
    12,
    FontWeight.w400,
  );

  static TextStyle dashboardBottomBarDisabledTextStyle = _baseTextStyle(
    dashboardBottomBarDisabledTextColor,
    10,
    FontWeight.w400,
  );

  //* -------------------- HomePageContentInfo -------------------- */

  static TextStyle homePageAppBarTitleTextStyle = _baseTextStyle(
    homePageAppBarTitleColor,
    16,
    FontWeight.w400,
  );

  static TextStyle homePageContentInfoHeaderTextStyle = _baseTextStyle(
    homePageContentInfoHeadingColor,
    30,
    FontWeight.w400,
  );

  static TextStyle homePageContentInfoHashtagTextStyle = _baseTextStyle(
    homePageContentInfohashTagColor,
    14,
    FontWeight.w400,
  );

  static TextStyle homePageContentInfoButtonEnabledTextStyle = _baseTextStyle(
    homePageContentInfoButtonEnabledTextColor,
    12,
    FontWeight.w400,
  );

  static TextStyle homePageContentInfoDurationTextStyle = _baseTextStyle(
    homePageContentInfoDurationTextColor,
    14,
    FontWeight.w400,
  );

  //* -------------------- Home Page Mood Dialog -------------------- */

  static TextStyle homePageMoodDialogHeadingTextStyle = _baseTextStyle(
    Colors.white,
    20,
    FontWeight.w400,
  );

  static TextStyle homePageMoodDialogMoodsTextStyle = _baseTextStyle(
    homePageMoodDialogMoodsTextColor,
    14,
    FontWeight.w400,
  );

  static TextStyle homePageMoodDialogSearchHintTextStyle = _baseTextStyle(
    const Color(0x59FFFFFF),
    24,
    FontWeight.w400,
  );

  static TextStyle homePageMoodDialogSearchTextStyle =
      homePageMoodDialogSearchHintTextStyle.copyWith(
    color: Colors.white,
  );

  static InputDecoration homePageMoodDialogFeelDecorationEnabledStyle =
      getTextFieldInputDecoration(
    type: TextFieldStyle.underlined,
    backgroundColor: Colors.transparent,
    borderColor: const Color(0x66FFFFFF),
  );
  static InputDecoration homePageMoodDialogFeelDecorationfocusedStyle =
      getTextFieldInputDecoration(
    type: TextFieldStyle.underlined,
    backgroundColor: Colors.transparent,
    borderColor: const Color(0x66FFFFFF),
  );
  static InputDecoration homePageMoodDialogFeelDecorationDisabledStyle =
      getTextFieldInputDecoration(
    type: TextFieldStyle.underlined,
    backgroundColor: Colors.transparent,
    borderColor: const Color(0x66FFFFFF),
  );

  static TextStyle homePageMoodDialogFeelDecorationEnabledTextStyle =
      homePageMoodDialogHeadingTextStyle;
  static TextStyle homePageMoodDialogFeelDecorationFocusedTextStyle =
      homePageMoodDialogHeadingTextStyle;
  static TextStyle homePageMoodDialogFeelDecorationDisabledTextStyle =
      homePageMoodDialogHeadingTextStyle;

  //create profile
  static TextStyle get genderInfoTextView => _baseTextStyle(
        genderInfoTextColor,
        14,
        FontWeight.w400,
      );

  static BoxDecoration get createProfileButtonEnabledFilled =>
      _buttonDecoration(
        const Color(0xff2C2C2E),
      );
  static BoxDecoration get signoutEnabledFilled => _signOutButtonDecoration(
        Colors.black,
      );

  static BoxDecoration get signoutBtnFilled => _signOutButtonDecoration(
        const Color(0xff2C2C2E),
      );
  static BoxDecoration get followingBtnFilled => _fabricCreationDecoration(
        const Color(0xff2C2C2E),
      );
  static BoxDecoration get fabricCreationFilled => _fabricCreationDecoration(
        const Color(0xff2C2C2E),
      );

  static BoxDecoration get endCardButtonEnabledFilled =>
      _signOutButtonDecoration(
        Colors.white,
      );

  static TextStyle get userNameText => _baseTextStyle(
        Colors.white,
        25,
        FontWeight.w500,
      );

  static BoxDecoration get genderButtonEnabledOutlined =>
      _buttonDecoration(buttonTextColor,
          border: Border.all(color: homePageMoodDialogBadgeColor, width: 1.9));

  static BoxDecoration get genderButtonDisabledOutlined =>
      _buttonDecoration(buttonTextColor,
          border: Border.all(color: createProfileSaveTextColor, width: 1.9));

  static TextStyle get genderText => _baseTextStyle(
        Colors.white,
        15,
        FontWeight.w500,
      );

  // disclaimer
  static TextStyle get disclaimerHeaderText => _baseTextStyle(
        Colors.white,
        16,
        FontWeight.w500,
      );

  static TextStyle get disclaimerText => _baseTextStyle(
        disclaimerTextColor,
        14,
        FontWeight.w400,
      );
  static TextStyle get deleteConfirmationDialogHeader => _baseTextStyle(
        Colors.white,
        20,
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

  static BoxDecoration promptBoxDecoration = BoxDecoration(
    color: const Color(0Xff1A1A1A),
    border: Border.all(
      color: const Color(0x1A2F2B43),
      width: 1,
    ),
    borderRadius: BorderRadius.circular(30),
  );

  static InputDecoration promptInputDecorationEnabledStyle = getInputDecoration(
    state: TextFieldState.enabled,
    style: TextFieldStyle.outlined,
    fillColor: const Color(0xFF1A1A1A),
    borderColor: const Color(0xFF3D3D3D),
    borderRadius: BorderRadius.circular(30),
  );
  static InputDecoration promptInputDecorationFocusedStyle = getInputDecoration(
    state: TextFieldState.focused,
    style: TextFieldStyle.outlined,
    fillColor: const Color(0xFF1A1A1A),
    borderColor: const Color(0xFF3D3D3D),
  );
  static InputDecoration promptInputDecorationDisabledStyle =
      getInputDecoration(
    state: TextFieldState.disabled,
    style: TextFieldStyle.outlined,
    fillColor: const Color(0xFF1A1A1A),
    borderColor: const Color(0xFF3D3D3D),
  );
//* -------------------- Profile -------------------- */
  static TextStyle get profileAddText => _baseTextStyle(
        userNameHintTextColor,
        14,
        FontWeight.w400,
      );
  static TextStyle get profileUserNameText => _baseTextStyle(
        Colors.white,
        16,
        FontWeight.w600,
      );
//* -------------------- Settings -------------------- */
  static TextStyle get settingsHeaderText => _baseTextStyle(
        settingsTitleTextColor,
        12,
        FontWeight.w500,
      );
  static TextStyle get settingInfoText => _baseTextStyle(
        genderInfoTextColor,
        14,
        FontWeight.w500,
      );
  static TextStyle get settingsTitleText => _baseTextStyle(
        Colors.white,
        16,
        FontWeight.w400,
      );
  static InputDecoration emailFieldEnabled = getInputDecoration(
      style: TextFieldStyle.filled,
      state: TextFieldState.focused,
      borderColor: const Color(0xFF6D6D6D),
      filled: true,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
      borderRadius: const BorderRadius.all(
        Radius.circular(30),
      ),
      hintStyle:
          AppTheme.profileAddText.copyWith(color: AppTheme.labelTextColor),
      borderWidth: 0.7);
  static InputDecoration updateProfileFieldEnabled = getInputDecoration(
      style: TextFieldStyle.filled,
      state: TextFieldState.focused,
      fillColor: const Color.fromRGBO(39, 39, 39, 0.60),
      borderColor: const Color(0xFF6D6D6D),
      filled: true,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
      borderRadius: const BorderRadius.all(
        Radius.circular(30),
      ),
      hintStyle:
          AppTheme.profileAddText.copyWith(color: AppTheme.labelTextColor),
      borderWidth: 0.7);
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
  static TextStyle get imageSelectionDialogText => _baseTextStyle(
        Colors.white,
        20,
        FontWeight.w500,
      );
//* -------------------- favorites -------------------- */

  static TextStyle favoriteCountText = _baseTextStyle(
    buttonDisabledColor,
    12,
    FontWeight.w400,
  );
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
  static TextStyle get mediaScreenDurationText => _baseTextStyle(
        mediaDurationText,
        14,
        FontWeight.w400,
      );

  /*--------------------- DropDown Theme ------------------------*/

  static Color dropdownBackgroundColor = Colors.black;

  static Color dropdownBorderColor = Colors.white;
  static double dropdownBorderWidth = 1.0;
  static double dropdownBorderRadius = 30.0;
  static Color dropdownTextColor = Colors.white;
  static TextStyle dropdownTextStyle = simpleWhiteTextStyle.copyWith(
    fontSize: 16,
  );

  static Curve animationCurve = Curves.easeInOut;
  static const Duration animationDuration = Duration(milliseconds: 300);

  static Offset dropdownOffset = const Offset(-50, 10);

  static ButtonStyle dropdownButtonStyle = ButtonStyle(
    foregroundColor: WidgetStatePropertyAll(dropdownTextColor),
    textStyle: WidgetStatePropertyAll(dropdownTextStyle),
  );

  static MenuStyle dropdownMenuStyle = MenuStyle(
    backgroundColor: WidgetStatePropertyAll(dropdownBackgroundColor),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(dropdownBorderRadius),
        side: BorderSide(
          color: dropdownBorderColor,
          width: dropdownBorderWidth,
        ),
      ),
    ),
  );

//* -------------------- Open feedback Dialog -------------------- */
  static TextStyle get openFeedbackText => _baseTextStyle(
        genderInfoTextColor,
        14,
        FontWeight.w400,
      );
  static BoxDecoration get openFeedbackButtonDisabledFilled =>
      _buttonDecoration(
        primaryBackgroundColor,
      );
  static TextStyle get openFeedbackButtonDisabledText => _baseTextStyle(
        createProfileSaveTextColor,
        16,
        FontWeight.w500,
      );
  static BoxDecoration get openFeedbackButtonFilled => _buttonDecoration(
        otpFocusedBorderColor,
      );
  static TextStyle get openFeedbackStyle => _baseTextStyle(
        Colors.black,
        14,
        FontWeight.w600,
      );
  //* -------------------- likes -------------------- */

  static TextStyle get likeCountText => _baseTextStyle(
        Colors.white,
        12,
        FontWeight.w400,
      );
  static TextStyle get settingTitleStyle => _baseTextStyle(
        Colors.white,
        18,
        FontWeight.w500,
      );

  static TextStyle get userContentTextStyle => _baseTextStyle(
        Colors.white,
        16,
        FontWeight.w600,
      );
  static TextStyle get dialogTitleTextStyle => _baseTextStyle(
        Colors.white,
        18,
        FontWeight.w500,
      );
  static TextStyle get dialogBodyStyle => _baseTextStyle(
        Colors.white,
        16,
        FontWeight.w500,
      );
  //* -------------------- my fabrics -------------------- */

  static TextStyle get fabricTitleStyle => _baseTextStyle(
        Colors.white,
        12,
        FontWeight.w500,
      );
  static TextStyle get myFabricTextStyle => _baseTextStyle(
        Colors.white,
        20,
        FontWeight.w600,
      );
  static TextStyle get moderateTextStyle => _baseTextStyle(
        otpErrorTextColor,
        12,
        FontWeight.w500,
      );
  static TextStyle get profileSetupTextStyle => _baseTextStyle(
        Colors.white,
        18,
        FontWeight.w400,
      );
  static TextStyle get reportTitleStyle => _baseTextStyle(
        Colors.white,
        15,
        FontWeight.w500,
      );
  static TextStyle get creditTextStyle => _baseTextStyle(
        AppTheme.noCreditTextColor.withValues(alpha: 0.6),
        20,
        FontWeight.w600,
      );
  /*create fabric*/
  static TextStyle get fabricSelectionTitleStyle => _baseTextStyle(
        Colors.white,
        38,
        FontWeight.w800,
      );
  static TextStyle get createFabricToolTipTextStyle => _baseTextStyle(
        Colors.white,
        16,
        FontWeight.w500,
      );

  static TextStyle get profileVisibilityTextStyle => _baseTextStyle(
        Colors.white,
        20,
        FontWeight.w600,
      );
  static TextStyle get profileVisibilityHintTextStyle => _baseTextStyle(
        genderInfoTextColor,
        17,
        FontWeight.w400,
      );
  static TextStyle get profileUserNameTextStyle => _baseTextStyle(
        Colors.white,
        20,
        FontWeight.w600,
      );
  static TextStyle get profileLikesTextStyle => _baseTextStyle(
        Colors.white,
        16,
        FontWeight.w500,
      );
  static TextStyle get fabricDetailsTextStyle => _baseTextStyle(
        const Color(0x99EBEBF5),
        11,
        FontWeight.w300,
      );
}
