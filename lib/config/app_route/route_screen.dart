import 'package:get/get.dart';
import 'package:test_test_test/config/app_route/route_names.dart';
import '../../features/add_memory/add_memory_screen.dart';
import '../../features/create_account/create_account.dart';
import '../../features/edit_person/edit_person.dart';
import '../../features/edit_profile/edit_profile_Screen.dart';
import '../../features/heart/heart.dart';
import '../../features/home_screen/home_screen.dart';
import '../../features/login/login_screen.dart';
import '../../features/login/widget/forget-password.dart';
import '../../features/login/widget/verify_login.dart';
import '../../features/person_add_memory/person_add_memory.dart';
import '../../features/person_screen/person_screen.dart';
import '../../features/splashscreen/splashscreen.dart';
import 'binding/account_binding.dart';
import 'binding/add_memory_binding.dart';
import 'binding/create_person_binding.dart';
import 'binding/edit_profile_binding.dart';
import 'binding/first_binding.dart';
import 'binding/home_binding.dart';
import 'binding/login_bindings.dart';
import 'binding/person_add.dart';
import 'binding/person_binding.dart';
import 'binding/person_edit_binding.dart';
import 'binding/profile_binding.dart';
import 'binding/search_binding.dart';
import 'binding/splash_binding.dart';


class Pages{
  static List<GetPage<dynamic>>pages=[
    GetPage(name:NamedRoute.routeSplashScreen, page: () =>SplashScreen(),binding:SplashBinding()),
    GetPage(name: NamedRoute.routeHomeScreen, page: () =>HomeScreen(),bindings: [HomeBinding(),FirstBinding(),SearchBinding(),CreatePersonBinding(),ProfileBinding()]),
    GetPage(name: NamedRoute.routePersonScreen, page: () =>PersonScreen(),bindings:[PersonBinding(),CreatePersonBinding()] ),
    GetPage(name: NamedRoute.routePersonEditScreen, page: () =>EditPersonScreen(),bindings: [PersonEditBinding(),PersonBinding()]),
    GetPage(name: NamedRoute.routeAddMemoryScreen, page: () =>AddMemoryScreen(),binding: AddMemoryBinding()),
    GetPage(name: NamedRoute.routePersonAddScreen, page: () =>PersonAddScreen(),binding: PersonAddBinding()),
    GetPage(name: NamedRoute.routeLoginScreen, page: () =>LoginScreen(),binding: LoginBinding()),
    GetPage(name: NamedRoute.routeVerifyLoginScreen, page: () =>VerifyLoginScreen(),binding: LoginBinding()),
    GetPage(name: NamedRoute.routeAccountScreen, page: () =>CreateAccountScreen(),binding: AccountBinding()),
    GetPage(name: NamedRoute.routeHeartScreen, page: () =>HeartScreen()),
    GetPage(name: NamedRoute.routeEditProfiletScreen, page: () =>EditProfileScreen(),binding: EditProfileBinding()),
    GetPage(name: NamedRoute.routeForgetPassword, page: () =>ForgetPassword(),binding: LoginBinding()),
    // GetPage(name: NamedRoute.routeFirstScreen, page: () =>FirstScreen(),binding: FirstBinding()),
    // GetPage(name: NamedRoute.routeSearchScreen, page: () =>SearchScreen(),binding: SearchBinding()),


  ];
}