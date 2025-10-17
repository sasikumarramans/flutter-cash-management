import 'package:bearnshare/app/theme/app_theme.dart';
import 'package:bearnshare/data/local/hive_manager.dart';
import 'package:bearnshare/presentation/component/app_button.dart';
import 'package:bearnshare/presentation/main_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:language_info_plus/language_info_plus.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String? selectedLanguageCode;
  String? selectedFlagCode;
  String? selectedLanguageName;
  String searchQuery = '';
  late List<Language> allLanguages;

  @override
  void initState() {
    super.initState();
    allLanguages = LanguageInfoPlus.languages;
    // Set default to English
    selectedLanguageCode = allLanguages.firstWhere(
      (lang) => lang.name.toLowerCase() == 'english',
      orElse: () => allLanguages.first,
    ).code;
    selectedFlagCode='🇺🇸';
    selectedLanguageName="English";
    FlutterNativeSplash.remove();
  }

  List<Language> get filteredLanguages {
    if (searchQuery.isEmpty) {
      return allLanguages;
    }
    return allLanguages.where((lang) {
      final query = searchQuery.toLowerCase();
      return lang.name.toLowerCase().contains(query)||
             lang.code.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              _buildHeader(),
              _buildGlobeIcon(),
              _buildTitle(),
              const SizedBox(height: 8),
              _buildSubtitle(),
              const SizedBox(height: 24),
              _buildFilterChip(selectedLanguageName!,selectedFlagCode!),
              const SizedBox(height: 10),
              _buildSearchBar(),
              const SizedBox(height: 16),
              Expanded(
                child: _buildLanguageList(),
              ),
              _buildContinueButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppTheme.splitGroupColor,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
        ),
      ],
    );
  }

  Widget _buildGlobeIcon() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: AppTheme.splitGroupColor.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.language,
        color: AppTheme.splitGroupColor,
        size: 40,
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'Choose your language',
      style: AppTheme.homePageContentHeaderTextStyle.copyWith(fontSize: 24),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      "Select the language you're most\ncomfortable with",
      textAlign: TextAlign.center,
      style: AppTheme.simpleWhiteTextStyle.copyWith(
        fontSize: 15,
        color: AppTheme.secondaryLabelColor,
        height: 1.5,
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.tertiaryBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.boxEnabledBorderColor,
          width: 1,
        ),
      ),
      child: TextField(
        onChanged: (value) {
          setState(() {
            searchQuery = value;
          });
        },
        style: AppTheme.simpleWhiteTextStyle,
        decoration: InputDecoration(
          hintText: 'Search languages...',
          hintStyle: AppTheme.simpleWhiteTextStyle.copyWith(
            color: AppTheme.secondaryLabelColor,
          ),
          border: InputBorder.none,
          icon: Icon(
            Icons.search,
            color: AppTheme.secondaryLabelColor,
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageList() {
    final languages = filteredLanguages;

    if (languages.isEmpty) {
      return Center(
        child: Text(
          'No languages found',
          style: AppTheme.simpleWhiteTextStyle.copyWith(
            color: AppTheme.secondaryLabelColor,
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: languages.length,
      itemBuilder: (context, index) {
        return _buildLanguageItem(languages[index]);
      },
    );
  }



  String _getCountryCodeForLanguage(String languageCode) {
    // Manual mapping of language codes to their primary country codes
    final Map<String, String> languageToCountry = {
      // Major Languages
      'en': 'US', // English -> United States
      'es': 'ES', // Spanish -> Spain
      'fr': 'FR', // French -> France
      'de': 'DE', // German -> Germany
      'it': 'IT', // Italian -> Italy
      'pt': 'PT', // Portuguese -> Portugal
      'ru': 'RU', // Russian -> Russia
      'ja': 'JP', // Japanese -> Japan
      'ko': 'KR', // Korean -> South Korea
      'zh': 'CN', // Chinese -> China
      'ar': 'SA', // Arabic -> Saudi Arabia
      'hi': 'IN', // Hindi -> India
      'bn': 'BD', // Bengali -> Bangladesh
      'tr': 'TR', // Turkish -> Turkey
      'vi': 'VN', // Vietnamese -> Vietnam
      'pl': 'PL', // Polish -> Poland
      'uk': 'UA', // Ukrainian -> Ukraine
      'nl': 'NL', // Dutch -> Netherlands
      'th': 'TH', // Thai -> Thailand
      'sv': 'SE', // Swedish -> Sweden
      'el': 'GR', // Greek -> Greece
      'cs': 'CZ', // Czech -> Czech Republic
      'ro': 'RO', // Romanian -> Romania
      'hu': 'HU', // Hungarian -> Hungary
      'da': 'DK', // Danish -> Denmark
      'fi': 'FI', // Finnish -> Finland
      'no': 'NO', // Norwegian -> Norway
      'he': 'IL', // Hebrew -> Israel
      'id': 'ID', // Indonesian -> Indonesia
      'ms': 'MY', // Malay -> Malaysia
      'fa': 'IR', // Persian -> Iran

      // Indian Languages
      'pa': 'IN', // Punjabi -> India
      'te': 'IN', // Telugu -> India
      'mr': 'IN', // Marathi -> India
      'ta': 'IN', // Tamil -> India
      'gu': 'IN', // Gujarati -> India
      'kn': 'IN', // Kannada -> India
      'ml': 'IN', // Malayalam -> India
      'or': 'IN', // Odia -> India
      'as': 'IN', // Assamese -> India

      // Other Asian Languages
      'ur': 'PK', // Urdu -> Pakistan
      'ne': 'NP', // Nepali -> Nepal
      'si': 'LK', // Sinhala -> Sri Lanka
      'my': 'MM', // Burmese -> Myanmar
      'km': 'KH', // Khmer -> Cambodia
      'lo': 'LA', // Lao -> Laos
      'mn': 'MN', // Mongolian -> Mongolia
      'ka': 'GE', // Georgian -> Georgia
      'kk': 'KZ', // Kazakh -> Kazakhstan
      'uz': 'UZ', // Uzbek -> Uzbekistan
      'af': 'ZA', // Afrikaans -> South Africa
      'am': 'ET', // Amharic -> Ethiopia
      'sw': 'TZ', // Swahili -> Tanzania
      'zu': 'ZA', // Zulu -> South Africa
      'xh': 'ZA', // Xhosa -> South Africa
      'yo': 'NG', // Yoruba -> Nigeria
      'ig': 'NG', // Igbo -> Nigeria
      'ha': 'NG', // Hausa -> Nigeria

      // European Languages
      'sq': 'AL', // Albanian -> Albania
      'eu': 'ES', // Basque -> Spain
      'be': 'BY', // Belarusian -> Belarus
      'bg': 'BG', // Bulgarian -> Bulgaria
      'ca': 'ES', // Catalan -> Spain
      'hr': 'HR', // Croatian -> Croatia
      'et': 'EE', // Estonian -> Estonia
      'gl': 'ES', // Galician -> Spain
      'is': 'IS', // Icelandic -> Iceland
      'lv': 'LV', // Latvian -> Latvia
      'lt': 'LT', // Lithuanian -> Lithuania
      'mk': 'MK', // Macedonian -> North Macedonia
      'mt': 'MT', // Maltese -> Malta
      'sk': 'SK', // Slovak -> Slovakia
      'sl': 'SI', // Slovenian -> Slovenia
      'sr': 'RS', // Serbian -> Serbia
      'cy': 'GB', // Welsh -> United Kingdom
      'ga': 'IE', // Irish -> Ireland
      'gd': 'GB', // Scottish Gaelic -> United Kingdom

      // Other Languages
      'tl': 'PH', // Tagalog -> Philippines
      'fil': 'PH', // Filipino -> Philippines
      'hy': 'AM', // Armenian -> Armenia
      'az': 'AZ', // Azerbaijani -> Azerbaijan
      'bs': 'BA', // Bosnian -> Bosnia and Herzegovina
      'eo': 'EU', // Esperanto -> Europe (placeholder)
      'fo': 'FO', // Faroese -> Faroe Islands
      'fy': 'NL', // Frisian -> Netherlands
      'lb': 'LU', // Luxembourgish -> Luxembourg
      'nn': 'NO', // Norwegian Nynorsk -> Norway
    };

    return languageToCountry[languageCode.toLowerCase()] ?? '';
  }

  String _convertCountryCodeToFlag(String countryCode) {
    if (countryCode.length != 2) {
      return '🌐'; // Default globe icon
    }

    final int firstLetter = countryCode.codeUnitAt(0) - 0x41 + 0x1F1E6;
    final int secondLetter = countryCode.codeUnitAt(1) - 0x41 + 0x1F1E6;
    return String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);
  }
  Widget _buildFilterChip(String label, String flag) {
    const isSelected =true;
    return Container(alignment: Alignment.center,width: 120,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color:  const Color(0xFF2A2A2A) ,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF3A3A3A),
          width: 1,
        ),
      ),
      child: Row(mainAxisSize: MainAxisSize.min,crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            flag,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildLanguageItem(Language language) {
    final isSelected = selectedLanguageCode == language.code;
    final countryCode = _getCountryCodeForLanguage(language.code);
    final flag = _convertCountryCodeToFlag(countryCode);


    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLanguageCode = language.code;
          selectedLanguageName=language.name;
          selectedFlagCode=flag;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.tertiaryBackgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppTheme.splitGroupColor : AppTheme.boxEnabledBorderColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              child: Center(
                child: Text(
                  flag,
                  style: const TextStyle(fontSize: 32),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    language.name,
                    style: AppTheme.ledgerTitleTextStyle,
                  ),

                ],
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppTheme.splitGroupColor : AppTheme.labelTextColor,
                  width: 2,
                ),
                color: isSelected ? AppTheme.splitGroupColor : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(
                Icons.circle,
                size: 12,
                color: Colors.white,
              )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: AppButton(
        textString: 'Continue',
        buttonType: ButtonType.filled,
        expandButton: true,
        buttonState: ButtonState.enabled,
        padding: const EdgeInsets.symmetric(vertical: 18),
        enabledButtonFilledStyle: BoxDecoration(
          color: AppTheme.splitGroupColor,
          borderRadius: BorderRadius.circular(30),
        ),
        enabledTextStyle: AppTheme.textEnabledTheme.copyWith(
          color: Colors.white,
        ),
        onPressed: (value) {
          GetIt.I<HiveManager>()
              .saveToHive(HiveManager.languageUpdatedKey,selectedLanguageCode!);
          context.go(MainRouter.mainScreenRoute);
        },
      ),
    );
  }
}
