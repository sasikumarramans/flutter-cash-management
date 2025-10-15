// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Overall Expenses`
  String get overall_expenses {
    return Intl.message(
      'Overall Expenses',
      name: 'overall_expenses',
      desc: '',
      args: [],
    );
  }

  /// `Total savings`
  String get total_savings {
    return Intl.message(
      'Total savings',
      name: 'total_savings',
      desc: '',
      args: [],
    );
  }

  /// `This month`
  String get this_month {
    return Intl.message('This month', name: 'this_month', desc: '', args: []);
  }

  /// `Split Activity`
  String get split_activity {
    return Intl.message(
      'Split Activity',
      name: 'split_activity',
      desc: '',
      args: [],
    );
  }

  /// `View all`
  String get view_all {
    return Intl.message('View all', name: 'view_all', desc: '', args: []);
  }

  /// `You Get`
  String get you_get {
    return Intl.message('You Get', name: 'you_get', desc: '', args: []);
  }

  /// `You Give`
  String get you_give {
    return Intl.message('You Give', name: 'you_give', desc: '', args: []);
  }

  /// `Ledger Books`
  String get ledger_books {
    return Intl.message(
      'Ledger Books',
      name: 'ledger_books',
      desc: '',
      args: [],
    );
  }

  /// `Causten`
  String get causten {
    return Intl.message('Causten', name: 'causten', desc: '', args: []);
  }

  /// `Add`
  String get s_add {
    return Intl.message('Add', name: 's_add', desc: '', args: []);
  }

  /// `Add Income`
  String get add_income {
    return Intl.message('Add Income', name: 'add_income', desc: '', args: []);
  }

  /// `Add Expense`
  String get add_expense {
    return Intl.message('Add Expense', name: 'add_expense', desc: '', args: []);
  }

  /// `Report`
  String get s_report {
    return Intl.message('Report', name: 's_report', desc: '', args: []);
  }

  /// `Total Entries`
  String get total_entries {
    return Intl.message(
      'Total Entries',
      name: 'total_entries',
      desc: '',
      args: [],
    );
  }

  /// `Total Cash In`
  String get total_cash_in {
    return Intl.message(
      'Total Cash In',
      name: 'total_cash_in',
      desc: '',
      args: [],
    );
  }

  /// `Total Cash Out`
  String get total_cash_out {
    return Intl.message(
      'Total Cash Out',
      name: 'total_cash_out',
      desc: '',
      args: [],
    );
  }

  /// `example@email.com`
  String get email_hint {
    return Intl.message(
      'example@email.com',
      name: 'email_hint',
      desc: '',
      args: [],
    );
  }

  /// `Continue with email`
  String get continue_with_email {
    return Intl.message(
      'Continue with email',
      name: 'continue_with_email',
      desc: '',
      args: [],
    );
  }

  /// `By continuing, you are agreeing to our `
  String get login_terms_and_conditions_1 {
    return Intl.message(
      'By continuing, you are agreeing to our ',
      name: 'login_terms_and_conditions_1',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Service`
  String get login_terms_and_conditions_2 {
    return Intl.message(
      'Terms of Service',
      name: 'login_terms_and_conditions_2',
      desc: '',
      args: [],
    );
  }

  /// ` and `
  String get login_terms_and_conditions_3 {
    return Intl.message(
      ' and ',
      name: 'login_terms_and_conditions_3',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get login_terms_and_conditions_4 {
    return Intl.message(
      'Privacy Policy',
      name: 'login_terms_and_conditions_4',
      desc: '',
      args: [],
    );
  }

  /// ` to learn how we collect, use, and share your data`
  String get login_terms_and_conditions_5 {
    return Intl.message(
      ' to learn how we collect, use, and share your data',
      name: 'login_terms_and_conditions_5',
      desc: '',
      args: [],
    );
  }

  /// `or`
  String get or {
    return Intl.message('or', name: 'or', desc: '', args: []);
  }

  /// `Check your email`
  String get otp_check_your_email {
    return Intl.message(
      'Check your email',
      name: 'otp_check_your_email',
      desc: '',
      args: [],
    );
  }

  /// `Enter the code sent to`
  String get otp_enter_the_otp_sent_to {
    return Intl.message(
      'Enter the code sent to',
      name: 'otp_enter_the_otp_sent_to',
      desc: '',
      args: [],
    );
  }

  /// `Resend in`
  String get otp_resend_in {
    return Intl.message('Resend in', name: 'otp_resend_in', desc: '', args: []);
  }

  /// `Resend code`
  String get otp_resend_code {
    return Intl.message(
      'Resend code',
      name: 'otp_resend_code',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect code`
  String get otp_invalid_verification_code {
    return Intl.message(
      'Incorrect code',
      name: 'otp_invalid_verification_code',
      desc: '',
      args: [],
    );
  }

  /// `Confirm email`
  String get otp_confirm_email {
    return Intl.message(
      'Confirm email',
      name: 'otp_confirm_email',
      desc: '',
      args: [],
    );
  }

  /// `Verification code resent`
  String get otp_verification_code_resent {
    return Intl.message(
      'Verification code resent',
      name: 'otp_verification_code_resent',
      desc: '',
      args: [],
    );
  }

  /// `show more`
  String get show_more {
    return Intl.message('show more', name: 'show_more', desc: '', args: []);
  }

  /// `show less`
  String get show_less {
    return Intl.message('show less', name: 'show_less', desc: '', args: []);
  }

  /// `Continue`
  String get s_continue {
    return Intl.message('Continue', name: 's_continue', desc: '', args: []);
  }

  /// `Create account`
  String get s_create_account {
    return Intl.message(
      'Create account',
      name: 's_create_account',
      desc: '',
      args: [],
    );
  }

  /// `How old are you?`
  String get how_old_are_your {
    return Intl.message(
      'How old are you?',
      name: 'how_old_are_your',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get s_age {
    return Intl.message('Age', name: 's_age', desc: '', args: []);
  }

  /// `Name`
  String get s_name {
    return Intl.message('Name', name: 's_name', desc: '', args: []);
  }

  /// `Let’s get started,\nwhat’s your name?`
  String get s_name_hint {
    return Intl.message(
      'Let’s get started,\nwhat’s your name?',
      name: 's_name_hint',
      desc: '',
      args: [],
    );
  }

  /// `What’s your gender?`
  String get s_gender_hint {
    return Intl.message(
      'What’s your gender?',
      name: 's_gender_hint',
      desc: '',
      args: [],
    );
  }

  /// `Select a clinic`
  String get s_clinic_hint {
    return Intl.message(
      'Select a clinic',
      name: 's_clinic_hint',
      desc: '',
      args: [],
    );
  }

  /// `Try again`
  String get s_try_again {
    return Intl.message('Try again', name: 's_try_again', desc: '', args: []);
  }

  /// `Clinics are empty \n Try again`
  String get clinics_empty_hint {
    return Intl.message(
      'Clinics are empty \n Try again',
      name: 'clinics_empty_hint',
      desc: '',
      args: [],
    );
  }

  /// `Analyzing your answer`
  String get analyzing_your_answer {
    return Intl.message(
      'Analyzing your answer',
      name: 'analyzing_your_answer',
      desc: '',
      args: [],
    );
  }

  /// `We use this information to personalize your \n experience.`
  String get s_gender_info {
    return Intl.message(
      'We use this information to personalize your \n experience.',
      name: 's_gender_info',
      desc: '',
      args: [],
    );
  }

  /// `Enter a name without numbers or special characters.`
  String get s_user_name_valid {
    return Intl.message(
      'Enter a name without numbers or special characters.',
      name: 's_user_name_valid',
      desc: '',
      args: [],
    );
  }

  /// `Name must contain at least 2 characters.`
  String get s_user_name_length_valid {
    return Intl.message(
      'Name must contain at least 2 characters.',
      name: 's_user_name_length_valid',
      desc: '',
      args: [],
    );
  }

  /// `Profile update failed. Please try again`
  String get s_profile_update_failed {
    return Intl.message(
      'Profile update failed. Please try again',
      name: 's_profile_update_failed',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get s_male {
    return Intl.message('Male', name: 's_male', desc: '', args: []);
  }

  /// `Female`
  String get s_female {
    return Intl.message('Female', name: 's_female', desc: '', args: []);
  }

  /// `Non-binary`
  String get s_non_binary {
    return Intl.message('Non-binary', name: 's_non_binary', desc: '', args: []);
  }

  /// `Other`
  String get s_prefer_not_to_say {
    return Intl.message(
      'Other',
      name: 's_prefer_not_to_say',
      desc: '',
      args: [],
    );
  }

  /// `Accept and Continue`
  String get s_accept_continue {
    return Intl.message(
      'Accept and Continue',
      name: 's_accept_continue',
      desc: '',
      args: [],
    );
  }

  /// `Please read Medical Disclaimer and Appropriate Use of the App`
  String get medical_disclaimer_1 {
    return Intl.message(
      'Please read Medical Disclaimer and Appropriate Use of the App',
      name: 'medical_disclaimer_1',
      desc: '',
      args: [],
    );
  }

  /// `1. Age Restriction and User Agreement Notice`
  String get medical_disclaimer_2 {
    return Intl.message(
      '1. Age Restriction and User Agreement Notice',
      name: 'medical_disclaimer_2',
      desc: '',
      args: [],
    );
  }

  /// `This app is intended for users over the age of 13. By using this app, you represent you are at least 13 years of age. If you are not 13 years of age or otherwise do not agree to use the app according to the below information, you must not access the app.`
  String get medical_disclaimer_3 {
    return Intl.message(
      'This app is intended for users over the age of 13. By using this app, you represent you are at least 13 years of age. If you are not 13 years of age or otherwise do not agree to use the app according to the below information, you must not access the app.',
      name: 'medical_disclaimer_3',
      desc: '',
      args: [],
    );
  }

  /// `2. Disclaimer of Medical Advice`
  String get medical_disclaimer_4 {
    return Intl.message(
      '2. Disclaimer of Medical Advice',
      name: 'medical_disclaimer_4',
      desc: '',
      args: [],
    );
  }

  /// `This app does not provide any medical advice, psychiatric diagnosis, or treatment, either on this app or elsewhere. The app and the data it generates are intended for informational purposes only.`
  String get medical_disclaimer_5 {
    return Intl.message(
      'This app does not provide any medical advice, psychiatric diagnosis, or treatment, either on this app or elsewhere. The app and the data it generates are intended for informational purposes only.',
      name: 'medical_disclaimer_5',
      desc: '',
      args: [],
    );
  }

  /// `3. Consultation Recommendation and Emergency Protocol`
  String get medical_disclaimer_6 {
    return Intl.message(
      '3. Consultation Recommendation and Emergency Protocol',
      name: 'medical_disclaimer_6',
      desc: '',
      args: [],
    );
  }

  /// `This app is not a replacement for licensed medical treatment. All information from the app should be discussed and confirmed with your physician, psychiatrist, or other healthcare provider before using it to inform medical or other life decisions. \n\n Consult a physician and if you are experiencing symptoms of any illness.\n\n If you are experiencing a medical emergency, call 911 or your local emergency number immediately.`
  String get medical_disclaimer_7 {
    return Intl.message(
      'This app is not a replacement for licensed medical treatment. All information from the app should be discussed and confirmed with your physician, psychiatrist, or other healthcare provider before using it to inform medical or other life decisions. \n\n Consult a physician and if you are experiencing symptoms of any illness.\n\n If you are experiencing a medical emergency, call 911 or your local emergency number immediately.',
      name: 'medical_disclaimer_7',
      desc: '',
      args: [],
    );
  }

  /// `Name must contain at least 2 characters.`
  String get s_name_minimum_length {
    return Intl.message(
      'Name must contain at least 2 characters.',
      name: 's_name_minimum_length',
      desc: '',
      args: [],
    );
  }

  /// `Enter a name without numbers or special characters.`
  String get s_name_validation {
    return Intl.message(
      'Enter a name without numbers or special characters.',
      name: 's_name_validation',
      desc: '',
      args: [],
    );
  }

  /// `Enter a age without special characters.`
  String get s_age_validation {
    return Intl.message(
      'Enter a age without special characters.',
      name: 's_age_validation',
      desc: '',
      args: [],
    );
  }

  /// `You must be between 13 and 120 years old.`
  String get s_age_range {
    return Intl.message(
      'You must be between 13 and 120 years old.',
      name: 's_age_range',
      desc: '',
      args: [],
    );
  }

  /// `Profile photo`
  String get s_profile_photo {
    return Intl.message(
      'Profile photo',
      name: 's_profile_photo',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get s_email {
    return Intl.message('Email', name: 's_email', desc: '', args: []);
  }

  /// `ACCOUNT`
  String get s_account {
    return Intl.message('ACCOUNT', name: 's_account', desc: '', args: []);
  }

  /// `Gender`
  String get s_gender {
    return Intl.message('Gender', name: 's_gender', desc: '', args: []);
  }

  /// `PREFERENCES`
  String get s_preferences {
    return Intl.message(
      'PREFERENCES',
      name: 's_preferences',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get s_notifications {
    return Intl.message(
      'Notifications',
      name: 's_notifications',
      desc: '',
      args: [],
    );
  }

  /// `HELP & SUPPORT`
  String get s_help_support {
    return Intl.message(
      'HELP & SUPPORT',
      name: 's_help_support',
      desc: '',
      args: [],
    );
  }

  /// `Help Center`
  String get s_help_center {
    return Intl.message(
      'Help Center',
      name: 's_help_center',
      desc: '',
      args: [],
    );
  }

  /// `Sign out`
  String get s_sign_out {
    return Intl.message('Sign out', name: 's_sign_out', desc: '', args: []);
  }

  /// `Off`
  String get s_off {
    return Intl.message('Off', name: 's_off', desc: '', args: []);
  }

  /// `On`
  String get s_on {
    return Intl.message('On', name: 's_on', desc: '', args: []);
  }

  /// `Yes`
  String get s_yes {
    return Intl.message('Yes', name: 's_yes', desc: '', args: []);
  }

  /// `No`
  String get s_no {
    return Intl.message('No', name: 's_no', desc: '', args: []);
  }

  /// `Cancel`
  String get s_cancel {
    return Intl.message('Cancel', name: 's_cancel', desc: '', args: []);
  }

  /// `Save`
  String get s_save {
    return Intl.message('Save', name: 's_save', desc: '', args: []);
  }

  /// `Edit name`
  String get edit_name {
    return Intl.message('Edit name', name: 'edit_name', desc: '', args: []);
  }

  /// `Edit age`
  String get edit_age {
    return Intl.message('Edit age', name: 'edit_age', desc: '', args: []);
  }

  /// `Edit gender`
  String get edit_gender {
    return Intl.message('Edit gender', name: 'edit_gender', desc: '', args: []);
  }

  /// `Edit profile photo`
  String get edit_profile_photo {
    return Intl.message(
      'Edit profile photo',
      name: 'edit_profile_photo',
      desc: '',
      args: [],
    );
  }

  /// `Edit notification`
  String get edit_notification {
    return Intl.message(
      'Edit notification',
      name: 'edit_notification',
      desc: '',
      args: [],
    );
  }

  /// `Log out of your account?`
  String get s_logout_title {
    return Intl.message(
      'Log out of your account?',
      name: 's_logout_title',
      desc: '',
      args: [],
    );
  }

  /// `Change profile photo`
  String get s_change_profile_photo {
    return Intl.message(
      'Change profile photo',
      name: 's_change_profile_photo',
      desc: '',
      args: [],
    );
  }

  /// `Choose from library`
  String get s_change_from_library {
    return Intl.message(
      'Choose from library',
      name: 's_change_from_library',
      desc: '',
      args: [],
    );
  }

  /// `Take photo`
  String get s_take_photo {
    return Intl.message('Take photo', name: 's_take_photo', desc: '', args: []);
  }

  /// `Remove current photo`
  String get s_remove_photo {
    return Intl.message(
      'Remove current photo',
      name: 's_remove_photo',
      desc: '',
      args: [],
    );
  }

  /// `Signing out will clear today's progress`
  String get s_logout_message {
    return Intl.message(
      'Signing out will clear today\'s progress',
      name: 's_logout_message',
      desc: '',
      args: [],
    );
  }

  /// `Learn how to use the app or Contact us`
  String get s_help_info {
    return Intl.message(
      'Learn how to use the app or Contact us',
      name: 's_help_info',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get s_close {
    return Intl.message('Close', name: 's_close', desc: '', args: []);
  }

  /// `New collection`
  String get s_new_collection {
    return Intl.message(
      'New collection',
      name: 's_new_collection',
      desc: '',
      args: [],
    );
  }

  /// `Rename collection`
  String get s_rename_collection {
    return Intl.message(
      'Rename collection',
      name: 's_rename_collection',
      desc: '',
      args: [],
    );
  }

  /// `Quick save`
  String get s_quick_save {
    return Intl.message('Quick save', name: 's_quick_save', desc: '', args: []);
  }

  /// `Enter name`
  String get s_enter_name {
    return Intl.message('Enter name', name: 's_enter_name', desc: '', args: []);
  }

  /// `Rename`
  String get s_rename {
    return Intl.message('Rename', name: 's_rename', desc: '', args: []);
  }

  /// `Change`
  String get s_change {
    return Intl.message('Change', name: 's_change', desc: '', args: []);
  }

  /// `Delete`
  String get s_delete {
    return Intl.message('Delete', name: 's_delete', desc: '', args: []);
  }

  /// `MEDITATION`
  String get s_meditation {
    return Intl.message('MEDITATION', name: 's_meditation', desc: '', args: []);
  }

  /// `JOURNAL`
  String get s_journal {
    return Intl.message('JOURNAL', name: 's_journal', desc: '', args: []);
  }

  /// `HYPNOSIS`
  String get s_hypnosis {
    return Intl.message('HYPNOSIS', name: 's_hypnosis', desc: '', args: []);
  }

  /// `BREATH`
  String get s_breath {
    return Intl.message('BREATH', name: 's_breath', desc: '', args: []);
  }

  /// `Saved to `
  String get s_saved_to {
    return Intl.message('Saved to ', name: 's_saved_to', desc: '', args: []);
  }

  /// `Removed from `
  String get s_removed_from {
    return Intl.message(
      'Removed from ',
      name: 's_removed_from',
      desc: '',
      args: [],
    );
  }

  /// `Create collection`
  String get s_create_collection {
    return Intl.message(
      'Create collection',
      name: 's_create_collection',
      desc: '',
      args: [],
    );
  }

  /// `Delete collection`
  String get s_delete_collection {
    return Intl.message(
      'Delete collection',
      name: 's_delete_collection',
      desc: '',
      args: [],
    );
  }

  /// `No favorites in your library yet`
  String get s_favorite_empty_info {
    return Intl.message(
      'No favorites in your library yet',
      name: 's_favorite_empty_info',
      desc: '',
      args: [],
    );
  }

  /// `Any content you bookmark and add to \n your favorites will appear here.`
  String get s_favorite_empty_desc {
    return Intl.message(
      'Any content you bookmark and add to \n your favorites will appear here.',
      name: 's_favorite_empty_desc',
      desc: '',
      args: [],
    );
  }

  /// `This action will also remove all experiences saved to this collection from your favorites.`
  String get s_collection_delete_message {
    return Intl.message(
      'This action will also remove all experiences saved to this collection from your favorites.',
      name: 's_collection_delete_message',
      desc: '',
      args: [],
    );
  }

  /// `high_importance_channel`
  String get s_high_importance_channel {
    return Intl.message(
      'high_importance_channel',
      name: 's_high_importance_channel',
      desc: '',
      args: [],
    );
  }

  /// `High Importance Notifications`
  String get s_high_importance_notification {
    return Intl.message(
      'High Importance Notifications',
      name: 's_high_importance_notification',
      desc: '',
      args: [],
    );
  }

  /// `This channel is used for important notifications.`
  String get s_high_importance_channel_desc {
    return Intl.message(
      'This channel is used for important notifications.',
      name: 's_high_importance_channel_desc',
      desc: '',
      args: [],
    );
  }

  /// `Tell us what you think`
  String get tell_us_what_you_think {
    return Intl.message(
      'Tell us what you think',
      name: 'tell_us_what_you_think',
      desc: '',
      args: [],
    );
  }

  /// `How's your experience so far?`
  String get how_is_your_experience {
    return Intl.message(
      'How\'s your experience so far?',
      name: 'how_is_your_experience',
      desc: '',
      args: [],
    );
  }

  /// `Send feedback`
  String get send_feedback {
    return Intl.message(
      'Send feedback',
      name: 'send_feedback',
      desc: '',
      args: [],
    );
  }

  /// `Thank you for your feedback`
  String get thanks_for_feedback {
    return Intl.message(
      'Thank you for your feedback',
      name: 'thanks_for_feedback',
      desc: '',
      args: [],
    );
  }

  /// `Okay`
  String get s_okay {
    return Intl.message('Okay', name: 's_okay', desc: '', args: []);
  }

  /// `Feedback`
  String get s_give_feedback {
    return Intl.message(
      'Feedback',
      name: 's_give_feedback',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get s_settings {
    return Intl.message('Settings', name: 's_settings', desc: '', args: []);
  }

  /// `Thank you so much for taking the time to share your thoughts and feedback with us`
  String get thanks_for_feedback_desc {
    return Intl.message(
      'Thank you so much for taking the time to share your thoughts and feedback with us',
      name: 'thanks_for_feedback_desc',
      desc: '',
      args: [],
    );
  }

  /// `Permission Required`
  String get permission_required {
    return Intl.message(
      'Permission Required',
      name: 'permission_required',
      desc: '',
      args: [],
    );
  }

  /// `access is required to select images. Please enable it in app settings.`
  String get permission_denied_msg {
    return Intl.message(
      'access is required to select images. Please enable it in app settings.',
      name: 'permission_denied_msg',
      desc: '',
      args: [],
    );
  }

  /// `Open Settings`
  String get open_settings {
    return Intl.message(
      'Open Settings',
      name: 'open_settings',
      desc: '',
      args: [],
    );
  }

  /// `Delete content`
  String get delete_content {
    return Intl.message(
      'Delete content',
      name: 'delete_content',
      desc: '',
      args: [],
    );
  }

  /// `Delete this content?`
  String get delete_this_content {
    return Intl.message(
      'Delete this content?',
      name: 'delete_this_content',
      desc: '',
      args: [],
    );
  }

  /// `You are deleting this content from your profile.`
  String get delete_content_hint {
    return Intl.message(
      'You are deleting this content from your profile.',
      name: 'delete_content_hint',
      desc: '',
      args: [],
    );
  }

  /// `Content deleted successfully`
  String get content_deleted_successfully {
    return Intl.message(
      'Content deleted successfully',
      name: 'content_deleted_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Content deletion failed`
  String get content_deletion_failed {
    return Intl.message(
      'Content deletion failed',
      name: 'content_deletion_failed',
      desc: '',
      args: [],
    );
  }

  /// `Update Required`
  String get update_required {
    return Intl.message(
      'Update Required',
      name: 'update_required',
      desc: '',
      args: [],
    );
  }

  /// `Update Now`
  String get update_now {
    return Intl.message('Update Now', name: 'update_now', desc: '', args: []);
  }

  /// `Update Available`
  String get update_available {
    return Intl.message(
      'Update Available',
      name: 'update_available',
      desc: '',
      args: [],
    );
  }

  /// `Later`
  String get later {
    return Intl.message('Later', name: 'later', desc: '', args: []);
  }

  /// `Delete Fabric`
  String get delete_fabric {
    return Intl.message(
      'Delete Fabric',
      name: 'delete_fabric',
      desc: '',
      args: [],
    );
  }

  /// `Delete this Fabric?`
  String get delete_this_fabric {
    return Intl.message(
      'Delete this Fabric?',
      name: 'delete_this_fabric',
      desc: '',
      args: [],
    );
  }

  /// `You are deleting this Fabric from your profile.`
  String get delete_fabric_hint {
    return Intl.message(
      'You are deleting this Fabric from your profile.',
      name: 'delete_fabric_hint',
      desc: '',
      args: [],
    );
  }

  /// `Fabric deleted successfully`
  String get fabric_deleted_successfully {
    return Intl.message(
      'Fabric deleted successfully',
      name: 'fabric_deleted_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Fabric deletion failed`
  String get fabric_deletion_failed {
    return Intl.message(
      'Fabric deletion failed',
      name: 'fabric_deletion_failed',
      desc: '',
      args: [],
    );
  }

  /// `No fabrics found \n Create your first fabric!`
  String get no_fabric {
    return Intl.message(
      'No fabrics found \n Create your first fabric!',
      name: 'no_fabric',
      desc: '',
      args: [],
    );
  }

  /// `New Fabric`
  String get new_fabric {
    return Intl.message('New Fabric', name: 'new_fabric', desc: '', args: []);
  }

  /// `Date of birth`
  String get s_select_date_of_birth {
    return Intl.message(
      'Date of birth',
      name: 's_select_date_of_birth',
      desc: '',
      args: [],
    );
  }

  /// `What’s your date of birth`
  String get date_of_birth {
    return Intl.message(
      'What’s your date of birth',
      name: 'date_of_birth',
      desc: '',
      args: [],
    );
  }

  /// `Date of birth`
  String get dob {
    return Intl.message('Date of birth', name: 'dob', desc: '', args: []);
  }

  /// `Edit date of birth`
  String get edit_dob {
    return Intl.message(
      'Edit date of birth',
      name: 'edit_dob',
      desc: '',
      args: [],
    );
  }

  /// `Prompt contains inappropriate words`
  String get prompt_error {
    return Intl.message(
      'Prompt contains inappropriate words',
      name: 'prompt_error',
      desc: '',
      args: [],
    );
  }

  /// `Description contains inappropriate words`
  String get description_error {
    return Intl.message(
      'Description contains inappropriate words',
      name: 'description_error',
      desc: '',
      args: [],
    );
  }

  /// `User name goes against our policy`
  String get user_name_error {
    return Intl.message(
      'User name goes against our policy',
      name: 'user_name_error',
      desc: '',
      args: [],
    );
  }

  /// `Your uploaded profile image goes against our policy`
  String get profile_img_name_error {
    return Intl.message(
      'Your uploaded profile image goes against our policy',
      name: 'profile_img_name_error',
      desc: '',
      args: [],
    );
  }

  /// `You can not make this video`
  String get video_moderated_error {
    return Intl.message(
      'You can not make this video',
      name: 'video_moderated_error',
      desc: '',
      args: [],
    );
  }

  /// `It goes against our Terms of Service`
  String get video_moderated_error_desc {
    return Intl.message(
      'It goes against our Terms of Service',
      name: 'video_moderated_error_desc',
      desc: '',
      args: [],
    );
  }

  /// `Welcome!`
  String get s_welcome {
    return Intl.message('Welcome!', name: 's_welcome', desc: '', args: []);
  }

  /// `Select your gender`
  String get your_gender {
    return Intl.message(
      'Select your gender',
      name: 'your_gender',
      desc: '',
      args: [],
    );
  }

  /// `Select gender`
  String get select_gender {
    return Intl.message(
      'Select gender',
      name: 'select_gender',
      desc: '',
      args: [],
    );
  }

  /// `Select your date of birth`
  String get s_birthdate {
    return Intl.message(
      'Select your date of birth',
      name: 's_birthdate',
      desc: '',
      args: [],
    );
  }

  /// `skip`
  String get skip {
    return Intl.message('skip', name: 'skip', desc: '', args: []);
  }

  /// `Gallery`
  String get gallery {
    return Intl.message('Gallery', name: 'gallery', desc: '', args: []);
  }

  /// `Camera`
  String get camera {
    return Intl.message('Camera', name: 'camera', desc: '', args: []);
  }

  /// `Files`
  String get files {
    return Intl.message('Files', name: 'files', desc: '', args: []);
  }

  /// `You can't make this Fabric`
  String get fabric_moderation {
    return Intl.message(
      'You can\'t make this Fabric',
      name: 'fabric_moderation',
      desc: '',
      args: [],
    );
  }

  /// `It goes against our Terms of Service`
  String get image_moderation {
    return Intl.message(
      'It goes against our Terms of Service',
      name: 'image_moderation',
      desc: '',
      args: [],
    );
  }

  /// `Add references`
  String get add_references {
    return Intl.message(
      'Add references',
      name: 'add_references',
      desc: '',
      args: [],
    );
  }

  /// `Upload your photo to create a Fabric for your profile photo`
  String get unique_fabric {
    return Intl.message(
      'Upload your photo to create a Fabric for your profile photo',
      name: 'unique_fabric',
      desc: '',
      args: [],
    );
  }

  /// `Fabric Created`
  String get fabric_created {
    return Intl.message(
      'Fabric Created',
      name: 'fabric_created',
      desc: '',
      args: [],
    );
  }

  /// `You can reuse this Fabric at anytime to create new content`
  String get create_fabric_hint {
    return Intl.message(
      'You can reuse this Fabric at anytime to create new content',
      name: 'create_fabric_hint',
      desc: '',
      args: [],
    );
  }

  /// `Choose media assets`
  String get choose_media {
    return Intl.message(
      'Choose media assets',
      name: 'choose_media',
      desc: '',
      args: [],
    );
  }

  /// `These references will be used to influence your creations`
  String get choose_media_hint {
    return Intl.message(
      'These references will be used to influence your creations',
      name: 'choose_media_hint',
      desc: '',
      args: [],
    );
  }

  /// `Add Photo`
  String get add_photo {
    return Intl.message('Add Photo', name: 'add_photo', desc: '', args: []);
  }

  /// `Create a fabric`
  String get create_fabric {
    return Intl.message(
      'Create a fabric',
      name: 'create_fabric',
      desc: '',
      args: [],
    );
  }

  /// `Welcome aboard`
  String get welcome_aboard {
    return Intl.message(
      'Welcome aboard',
      name: 'welcome_aboard',
      desc: '',
      args: [],
    );
  }

  /// `Fabric saved to your collection`
  String get saved_fabric_msg {
    return Intl.message(
      'Fabric saved to your collection',
      name: 'saved_fabric_msg',
      desc: '',
      args: [],
    );
  }

  /// `Create your first Fabric`
  String get first_fabric {
    return Intl.message(
      'Create your first Fabric',
      name: 'first_fabric',
      desc: '',
      args: [],
    );
  }

  /// `Stitch your first video`
  String get stitch_your_first_video {
    return Intl.message(
      'Stitch your first video',
      name: 'stitch_your_first_video',
      desc: '',
      args: [],
    );
  }

  /// `Go to your feed`
  String get go_to_your_feed {
    return Intl.message(
      'Go to your feed',
      name: 'go_to_your_feed',
      desc: '',
      args: [],
    );
  }

  /// `Created your first fabric\nSet your profile picture`
  String get fabric_hint {
    return Intl.message(
      'Created your first fabric\nSet your profile picture',
      name: 'fabric_hint',
      desc: '',
      args: [],
    );
  }

  /// `Great job! you`
  String get great_job_you {
    return Intl.message(
      'Great job! you',
      name: 'great_job_you',
      desc: '',
      args: [],
    );
  }

  /// `@username in Tuxedo...`
  String get profile_prompt_hint {
    return Intl.message(
      '@username in Tuxedo...',
      name: 'profile_prompt_hint',
      desc: '',
      args: [],
    );
  }

  /// `Enter any text in the prompt to reimagine yourself`
  String get edit_with_your_own_idea {
    return Intl.message(
      'Enter any text in the prompt to reimagine yourself',
      name: 'edit_with_your_own_idea',
      desc: '',
      args: [],
    );
  }

  /// `Set as your Profile Photo`
  String get set_profile_picture {
    return Intl.message(
      'Set as your Profile Photo',
      name: 'set_profile_picture',
      desc: '',
      args: [],
    );
  }

  /// `I love it`
  String get i_love_it {
    return Intl.message('I love it', name: 'i_love_it', desc: '', args: []);
  }

  /// `You must be at least 13 years or older`
  String get s_birthdate_hint {
    return Intl.message(
      'You must be at least 13 years or older',
      name: 's_birthdate_hint',
      desc: '',
      args: [],
    );
  }

  /// `This will help get you recommended relevant content and connect you with friends.`
  String get your_gender_hint {
    return Intl.message(
      'This will help get you recommended relevant content and connect you with friends.',
      name: 'your_gender_hint',
      desc: '',
      args: [],
    );
  }

  /// `Login to start stitching`
  String get s_login_hint {
    return Intl.message(
      'Login to start stitching',
      name: 's_login_hint',
      desc: '',
      args: [],
    );
  }

  /// `Create a username`
  String get s_create_a_unique_username {
    return Intl.message(
      'Create a username',
      name: 's_create_a_unique_username',
      desc: '',
      args: [],
    );
  }

  /// `Enter your name`
  String get s_set_profile_name {
    return Intl.message(
      'Enter your name',
      name: 's_set_profile_name',
      desc: '',
      args: [],
    );
  }

  /// `You will be able to set your @username in the next screen`
  String get s_first_name_hint {
    return Intl.message(
      'You will be able to set your @username in the next screen',
      name: 's_first_name_hint',
      desc: '',
      args: [],
    );
  }

  /// `Your friends will be able to tag you with this username. You can change it later`
  String get s_create_a_unique_username_hint {
    return Intl.message(
      'Your friends will be able to tag you with this username. You can change it later',
      name: 's_create_a_unique_username_hint',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `PROFILE`
  String get profile {
    return Intl.message('PROFILE', name: 'profile', desc: '', args: []);
  }

  /// `Report`
  String get report {
    return Intl.message('Report', name: 'report', desc: '', args: []);
  }

  /// `Report Content`
  String get report_content {
    return Intl.message(
      'Report Content',
      name: 'report_content',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message('Username', name: 'username', desc: '', args: []);
  }

  /// `PRIVACY`
  String get privacy {
    return Intl.message('PRIVACY', name: 'privacy', desc: '', args: []);
  }

  /// `Unblock`
  String get unblock {
    return Intl.message('Unblock', name: 'unblock', desc: '', args: []);
  }

  /// `You have no blocked users to show`
  String get no_blocked_user {
    return Intl.message(
      'You have no blocked users to show',
      name: 'no_blocked_user',
      desc: '',
      args: [],
    );
  }

  /// `Blocked Users`
  String get blocked_users {
    return Intl.message(
      'Blocked Users',
      name: 'blocked_users',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `We will not recommend content\n similar to this in the future`
  String get blocked_hint {
    return Intl.message(
      'We will not recommend content\n similar to this in the future',
      name: 'blocked_hint',
      desc: '',
      args: [],
    );
  }

  /// `This user will no longer be able to view your content and their content will be hidden from you as well.\n\nThis can be changed in your Privacy Settings.`
  String get blocked_success_hint {
    return Intl.message(
      'This user will no longer be able to view your content and their content will be hidden from you as well.\n\nThis can be changed in your Privacy Settings.',
      name: 'blocked_success_hint',
      desc: '',
      args: [],
    );
  }

  /// `Thank you for your report`
  String get report_msg {
    return Intl.message(
      'Thank you for your report',
      name: 'report_msg',
      desc: '',
      args: [],
    );
  }

  /// `Our team will review the content\n and take appropriate action if it\n violates our guidelines.`
  String get report_desc {
    return Intl.message(
      'Our team will review the content\n and take appropriate action if it\n violates our guidelines.',
      name: 'report_desc',
      desc: '',
      args: [],
    );
  }

  /// `Why are you reporting this post?`
  String get report_title {
    return Intl.message(
      'Why are you reporting this post?',
      name: 'report_title',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get delete_account {
    return Intl.message(
      'Delete Account',
      name: 'delete_account',
      desc: '',
      args: [],
    );
  }

  /// `You will be redirected to a web\n page to confirm this action`
  String get delete_account_hint {
    return Intl.message(
      'You will be redirected to a web\n page to confirm this action',
      name: 'delete_account_hint',
      desc: '',
      args: [],
    );
  }

  /// ` the subject from reference image `
  String get prompt_replace_text {
    return Intl.message(
      ' the subject from reference image ',
      name: 'prompt_replace_text',
      desc: '',
      args: [],
    );
  }

  /// `Profile visibility`
  String get profile_visibility {
    return Intl.message(
      'Profile visibility',
      name: 'profile_visibility',
      desc: '',
      args: [],
    );
  }

  /// `Private Profile`
  String get private_profile {
    return Intl.message(
      'Private Profile',
      name: 'private_profile',
      desc: '',
      args: [],
    );
  }

  /// `With a private account, only users you approve can follow you and watch your content. Your existing followers won’t be affected.`
  String get profile_visibility_hint {
    return Intl.message(
      'With a private account, only users you approve can follow you and watch your content. Your existing followers won’t be affected.',
      name: 'profile_visibility_hint',
      desc: '',
      args: [],
    );
  }

  /// `is standing and facing forward in the center of a cozy isometric bedroom. Make it in pixel-art style with a isometric view`
  String get profile_prompt_1 {
    return Intl.message(
      'is standing and facing forward in the center of a cozy isometric bedroom. Make it in pixel-art style with a isometric view',
      name: 'profile_prompt_1',
      desc: '',
      args: [],
    );
  }

  /// ` is standing and facing forward. Detailed pixel art rendering, warm colors, and soft lighting.`
  String get profile_prompt_2 {
    return Intl.message(
      ' is standing and facing forward. Detailed pixel art rendering, warm colors, and soft lighting.',
      name: 'profile_prompt_2',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[Locale.fromSubtags(languageCode: 'en')];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
