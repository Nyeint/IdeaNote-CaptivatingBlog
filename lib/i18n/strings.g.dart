/// Generated file. Do not edit.
///
/// Locales: 2
/// Strings: 76 (38 per locale)
///
/// Built on 2023-08-05 at 14:34 UTC

// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:flutter/widgets.dart';
import 'package:slang/builder/model/node.dart';
import 'package:slang_flutter/slang_flutter.dart';
export 'package:slang_flutter/slang_flutter.dart';

const AppLocale _baseLocale = AppLocale.en;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale with BaseAppLocale<AppLocale, _StringsEn> {
	en(languageCode: 'en', build: _StringsEn.build),
	my(languageCode: 'my', build: _StringsMy.build);

	const AppLocale({required this.languageCode, this.scriptCode, this.countryCode, required this.build}); // ignore: unused_element

	@override final String languageCode;
	@override final String? scriptCode;
	@override final String? countryCode;
	@override final TranslationBuilder<AppLocale, _StringsEn> build;

	/// Gets current instance managed by [LocaleSettings].
	_StringsEn get translations => LocaleSettings.instance.translationMap[this]!;
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
/// Configurable via 'translate_var'.
///
/// Usage:
/// String a = t.someKey.anotherKey;
/// String b = t['someKey.anotherKey']; // Only for edge cases!
_StringsEn get t => LocaleSettings.instance.currentTranslations;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
/// String b = t['someKey.anotherKey']; // Only for edge cases!
class Translations {
	Translations._(); // no constructor

	static _StringsEn of(BuildContext context) => InheritedLocaleData.of<AppLocale, _StringsEn>(context).translations;
}

/// The provider for method B
class TranslationProvider extends BaseTranslationProvider<AppLocale, _StringsEn> {
	TranslationProvider({required super.child}) : super(settings: LocaleSettings.instance);

	static InheritedLocaleData<AppLocale, _StringsEn> of(BuildContext context) => InheritedLocaleData.of<AppLocale, _StringsEn>(context);
}

/// Method B shorthand via [BuildContext] extension method.
/// Configurable via 'translate_var'.
///
/// Usage (e.g. in a widget's build method):
/// context.t.someKey.anotherKey
extension BuildContextTranslationsExtension on BuildContext {
	_StringsEn get t => TranslationProvider.of(this).translations;
}

/// Manages all translation instances and the current locale
class LocaleSettings extends BaseFlutterLocaleSettings<AppLocale, _StringsEn> {
	LocaleSettings._() : super(utils: AppLocaleUtils.instance);

	static final instance = LocaleSettings._();

	// static aliases (checkout base methods for documentation)
	static AppLocale get currentLocale => instance.currentLocale;
	static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
	static AppLocale setLocale(AppLocale locale, {bool? listenToDeviceLocale = false}) => instance.setLocale(locale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale setLocaleRaw(String rawLocale, {bool? listenToDeviceLocale = false}) => instance.setLocaleRaw(rawLocale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale useDeviceLocale() => instance.useDeviceLocale();
	@Deprecated('Use [AppLocaleUtils.supportedLocales]') static List<Locale> get supportedLocales => instance.supportedLocales;
	@Deprecated('Use [AppLocaleUtils.supportedLocalesRaw]') static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
	static void setPluralResolver({String? language, AppLocale? locale, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver}) => instance.setPluralResolver(
		language: language,
		locale: locale,
		cardinalResolver: cardinalResolver,
		ordinalResolver: ordinalResolver,
	);
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, _StringsEn> {
	AppLocaleUtils._() : super(baseLocale: _baseLocale, locales: AppLocale.values);

	static final instance = AppLocaleUtils._();

	// static aliases (checkout base methods for documentation)
	static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
	static AppLocale parseLocaleParts({required String languageCode, String? scriptCode, String? countryCode}) => instance.parseLocaleParts(languageCode: languageCode, scriptCode: scriptCode, countryCode: countryCode);
	static AppLocale findDeviceLocale() => instance.findDeviceLocale();
	static List<Locale> get supportedLocales => instance.supportedLocales;
	static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
}

// translations

// Path: <root>
class _StringsEn implements BaseTranslations<AppLocale, _StringsEn> {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsEn.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, _StringsEn> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final _StringsEn _root = this; // ignore: unused_field

	// Translations
	late final _StringsAuthEn auth = _StringsAuthEn._(_root);
	late final _StringsBlogEn blog = _StringsBlogEn._(_root);
}

// Path: auth
class _StringsAuthEn {
	_StringsAuthEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get login => 'Log In';
	String get signup => 'Sign Up';
	String get logout => 'Log Out';
	String get forgot_password => 'Forgot Password';
	String get reset_password => 'Reset Password';
	String get change_password => 'Change Password';
	String get create_account => 'Create account?';
	String get first_name => 'First Name';
	String get last_name => 'Last Name';
	String get account_name => 'Account Name';
	String user_name({required Object name}) => 'user name is ${name} .';
	String get you_can_change_it_later => 'You can change it later';
	String get password => 'Password';
	String get confirm_password => 'Confirmation Password';
	String get password_not_match => 'Confirmation Password does not match';
	String get password_length => 'Password length must be at least 8 characters';
	String get email => 'Your Email';
	String enter_data({required Object data}) => 'Enter ${data}';
	String get user_name_invalid => 'Enter valid user name (First Name and Last Name should not contains any special characters, symbols or spaces)';
	String get already_have_account => 'Already have an account?';
	String get forgot_password_des => 'Please provide the email address that you used when you signed up for your account.';
	String get back_to_login => 'Back to login';
	String get locale => 'English';
	String get welcome_back => 'Welcome Back !';
}

// Path: blog
class _StringsBlogEn {
	_StringsBlogEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get name => 'Name';
	String get language => 'Language';
	String get theme => 'Theme';
	String get locale => 'English';
	String get edit => 'Edit';
	String get delete => 'Delete';
	String get cancel => 'Cancel';
	String get no_blog => 'No Blog';
	String get title => 'Title';
	String get content => 'Content';
	String get save => 'Save';
	String get sure_delete => 'Are you sure you want to delete?';
	String get sure_logout => 'Are you sure you want to log out?';
	String enter_data({required Object data}) => 'Enter ${data}';
}

// Path: <root>
class _StringsMy implements _StringsEn {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsMy.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.my,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <my>.
	@override final TranslationMetadata<AppLocale, _StringsEn> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	@override late final _StringsMy _root = this; // ignore: unused_field

	// Translations
	@override late final _StringsAuthMy auth = _StringsAuthMy._(_root);
	@override late final _StringsBlogMy blog = _StringsBlogMy._(_root);
}

// Path: auth
class _StringsAuthMy implements _StringsAuthEn {
	_StringsAuthMy._(this._root);

	@override final _StringsMy _root; // ignore: unused_field

	// Translations
	@override String get login => 'အကောင့်ဝင်မည်';
	@override String get signup => 'အကောင့်ဖွင့်မည်';
	@override String get logout => 'အကောင့်ထွက်မည်';
	@override String get forgot_password => 'စကားဝှက်မေ့နေပါသလား?';
	@override String get reset_password => 'စကားဝှက်ကို ပြန်လည်သတ်မှတ်မည်';
	@override String get change_password => 'စကားဝှက်ကိုပြောင်းရန်';
	@override String get create_account => 'အကောင့်ပြုလုပ်လိုပါသလား?';
	@override String get first_name => 'ပထမအမည်';
	@override String get last_name => 'နောက်ဆုံးအမည်';
	@override String get account_name => 'အကောင့်အမည်';
	@override String user_name({required Object name}) => 'အသုံးပြုသူအမည်မှာ ${name} ဖြစ်ပါတယ်';
	@override String get you_can_change_it_later => 'နောက်မှပြန်ပြောင်းလို့ရပါတယ်';
	@override String get password => 'စကားဝှက်';
	@override String get confirm_password => 'အတည်ပြုစကားဝှက်';
	@override String get password_not_match => 'အတည်ပြုစကားဝှက်နှင့် မကိုက်ညီပါ';
	@override String get password_length => 'စကားဝှက်အရေအတွက်သည် အနည်းဆုံး စာလုံး ၈ လုံးရှိရမည်';
	@override String get email => 'သင့်အီးမေးလ်';
	@override String enter_data({required Object data}) => '${data} ထည့်ပါ';
	@override String get user_name_invalid => 'တရားဝင်အသုံးပြုသူအမည်ကို ထည့်သွင်းပါ (ပထမအမည်နှင့် နောက်ဆုံးအမည်တွင် အထူးအက္ခရာများ၊ သင်္ကေတများ သို့မဟုတ် နေရာလွတ်များ မပါဝင်သင့်ပါ)';
	@override String get already_have_account => 'အကောင့်ရှိပြီးသားလား?';
	@override String get forgot_password_des => 'ကျေးဇူးပြု၍ သင့်အကောင့်အတွက် စာရင်းသွင်းသည့်အခါ သင်အသုံးပြုခဲ့သည့် အီးမေးလ်လိပ်စာကို ပေးပါ။';
	@override String get back_to_login => 'အကောင့်ဝင်ရန် သို့ ပြန်သွားရန်';
	@override String get locale => 'ဗမာ';
	@override String get welcome_back => 'ကြိုဆိုပါတယ်';
}

// Path: blog
class _StringsBlogMy implements _StringsBlogEn {
	_StringsBlogMy._(this._root);

	@override final _StringsMy _root; // ignore: unused_field

	// Translations
	@override String get name => 'နာမည်';
	@override String get language => 'ဘာသာစကား';
	@override String get theme => 'အပြင်အဆင်';
	@override String get locale => 'ဗမာ';
	@override String get edit => 'ပြင်ဆင်ရန်';
	@override String get delete => 'ဖျက်ရန်';
	@override String get cancel => 'ပယ်ဖျက်ပါ';
	@override String get no_blog => 'ဘလော့မရှိပါ';
	@override String get title => 'ခေါင်းစဥ်';
	@override String get content => 'အကြောင်းအရာ';
	@override String get save => 'သိမ်းဆည်းပါ';
	@override String get sure_delete => 'ဖျက်ချင်တာ သေချာပါသလား';
	@override String get sure_logout => 'အကောင့်ထွက်ချင်သည်မှာ သေချာပါသလား';
	@override String enter_data({required Object data}) => '${data} ထည့်ပါ';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on _StringsEn {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'auth.login': return 'Log In';
			case 'auth.signup': return 'Sign Up';
			case 'auth.logout': return 'Log Out';
			case 'auth.forgot_password': return 'Forgot Password';
			case 'auth.reset_password': return 'Reset Password';
			case 'auth.change_password': return 'Change Password';
			case 'auth.create_account': return 'Create account?';
			case 'auth.first_name': return 'First Name';
			case 'auth.last_name': return 'Last Name';
			case 'auth.account_name': return 'Account Name';
			case 'auth.user_name': return ({required Object name}) => 'user name is ${name} .';
			case 'auth.you_can_change_it_later': return 'You can change it later';
			case 'auth.password': return 'Password';
			case 'auth.confirm_password': return 'Confirmation Password';
			case 'auth.password_not_match': return 'Confirmation Password does not match';
			case 'auth.password_length': return 'Password length must be at least 8 characters';
			case 'auth.email': return 'Your Email';
			case 'auth.enter_data': return ({required Object data}) => 'Enter ${data}';
			case 'auth.user_name_invalid': return 'Enter valid user name (First Name and Last Name should not contains any special characters, symbols or spaces)';
			case 'auth.already_have_account': return 'Already have an account?';
			case 'auth.forgot_password_des': return 'Please provide the email address that you used when you signed up for your account.';
			case 'auth.back_to_login': return 'Back to login';
			case 'auth.locale': return 'English';
			case 'auth.welcome_back': return 'Welcome Back !';
			case 'blog.name': return 'Name';
			case 'blog.language': return 'Language';
			case 'blog.theme': return 'Theme';
			case 'blog.locale': return 'English';
			case 'blog.edit': return 'Edit';
			case 'blog.delete': return 'Delete';
			case 'blog.cancel': return 'Cancel';
			case 'blog.no_blog': return 'No Blog';
			case 'blog.title': return 'Title';
			case 'blog.content': return 'Content';
			case 'blog.save': return 'Save';
			case 'blog.sure_delete': return 'Are you sure you want to delete?';
			case 'blog.sure_logout': return 'Are you sure you want to log out?';
			case 'blog.enter_data': return ({required Object data}) => 'Enter ${data}';
			default: return null;
		}
	}
}

extension on _StringsMy {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'auth.login': return 'အကောင့်ဝင်မည်';
			case 'auth.signup': return 'အကောင့်ဖွင့်မည်';
			case 'auth.logout': return 'အကောင့်ထွက်မည်';
			case 'auth.forgot_password': return 'စကားဝှက်မေ့နေပါသလား?';
			case 'auth.reset_password': return 'စကားဝှက်ကို ပြန်လည်သတ်မှတ်မည်';
			case 'auth.change_password': return 'စကားဝှက်ကိုပြောင်းရန်';
			case 'auth.create_account': return 'အကောင့်ပြုလုပ်လိုပါသလား?';
			case 'auth.first_name': return 'ပထမအမည်';
			case 'auth.last_name': return 'နောက်ဆုံးအမည်';
			case 'auth.account_name': return 'အကောင့်အမည်';
			case 'auth.user_name': return ({required Object name}) => 'အသုံးပြုသူအမည်မှာ ${name} ဖြစ်ပါတယ်';
			case 'auth.you_can_change_it_later': return 'နောက်မှပြန်ပြောင်းလို့ရပါတယ်';
			case 'auth.password': return 'စကားဝှက်';
			case 'auth.confirm_password': return 'အတည်ပြုစကားဝှက်';
			case 'auth.password_not_match': return 'အတည်ပြုစကားဝှက်နှင့် မကိုက်ညီပါ';
			case 'auth.password_length': return 'စကားဝှက်အရေအတွက်သည် အနည်းဆုံး စာလုံး ၈ လုံးရှိရမည်';
			case 'auth.email': return 'သင့်အီးမေးလ်';
			case 'auth.enter_data': return ({required Object data}) => '${data} ထည့်ပါ';
			case 'auth.user_name_invalid': return 'တရားဝင်အသုံးပြုသူအမည်ကို ထည့်သွင်းပါ (ပထမအမည်နှင့် နောက်ဆုံးအမည်တွင် အထူးအက္ခရာများ၊ သင်္ကေတများ သို့မဟုတ် နေရာလွတ်များ မပါဝင်သင့်ပါ)';
			case 'auth.already_have_account': return 'အကောင့်ရှိပြီးသားလား?';
			case 'auth.forgot_password_des': return 'ကျေးဇူးပြု၍ သင့်အကောင့်အတွက် စာရင်းသွင်းသည့်အခါ သင်အသုံးပြုခဲ့သည့် အီးမေးလ်လိပ်စာကို ပေးပါ။';
			case 'auth.back_to_login': return 'အကောင့်ဝင်ရန် သို့ ပြန်သွားရန်';
			case 'auth.locale': return 'ဗမာ';
			case 'auth.welcome_back': return 'ကြိုဆိုပါတယ်';
			case 'blog.name': return 'နာမည်';
			case 'blog.language': return 'ဘာသာစကား';
			case 'blog.theme': return 'အပြင်အဆင်';
			case 'blog.locale': return 'ဗမာ';
			case 'blog.edit': return 'ပြင်ဆင်ရန်';
			case 'blog.delete': return 'ဖျက်ရန်';
			case 'blog.cancel': return 'ပယ်ဖျက်ပါ';
			case 'blog.no_blog': return 'ဘလော့မရှိပါ';
			case 'blog.title': return 'ခေါင်းစဥ်';
			case 'blog.content': return 'အကြောင်းအရာ';
			case 'blog.save': return 'သိမ်းဆည်းပါ';
			case 'blog.sure_delete': return 'ဖျက်ချင်တာ သေချာပါသလား';
			case 'blog.sure_logout': return 'အကောင့်ထွက်ချင်သည်မှာ သေချာပါသလား';
			case 'blog.enter_data': return ({required Object data}) => '${data} ထည့်ပါ';
			default: return null;
		}
	}
}
