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
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
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
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Wooden Fish - Chanting Artifact`
  String get appName {
    return Intl.message(
      'Wooden Fish - Chanting Artifact',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Hello!`
  String get hello {
    return Intl.message(
      'Hello!',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Buddhist`
  String get prayerBeads {
    return Intl.message(
      'Buddhist',
      name: 'prayerBeads',
      desc: '',
      args: [],
    );
  }

  /// `My`
  String get me {
    return Intl.message(
      'My',
      name: 'me',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get setting {
    return Intl.message(
      'Setting',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `share`
  String get shareTxt {
    return Intl.message(
      'share',
      name: 'shareTxt',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `User Agreement`
  String get userAgreement {
    return Intl.message(
      'User Agreement',
      name: 'userAgreement',
      desc: '',
      args: [],
    );
  }

  /// `Terms Use`
  String get termsUse {
    return Intl.message(
      'Terms Use',
      name: 'termsUse',
      desc: '',
      args: [],
    );
  }

  /// `About Us`
  String get aboutUs {
    return Intl.message(
      'About Us',
      name: 'aboutUs',
      desc: '',
      args: [],
    );
  }

  /// `Introduction to Wooden Fish`
  String get wfIntroduction {
    return Intl.message(
      'Introduction to Wooden Fish',
      name: 'wfIntroduction',
      desc: '',
      args: [],
    );
  }

  /// `Symbol`
  String get fu {
    return Intl.message(
      'Symbol',
      name: 'fu',
      desc: '',
      args: [],
    );
  }

  /// `Background`
  String get bg {
    return Intl.message(
      'Background',
      name: 'bg',
      desc: '',
      args: [],
    );
  }

  /// `Background Music`
  String get bgm {
    return Intl.message(
      'Background Music',
      name: 'bgm',
      desc: '',
      args: [],
    );
  }

  /// `Automatic Tapping`
  String get automaticTapping {
    return Intl.message(
      'Automatic Tapping',
      name: 'automaticTapping',
      desc: '',
      args: [],
    );
  }

  /// `Snowflake background`
  String get snowflakeText {
    return Intl.message(
      'Snowflake background',
      name: 'snowflakeText',
      desc: '',
      args: [],
    );
  }

  /// `Suspended Text`
  String get suspendedText {
    return Intl.message(
      'Suspended Text',
      name: 'suspendedText',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the suspended text: such as: merit, good luck, making money`
  String get suspendedTextTip {
    return Intl.message(
      'Please enter the suspended text: such as: merit, good luck, making money',
      name: 'suspendedTextTip',
      desc: '',
      args: [],
    );
  }

  /// `Sorry! This suspended tip is not available!`
  String get suspendedNoTip {
    return Intl.message(
      'Sorry! This suspended tip is not available!',
      name: 'suspendedNoTip',
      desc: '',
      args: [],
    );
  }

  /// `Skin`
  String get skin {
    return Intl.message(
      'Skin',
      name: 'skin',
      desc: '',
      args: [],
    );
  }

  /// `timbre`
  String get timbre {
    return Intl.message(
      'timbre',
      name: 'timbre',
      desc: '',
      args: [],
    );
  }

  /// `Background music volume`
  String get bgmVolume {
    return Intl.message(
      'Background music volume',
      name: 'bgmVolume',
      desc: '',
      args: [],
    );
  }

  /// `Tap interval ({count}) seconds`
  String tapInterval(Object count) {
    return Intl.message(
      'Tap interval ($count) seconds',
      name: 'tapInterval',
      desc: '',
      args: [count],
    );
  }

  /// `Tap Feedback`
  String get tapGeedback {
    return Intl.message(
      'Tap Feedback',
      name: 'tapGeedback',
      desc: '',
      args: [],
    );
  }

  /// `Merits`
  String get meritsAndVirtues {
    return Intl.message(
      'Merits',
      name: 'meritsAndVirtues',
      desc: '',
      args: [],
    );
  }

  /// `Early Birth Son`
  String get earlyBirthSon {
    return Intl.message(
      'Early Birth Son',
      name: 'earlyBirthSon',
      desc: '',
      args: [],
    );
  }

  /// `The MoneyIsRolling`
  String get theMoneyIsRolling {
    return Intl.message(
      'The MoneyIsRolling',
      name: 'theMoneyIsRolling',
      desc: '',
      args: [],
    );
  }

  /// `Every exam must be passed`
  String get everyPass {
    return Intl.message(
      'Every exam must be passed',
      name: 'everyPass',
      desc: '',
      args: [],
    );
  }

  /// `Agree`
  String get agree {
    return Intl.message(
      'Agree',
      name: 'agree',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `version`
  String get version {
    return Intl.message(
      'version',
      name: 'version',
      desc: '',
      args: [],
    );
  }

  /// `Give praise`
  String get givePraise {
    return Intl.message(
      'Give praise',
      name: 'givePraise',
      desc: '',
      args: [],
    );
  }

  /// `Ready to start purchasing`
  String get startShop {
    return Intl.message(
      'Ready to start purchasing',
      name: 'startShop',
      desc: '',
      args: [],
    );
  }

  /// `Purchase failed`
  String get startShopFail {
    return Intl.message(
      'Purchase failed',
      name: 'startShopFail',
      desc: '',
      args: [],
    );
  }

  /// `Purple Sandalwood Fish, Golden Rosewood Wood Fish, White Wood Fish, Light Wood Fish, Blue Wood Fish, Pink Wood Fish, Christmas Wood Fish, Lion Head Wood Fish`
  String get siknNames {
    return Intl.message(
      'Purple Sandalwood Fish, Golden Rosewood Wood Fish, White Wood Fish, Light Wood Fish, Blue Wood Fish, Pink Wood Fish, Christmas Wood Fish, Lion Head Wood Fish',
      name: 'siknNames',
      desc: '',
      args: [],
    );
  }

  /// `"Muyu - chanting artifact" is mainly used to calm inner emotions and prevent impulsiveness. When we provide services to you, we may need to collect and use your account-related information and call account services, store, and read mobile phone status and identity , and a little network information and network service authority, we promise that your personal information will only be used for the purpose we stated. Clicking "Agree" means that you agree to the above content.`
  String get userAgreementTip {
    return Intl.message(
      '"Muyu - chanting artifact" is mainly used to calm inner emotions and prevent impulsiveness. When we provide services to you, we may need to collect and use your account-related information and call account services, store, and read mobile phone status and identity , and a little network information and network service authority, we promise that your personal information will only be used for the purpose we stated. Clicking "Agree" means that you agree to the above content.',
      name: 'userAgreementTip',
      desc: '',
      args: [],
    );
  }

  /// `In Buddhist practice, wooden fish is a commonly used traditional aid to help practitioners focus and maintain rhythm. Although wooden fish is not a real fish, but according to different materials, shapes and uses, it can be There are several types:\n\nSolid Wooden Fish: Solid Wooden Fish: Carved from a single piece of solid wood, usually spherical or oval in shape. They are finely crafted and have a mellow sound.\n\nHollow Wooden Fish: Hollow The wooden fish consists of two hemispherical wooden shells with a hollow interior. This design makes the sound more crisp and loud, suitable for use in large temples or open places.\n\nHand-held wooden fish: The hand-held wooden fish is a small and convenient The wooden fish carried is usually composed of one or two small wooden blocks. Practitioners can hold and tap them to produce sound.\n\nBig wooden fish: Large wooden fish are generally used in temple halls or important ceremonies. Excellent and loud.\n\nSmall wooden fish: Small wooden fish are small in size and are often used in personal practice or small-scale temples.\n\nIt should be noted that these types are just some common types of wooden fish, and may vary due to It varies by region, tradition and personal preference. Regardless of the type of wooden fish used, its purpose is to help the practitioner achieve a state of focus and calm during meditation and chanting.`
  String get introductionInfo {
    return Intl.message(
      'In Buddhist practice, wooden fish is a commonly used traditional aid to help practitioners focus and maintain rhythm. Although wooden fish is not a real fish, but according to different materials, shapes and uses, it can be There are several types:\n\nSolid Wooden Fish: Solid Wooden Fish: Carved from a single piece of solid wood, usually spherical or oval in shape. They are finely crafted and have a mellow sound.\n\nHollow Wooden Fish: Hollow The wooden fish consists of two hemispherical wooden shells with a hollow interior. This design makes the sound more crisp and loud, suitable for use in large temples or open places.\n\nHand-held wooden fish: The hand-held wooden fish is a small and convenient The wooden fish carried is usually composed of one or two small wooden blocks. Practitioners can hold and tap them to produce sound.\n\nBig wooden fish: Large wooden fish are generally used in temple halls or important ceremonies. Excellent and loud.\n\nSmall wooden fish: Small wooden fish are small in size and are often used in personal practice or small-scale temples.\n\nIt should be noted that these types are just some common types of wooden fish, and may vary due to It varies by region, tradition and personal preference. Regardless of the type of wooden fish used, its purpose is to help the practitioner achieve a state of focus and calm during meditation and chanting.',
      name: 'introductionInfo',
      desc: '',
      args: [],
    );
  }

  /// `Wooden Fish-chanting artifact is a practice app that simulates the real wooden fish knocking to help users calm down and decompress. Wooden fish is a magical instrument, which is mostly used for homework and pujas in Buddhism and Taoism. It is said that fish do not match eyes day and night, Therefore, the wood is carved in the shape of a fish, which is used to warn monks to think day and night. There are two shapes: one is a straight fish shape, which is used for porridge and rice, or gathers people and police, and is hung on the corridor of the temple. The other is round. Fish-shaped, used when chanting scriptures, placed on the table. Since Ming and Qing Dynasties, wooden fish has been commonly used in folk music, Teochew opera, and Cantonese opera. The wooden fish has the function of musical instruments in addition to ritual utensils\nOrigin of wooden fish: Master Xuanzang, an eminent monk in the Tang Dynasty When returning from learning scriptures from the Western Regions, passing through the land of Shu, I met an elder and went to his home to have a vegetarian meal. The son of the elder was framed by his stepmother and thrown into the river, where he was swallowed by a big fish. It just so happened that Master Xuanzang wanted to eat fish that day. The victim had no choice but to go out and buy a big fish. While dissecting the fish, he rescued his child from the belly of the fish. Master Xuanzang said: "This is the karma of this child's long-cherished wish to uphold the Buddhist precept of not killing, so although Be swallowed by fish, but not die. The elder said: "Then how can we repay the fish's kindness?" Marshal Xuanzang told him: "The fish sacrificed to save the child should be carved into a fish shape with wood, hung in the Buddhist temple, and knocked every time during the fasting meal, so as to repay the virtue of the big fish." `
  String get aboutInfo {
    return Intl.message(
      'Wooden Fish-chanting artifact is a practice app that simulates the real wooden fish knocking to help users calm down and decompress. Wooden fish is a magical instrument, which is mostly used for homework and pujas in Buddhism and Taoism. It is said that fish do not match eyes day and night, Therefore, the wood is carved in the shape of a fish, which is used to warn monks to think day and night. There are two shapes: one is a straight fish shape, which is used for porridge and rice, or gathers people and police, and is hung on the corridor of the temple. The other is round. Fish-shaped, used when chanting scriptures, placed on the table. Since Ming and Qing Dynasties, wooden fish has been commonly used in folk music, Teochew opera, and Cantonese opera. The wooden fish has the function of musical instruments in addition to ritual utensils\nOrigin of wooden fish: Master Xuanzang, an eminent monk in the Tang Dynasty When returning from learning scriptures from the Western Regions, passing through the land of Shu, I met an elder and went to his home to have a vegetarian meal. The son of the elder was framed by his stepmother and thrown into the river, where he was swallowed by a big fish. It just so happened that Master Xuanzang wanted to eat fish that day. The victim had no choice but to go out and buy a big fish. While dissecting the fish, he rescued his child from the belly of the fish. Master Xuanzang said: "This is the karma of this child\'s long-cherished wish to uphold the Buddhist precept of not killing, so although Be swallowed by fish, but not die. The elder said: "Then how can we repay the fish\'s kindness?" Marshal Xuanzang told him: "The fish sacrificed to save the child should be carved into a fish shape with wood, hung in the Buddhist temple, and knocked every time during the fasting meal, so as to repay the virtue of the big fish." ',
      name: 'aboutInfo',
      desc: '',
      args: [],
    );
  }

  /// `Restore`
  String get restore {
    return Intl.message(
      'Restore',
      name: 'restore',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'hi'),
      Locale.fromSubtags(languageCode: 'ja'),
      Locale.fromSubtags(languageCode: 'ko'),
      Locale.fromSubtags(languageCode: 'th'),
      Locale.fromSubtags(languageCode: 'zh'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'TW'),
    ];
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
