import 'package:get/get.dart';
import 'package:phone_book/presentation/contact_details/view/contact_details_view.dart';
import 'package:phone_book/presentation/contact_form/view/contact_form_view.dart';
import 'package:phone_book/presentation/contacts/view/contacts_view.dart';
import 'package:phone_book/presentation/login/view/login_view.dart';
import 'package:phone_book/presentation/registration/view/registration_view.dart';
import 'package:phone_book/presentation/splash/view/splash_view.dart';

class AppRouter {
  static const splash = '/';
  static const login = '/login';
  static const registration = '/registration';
  static const contacts = '/contacts';
  static const contact_form = '/contact_form';
  static const contact_detail = '/contact_detail';

  static final List<GetPage> _pages = [
    GetPage(name: splash, page: () => const SplashView()),
    GetPage(name: login, page: () => LoginView()),
    GetPage(name: registration, page: () => const RegistrationView()),
    GetPage(name: contacts, page: () => ContactsView()),
    GetPage(name: contact_form, page: () => const ContactFormView()),
    GetPage(name: contact_detail, page: () => ContactDetailsView()),
  ];

  static List<GetPage> get pages => _pages;
}