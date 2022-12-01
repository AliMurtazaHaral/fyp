
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fyp/providers/locationProvider.dart';
import 'package:fyp/screens/become_mechanic_screen.dart';
import 'package:fyp/screens/camera/camera_screen.dart';
import 'package:fyp/screens/camera/home_page.dart';

import 'package:fyp/screens/dashboard_screen.dart';
import 'package:fyp/screens/face_detection_screen.dart';
import 'package:fyp/screens/home_screen.dart';
import 'package:fyp/screens/login_screen.dart';
import 'package:fyp/screens/login_signup_option_screen.dart';
import 'package:fyp/screens/map_screens/map.dart';
import 'package:fyp/screens/map_screens/map_autocomplete_address/location_controller.dart';
import 'package:fyp/screens/map_screens/polyline_screen.dart';
import 'package:fyp/screens/mechanic_list_screen.dart';
import 'package:fyp/screens/mechanic_screens/mechanic_dashboard_screen.dart';
import 'package:fyp/screens/mechanic_screens/mechanic_earning_screen.dart';
import 'package:fyp/screens/mechanic_screens/mechanic_home_screen.dart';
import 'package:fyp/screens/mechanic_screens/mechanic_inbox_screen.dart';
import 'package:fyp/screens/mechanic_screens/mechanic_profile_screen.dart';
import 'package:fyp/screens/mechanic_screens/mechanic_registration_screen.dart';
import 'package:fyp/screens/mechanic_screens/mechanic_setting_screen.dart';
import 'package:fyp/screens/mechanic_screens/mechanic_update_profile.dart';
import 'package:fyp/screens/notification_to_specific_user.dart';
import 'package:fyp/screens/otp_authentication/login_screen.dart';
import 'package:fyp/screens/payment_methods/stripe_payment.dart';
import 'package:fyp/screens/payment_screen.dart';
import 'package:fyp/screens/profile_screen.dart';
import 'package:fyp/screens/registeration_screen.dart';
import 'package:fyp/screens/registeration_type_screen.dart';
import 'package:fyp/screens/rider_list_screen.dart';
import 'package:fyp/screens/rider_screens/rider_dashboard_screen.dart';
import 'package:fyp/screens/rider_screens/rider_earning_screen.dart';
import 'package:fyp/screens/rider_screens/rider_registration_screen.dart';
import 'package:fyp/screens/rider_screens/rider_setting_screen.dart';
import 'package:fyp/screens/setting_screen.dart';
import 'package:fyp/screens/shop_owner_list_screen.dart';
import 'package:fyp/screens/shop_owner_screens/shop_owner_registration_screen.dart';
import 'package:fyp/screens/shop_product_screen.dart';
import 'package:fyp/screens/splash_screen.dart';
import 'package:fyp/screens/top_rated_product_screen.dart';
import 'package:fyp/screens/top_rated_shops_screen.dart';
import 'package:fyp/screens/update_profile_screen.dart';
import 'package:fyp/screens/vehicle_detection_screen.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = "pk_test_51LfUARDwLhA5VoPRkSD2obwEXXsBH6qht4jukSTQMHQDsijrGktCbqawl9UjJPLLapGOcyQrw34kBkmfP9S6fOlm00H3rvSlUO";
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(LocationController());
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocationProvider>(
          create: (_) => LocationProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/login': (context) => LoginScreen(),
          '/forgetPassword': (context) => const ForgetPasswordScreen(),
          '/registration': (context) => const RegistrationScreen(),
          '/registrationType': (context) => const RegistrationTypeScreen(),
          '/loginSignup': (context) => const SignUpLogin(),
          '/dashboard': (context) => Dashboard(),
          '/home': (context) => const HomeScreen(),
          '/setting': (context) => const SettingScreen(),
          '/profile': (context) => ProfileScreen(),
          '/updateProfile': (context) => const UpdateProfileScreen(),
          '/map': (context) => GoogleMapPage(),
          '/becomeMechanic': (context) => const BecomeMechanicScreen(),
          '/mechanicList': (context) => const MechanicListScreen(),
          '/riderList': (context) => const RiderListScreen(),
          '/shopOwnerList': (context) => const ShopOwnerListScreen(),
          '/productList': (context) => const ShopProductScreen(),
          '/topRatedProducts': (context) => const TopRatedProductScreen(),
          '/topRatedShops': (context) => const TopRatedShopScreen(),
          '/vehicle': (context) => const TopRatedShopScreen(),
          '/vehicleDetection': (context) => DetectScreen(),

          //Mechanic Section
          '/mechanicRegistration': (context) => const MechanicRegistrationScreen(),
          '/mechanicDashboard': (context) => const MechanicDashboardScreen(),
          '/mechanicHome': (context) => const MechanicHomeScreen(),
          '/mechanicInbox': (context) => const MechanicInboxScreen(),
          '/mechanicSetting': (context) => const MechanicSettingScreen(),
          '/updateMechanicProfile': (context) =>
              const UpdateMechanicProfileScreen(),
          '/mechanicProfile': (context) => MechanicProfileScreen(),
          '/mechanicEarning': (context) => const MechanicEarningScreen(),
          //Payment Methods
          '/paymentJazzCash': (context) => const PaymentSceen(),
          '/paymentStripe': (context) => const StripePayment(),

          //Rider Section
          '/riderRegistration': (context) => RiderRegistrationScreen(),
          '/riderDashboard': (context) => RiderDashboardScreen(),
          '/riderSetting': (context) => RiderSettingScreen(),
          '/riderEarning': (context) => RiderEarningScreen(),

          //Shop Owner Section
          '/shopOwnerRegistration': (context) => ShopOwnerRegistrationScreen(),
        },
      ),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: OpenStreetMapSearchAndPick(
            center: LatLong(23, 89),
            buttonColor: Colors.blue,
            buttonText: 'Set Current Location',
            onPicked: (pickedData) {
              print(pickedData.latLong.latitude);
              print(pickedData.latLong.longitude);
              print(pickedData.address);
            }));
  }
}
/*void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  MyApp({required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(
            firebaseAuth: FirebaseAuth.instance,
            googleSignIn: GoogleSignIn(),
            prefs: this.prefs,
            firebaseFirestore: this.firebaseFirestore,
          ),
        ),
        Provider<SettingProvider>(
          create: (_) => SettingProvider(
            prefs: this.prefs,
            firebaseFirestore: this.firebaseFirestore,
            firebaseStorage: this.firebaseStorage,
          ),
        ),
        Provider<HomeProvider>(
          create: (_) => HomeProvider(
            firebaseFirestore: this.firebaseFirestore,
          ),
        ),
        Provider<ChatProvider>(
          create: (_) => ChatProvider(
            prefs: this.prefs,
            firebaseFirestore: this.firebaseFirestore,
            firebaseStorage: this.firebaseStorage,
          ),
        ),
      ],
      child: MaterialApp(
        title: AppConstants.appTitle,
        theme: ThemeData(
          primaryColor: ColorConstants.themeColor,
        ),
        home: SplashPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}*/
