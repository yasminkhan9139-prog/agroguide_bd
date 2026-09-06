import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/expert/expert_questions_screen.dart';
void main() {
  runApp(const AgroGuideApp());
}

// ============================================================
// APP
// ============================================================

class AgroGuideApp extends StatelessWidget {
  const AgroGuideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AgroGuide BD',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'sans',
        scaffoldBackgroundColor: const Color(0xFFF3FBF5),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF218838),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2E8B35),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFFE0E0E0),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFFE0E0E0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFF218838),
              width: 1.5,
            ),
          ),
        ),
      ),
      home: const StartScreen(),
    );
  }
}

// ============================================================
// USER MODEL
// ============================================================

class User {
  final String name;
  final String phone;
  final String password;
  final String district;

  const User({
    required this.name,
    required this.phone,
    required this.password,
    required this.district,
  });

  User copyWith({
    String? name,
    String? phone,
    String? password,
    String? district,
  }) {
    return User(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      district: district ?? this.district,
    );
  }
}

// ============================================================
// BANGLADESH DISTRICTS
// ============================================================

const List<String> districts = [
  'ঢাকা',
  'গাজীপুর',
  'টাঙ্গাইল',
  'ময়মনসিংহ',
  'কিশোরগঞ্জ',
  'নরসিংদী',
  'নারায়ণগঞ্জ',
  'মানিকগঞ্জ',
  'মুন্সিগঞ্জ',
  'ফরিদপুর',
  'গোপালগঞ্জ',
  'মাদারীপুর',
  'রাজবাড়ী',
  'শরীয়তপুর',
  'চট্টগ্রাম',
  'কক্সবাজার',
  'কুমিল্লা',
  'ফেনী',
  'নোয়াখালী',
  'চাঁদপুর',
  'লক্ষ্মীপুর',
  'ব্রাহ্মণবাড়িয়া',
  'সিলেট',
  'মৌলভীবাজার',
  'হবিগঞ্জ',
  'সুনামগঞ্জ',
  'রাজশাহী',
  'নাটোর',
  'নওগাঁ',
  'চাঁপাইনবাবগঞ্জ',
  'পাবনা',
  'সিরাজগঞ্জ',
  'বগুড়া',
  'জয়পুরহাট',
  'খুলনা',
  'বাগেরহাট',
  'সাতক্ষীরা',
  'যশোর',
  'নড়াইল',
  'মাগুরা',
  'কুষ্টিয়া',
  'চুয়াডাঙ্গা',
  'মেহেরপুর',
  'বরিশাল',
  'ভোলা',
  'পটুয়াখালী',
  'ঝালকাঠি',
  'পিরোজপুর',
  'বরগুনা',
  'রংপুর',
  'দিনাজপুর',
  'কুড়িগ্রাম',
  'গাইবান্ধা',
  'লালমনিরহাট',
  'নীলফামারী',
  'পঞ্চগড়',
  'ঠাকুরগাঁও',
];

// ============================================================
// LOCAL STORAGE
// ============================================================

Future<User?> loadUser() async {
  final prefs = await SharedPreferences.getInstance();

  final loggedIn = prefs.getBool('loggedIn') ?? false;

  if (!loggedIn) return null;

  final name = prefs.getString('name');
  final phone = prefs.getString('phone');
  final password = prefs.getString('password');
  final district = prefs.getString('district');

  if (name == null ||
      phone == null ||
      password == null ||
      district == null) {
    return null;
  }

  return User(
    name: name,
    phone: phone,
    password: password,
    district: district,
  );
}

Future<void> saveUser(User user) async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setString('name', user.name);
  await prefs.setString('phone', user.phone);
  await prefs.setString('password', user.password);
  await prefs.setString('district', user.district);
  await prefs.setBool('loggedIn', true);
}

Future<void> logoutUser() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('loggedIn', false);
}

// ============================================================
// START SCREEN
// ============================================================

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  Future<void> checkLogin() async {
    final user = await loadUser();

    if (!mounted) return;

    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => MainScreen(user: user),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Color(0xFF218838),
        ),
      ),
    );
  }
}

// ============================================================
// LOGO
// ============================================================

Widget agroLogo({double size = 70}) {
  return Column(
    children: [
      Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: const Color(0xFFE1F5E7),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFF9AD9AA),
          ),
        ),
        child: Icon(
          Icons.eco,
          size: size * .55,
          color: const Color(0xFF218838),
        ),
      ),
      const SizedBox(height: 10),
      const Text(
        'AgroGuide BD',
        style: TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.bold,
          color: Color(0xFF218838),
        ),
      ),
      const Text(
        'স্মার্ট কৃষি সহকারী',
        style: TextStyle(
          color: Color(0xFFE89A22),
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}

// ============================================================
// LOGIN
// ============================================================

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscure = true;

  Future<void> login() async {
    final phone = phoneController.text.trim();
    final password = passwordController.text.trim();

    if (phone.isEmpty || password.isEmpty) {
      showSnack('মোবাইল নম্বর এবং পাসওয়ার্ড দিন');
      return;
    }

    final prefs = await SharedPreferences.getInstance();

    final savedPhone = prefs.getString('phone');
    final savedPassword = prefs.getString('password');

    if (savedPhone == phone && savedPassword == password) {
      final user = await loadUser();

      if (user != null && mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => MainScreen(user: user),
          ),
        );
      }
    } else {
      showSnack('মোবাইল নম্বর অথবা পাসওয়ার্ড সঠিক নয়');
    }
  }

  void showSnack(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: Column(
              children: [
                const SizedBox(height: 25),

                agroLogo(),

                const SizedBox(height: 28),

                const Text(
                  'লগইন করুন',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 25),

                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'মোবাইল নম্বর',
                    prefixIcon: Icon(Icons.phone),
                  ),
                ),

                const SizedBox(height: 15),

                TextField(
                  controller: passwordController,
                  obscureText: obscure,
                  decoration: InputDecoration(
                    labelText: 'পাসওয়ার্ড',
                    prefixIcon:
                        const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscure = !obscure;
                        });
                      },
                      icon: Icon(
                        obscure
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      showSnack(
                        'পাসওয়ার্ড পুনরুদ্ধার সুবিধা শীঘ্রই আসছে',
                      );
                    },
                    child: const Text(
                      'পাসওয়ার্ড ভুলে গেছেন?',
                    ),
                  ),
                ),

                const SizedBox(height: 5),

                primaryButton(
                  'প্রবেশ করুন',
                  login,
                ),

                const SizedBox(height: 18),

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    const Text(
                      'নতুন অ্যাকাউন্ট করতে চান? ',
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const RegisterScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'নিবন্ধন করুন',
                        style: TextStyle(
                          color: Color(0xFF218838),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// REGISTER
// ============================================================

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() =>
      _RegisterScreenState();
}

class _RegisterScreenState
    extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  String selectedDistrict = districts[0];

  bool obscure = true;

  Future<void> register() async {
    final name = nameController.text.trim();
    final phone = phoneController.text.trim();
    final password = passwordController.text.trim();

    if (name.isEmpty ||
        phone.isEmpty ||
        password.isEmpty) {
      showSnack('সব তথ্য পূরণ করুন');
      return;
    }

    if (phone.length < 10) {
      showSnack('সঠিক মোবাইল নম্বর দিন');
      return;
    }

    if (password.length < 4) {
      showSnack(
        'পাসওয়ার্ড কমপক্ষে ৪ অক্ষরের হতে হবে',
      );
      return;
    }

    final user = User(
      name: name,
      phone: phone,
      password: password,
      district: selectedDistrict,
    );

    await saveUser(user);

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => MainScreen(user: user),
      ),
      (route) => false,
    );
  }

  void showSnack(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('নিবন্ধন করুন'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: Column(
            children: [
              agroLogo(size: 60),

              const SizedBox(height: 25),

              const Text(
                'অ্যাকাউন্ট তৈরি করুন',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 22),

              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'আপনার নাম',
                  prefixIcon:
                      Icon(Icons.person_outline),
                ),
              ),

              const SizedBox(height: 14),

              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'মোবাইল নম্বর',
                  prefixIcon: Icon(Icons.phone),
                ),
              ),

              const SizedBox(height: 14),

              TextField(
                controller: passwordController,
                obscureText: obscure,
                decoration: InputDecoration(
                  labelText: 'পাসওয়ার্ড',
                  prefixIcon:
                      const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscure = !obscure;
                      });
                    },
                    icon: Icon(
                      obscure
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              DropdownButtonFormField<String>(
                value: selectedDistrict,
                decoration: const InputDecoration(
                  labelText: 'জেলা / অবস্থান',
                  prefixIcon:
                      Icon(Icons.location_on_outlined),
                ),
                items: districts
                    .map(
                      (district) =>
                          DropdownMenuItem(
                        value: district,
                        child: Text(district),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;

                  setState(() {
                    selectedDistrict = value;
                  });
                },
              ),

              const SizedBox(height: 22),

              primaryButton(
                'নিবন্ধন সম্পন্ন করুন',
                register,
              ),

              const SizedBox(height: 15),

              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'ইতিমধ্যে অ্যাকাউন্ট আছে? লগইন করুন',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// MAIN SCREEN
// ============================================================

class MainScreen extends StatefulWidget {
  final User user;

  const MainScreen({
    super.key,
    required this.user,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late User user;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  void updateUser(User updatedUser) {
    setState(() {
      user = updatedUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(
        user: user,
        onExpert: () {
          setState(() {
            currentIndex = 1;
          });
        },
      ),
      const CropScreen(),
      MarketScreen(
        district: user.district,
      ),
      ProfileScreen(
        user: user,
        onUpdate: updateUser,
        onLogout: () async {
          await logoutUser();

          if (!mounted) return;

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => const LoginScreen(),
            ),
            (route) => false,
          );
        },
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor:
            const Color(0xFF218838),
        unselectedItemColor:
            Colors.grey,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'হোম',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            activeIcon: Icon(Icons.menu_book),
            label: 'পরামর্শ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store_outlined),
            activeIcon: Icon(Icons.store),
            label: 'Market',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'প্রোফাইল',
          ),
        ],
      ),
    );
  }
}

// ============================================================
// HOME
// ============================================================

class HomeScreen extends StatelessWidget {
  final User user;
  final VoidCallback onExpert;

  const HomeScreen({
    super.key,
    required this.user,
    required this.onExpert,
  });

  @override
  Widget build(BuildContext context) {
    final temperature =
        getTemperature(user.district);

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 27,
                backgroundColor:
                    const Color(0xFFDDF2E3),
                child: Text(
                  user.name.isNotEmpty
                      ? user.name[0].toUpperCase()
                      : 'ক',
                  style: const TextStyle(
                    color: Color(0xFF218838),
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      'স্বাগতম, ${user.name}',
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 15,
                          color: Color(0xFF218838),
                        ),
                        Text(user.district),
                      ],
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.notifications_none,
                color: Color(0xFF218838),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Warning
          Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF4E4),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFFFB45C),
              ),
            ),
            child: const Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.warning_amber,
                  color: Colors.orange,
                ),
                SizedBox(width: 9),
                Expanded(
                  child: Text(
                    'পোকামাকড় বা রোগের লক্ষণ দেখা দিলে দ্রুত ব্যবস্থা নিন।',
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          // Weather
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Color(0xFF218838),
                  ),
                  const SizedBox(width: 7),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.district,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'আজকের আবহাওয়া',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '$temperature°C',
                    style: const TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 7),
                  const Icon(
                    Icons.cloud_outlined,
                    color: Color(0xFF218838),
                    size: 35,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 17),

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'মৌসুমি ফসল',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('সব দেখুন'),
              ),
            ],
          ),

          SizedBox(
            height: 145,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                CropMiniCard(
                  crop: 'আমন ধান',
                  subtitle: 'ধান চাষ',
                  icon: Icons.grass,
                ),
                CropMiniCard(
                  crop: 'পাট',
                  subtitle: 'পাট চাষ',
                  icon: Icons.eco,
                ),
                CropMiniCard(
                  crop: 'সবজি চাষ',
                  subtitle: 'সবজি',
                  icon: Icons.local_florist,
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          const Text(
            'কৃষক কমিউনিটি',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 9),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text(
                    '“আমার ধানের পাতা হলুদ হয়ে যাচ্ছে, এখন কি করা উচিত?”',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 9),
                  const Text(
                    'মাটির অবস্থা পরীক্ষা করুন এবং অতিরিক্ত পানি থাকলে নিষ্কাশনের ব্যবস্থা করুন।',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 14),

          SizedBox(
            height: 52,
            child: ElevatedButton.icon(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
       builder: (context) => const ExpertScreen(),
      ),
    );
  },
  icon: const Icon(
    Icons.support_agent,
  ),
  label: const Text(
    'বিশেষজ্ঞকে জিজ্ঞাসা করুন',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFF087F23),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(25),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// MINI CROP CARD
// ============================================================

class CropMiniCard extends StatelessWidget {
  final String crop;
  final String subtitle;
  final IconData icon;

  const CropMiniCard({
    super.key,
    required this.crop,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 145,
      margin: const EdgeInsets.only(right: 10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 27,
                backgroundColor:
                    const Color(0xFFE1F5E7),
                child: Icon(
                  icon,
                  color: const Color(0xFF218838),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                crop,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// CROP SCREEN
// ============================================================

class CropScreen extends StatelessWidget {
  const CropScreen({super.key});

  final List<Map<String, String>> crops = const [
    {
      'name': 'ধান',
      'problem': 'ধানের পাতা পোড়া রোগ প্রতিরোধ',
    },
    {
      'name': 'ধান',
      'problem': 'ধানের ব্লাস্ট রোগ দমন',
    },
    {
      'name': 'সবজি',
      'problem': 'টমেটোর ফল ছিদ্রকারী পোকা',
    },
    {
      'name': 'ভুট্টা',
      'problem': 'ভুট্টার পাতার রোগ ও পোকামাকড়',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'ফসল পরামর্শ',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'আপনার ফসলের সমস্যা ও সমাধান খুঁজুন',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 15),

          TextField(
            decoration: InputDecoration(
              hintText: 'পরামর্শ খুঁজুন...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 14),

          Wrap(
            spacing: 8,
            children: [
              filterChip('সব', true),
              filterChip('ধান', false),
              filterChip('গম', false),
              filterChip('সবজি', false),
              filterChip('ফল', false),
            ],
          ),

          const SizedBox(height: 14),

          ...crops.map(
            (crop) => Card(
              margin: const EdgeInsets.only(
                bottom: 11,
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor:
                      const Color(0xFFE1F5E7),
                  child: const Icon(
                    Icons.grass,
                    color: Color(0xFF218838),
                  ),
                ),
                title: Text(
                  crop['name']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  crop['problem']!,
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          CropDetailScreen(
                        crop: crop['name']!,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget filterChip(
    String text,
    bool selected,
  ) {
    return Chip(
      label: Text(text),
      backgroundColor: selected
          ? const Color(0xFF218838)
          : Colors.white,
      labelStyle: TextStyle(
        color: selected
            ? Colors.white
            : Colors.black,
      ),
    );
  }
}

// ============================================================
// CROP DETAIL
// ============================================================

class CropDetailScreen extends StatelessWidget {
  final String crop;

  const CropDetailScreen({
    super.key,
    required this.crop,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$crop সম্পর্কিত'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: const Color(0xFFDDEFE1),
              borderRadius:
                  BorderRadius.circular(15),
            ),
            child: const Icon(
              Icons.agriculture,
              size: 80,
              color: Color(0xFF218838),
            ),
          ),

          const SizedBox(height: 15),

          const Text(
            'রোপণ নির্দেশিকা',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Color(0xFF218838),
            ),
          ),

          const SizedBox(height: 7),

          const Text(
            'উপযুক্ত মাটি নির্বাচন করুন এবং জমি ভালোভাবে প্রস্তুত করুন। সঠিক সময়ে বীজ বপন বা চারা রোপণ করুন।',
          ),

          const SizedBox(height: 15),

          infoSection(
            'সার ব্যবস্থাপনা',
            'মাটির উর্বরতা অনুযায়ী সুষম সার ব্যবহার করুন। প্রয়োজন অনুযায়ী ইউরিয়া ও অন্যান্য পুষ্টি উপাদান প্রয়োগ করুন।',
          ),

          infoSection(
            'সেচ ব্যবস্থাপনা',
            'ফসলের বৃদ্ধির পর্যায় অনুযায়ী সেচ দিন এবং জমিতে অতিরিক্ত পানি জমতে দেবেন না।',
          ),

          infoSection(
            'রোগ ও পোকামাকড়',
            'নিয়মিত ফসল পর্যবেক্ষণ করুন। রোগ বা পোকামাকড়ের লক্ষণ দেখা দিলে দ্রুত ব্যবস্থা নিন।',
          ),

          infoSection(
            'ফসল সংগ্রহ',
            'ফসল উপযুক্ত পরিপক্বতায় পৌঁছালে সংগ্রহ করুন এবং শুকনো ও নিরাপদ স্থানে সংরক্ষণ করুন।',
          ),
        ],
      ),
    );
  }

  Widget infoSection(
    String title,
    String text,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 11),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF218838),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 7),
            Text(text),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// MARKET
// ============================================================

class MarketScreen extends StatelessWidget {
  final String district;

  const MarketScreen({
    super.key,
    required this.district,
  });

  List<Map<String, String>> prices() {
    final base = district.codeUnits.fold(
          0,
          (sum, code) => sum + code,
        ) %
        8;

    return [
      {
        'crop': 'বোরো ধান',
        'price': '৳ ${42 + base}/kg',
        'change': '+1.2%',
      },
      {
        'crop': 'পাট',
        'price': '৳ ${78 + base}/kg',
        'change': '-0.8%',
      },
      {
        'crop': 'গম',
        'price': '৳ ${36 + base}/kg',
        'change': '+2.4%',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final marketPrices = prices();

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Market Prices',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Icon(
                Icons.notifications_none,
                color: Color(0xFF218838),
              ),
            ],
          ),

          Text(
            '$district - Real-time crop rate tracker',
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 15),

          TextField(
            decoration: InputDecoration(
              hintText: 'ফসলের নাম খুঁজুন',
              prefixIcon:
                  const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 15),

          Row(
            children: [
              chip('All Markets', true),
              const SizedBox(width: 7),
              chip('$district বাজার', false),
            ],
          ),

          const SizedBox(height: 17),

          const Text(
            'Popular Crops Today',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),

          const SizedBox(height: 9),

          ...marketPrices.map(
            (item) => Card(
              margin: const EdgeInsets.only(
                bottom: 9,
              ),
              child: ListTile(
                title: Text(
                  item['crop']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  '$district বাজার',
                ),
                trailing: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  crossAxisAlignment:
                      CrossAxisAlignment.end,
                  children: [
                    Text(
                      item['price']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      item['change']!,
                      style: TextStyle(
                        color: item['change']!
                                .startsWith('+')
                            ? Colors.green
                            : Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'Market Variations',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),

          const SizedBox(height: 9),

          Row(
            children: [
              Expanded(
                child: variationCard(
                  'সেরা বাজার',
                  '৳ 42/kg',
                  'বিক্রির জন্য ভালো',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: variationCard(
                  'কাছের বাজার',
                  '৳ 40/kg',
                  'পরিবহন খরচ কম',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget chip(
    String text,
    bool selected,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 13,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: selected
            ? const Color(0xFF218838)
            : Colors.white,
        borderRadius:
            BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: selected
              ? Colors.white
              : Colors.black,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget variationCard(
    String title,
    String price,
    String subtitle,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(title),
            const SizedBox(height: 5),
            Text(
              price,
              style: const TextStyle(
                color: Color(0xFF218838),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// PROFILE
// ============================================================

class ProfileScreen extends StatefulWidget {
  final User user;
  final Function(User) onUpdate;
  final VoidCallback onLogout;

  const ProfileScreen({
    super.key,
    required this.user,
    required this.onUpdate,
    required this.onLogout,
  });

  @override
  State<ProfileScreen> createState() =>
      _ProfileScreenState();
}

class _ProfileScreenState
    extends State<ProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController phoneController;

  late String district;

  @override
  void initState() {
    super.initState();

    nameController =
        TextEditingController(
      text: widget.user.name,
    );

    phoneController =
        TextEditingController(
      text: widget.user.phone,
    );

    district = widget.user.district;
  }

  Future<void> saveProfile() async {
    final name = nameController.text.trim();

    if (name.isEmpty) {
      showSnack('নাম খালি রাখা যাবে না');
      return;
    }

    final updated = widget.user.copyWith(
      name: name,
      phone: phoneController.text.trim(),
      district: district,
    );

    await saveUser(updated);

    widget.onUpdate(updated);

    showSnack('প্রোফাইল সফলভাবে আপডেট হয়েছে');
  }

  void showSnack(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'প্রোফাইল',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 18),

          Row(
            children: [
              CircleAvatar(
                radius: 38,
                backgroundColor:
                    const Color(0xFFDDF2E3),
                child: Text(
                  nameController.text.isNotEmpty
                      ? nameController.text[0]
                          .toUpperCase()
                      : 'ক',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF218838),
                  ),
                ),
              ),

              const SizedBox(width: 13),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      nameController.text,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      district,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          sectionTitle('আমার ফসল'),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Wrap(
                spacing: 8,
                children: const [
                  Chip(label: Text('আমন ধান')),
                  Chip(label: Text('টমেটো')),
                  Chip(label: Text('পেঁয়াজ')),
                ],
              ),
            ),
          ),

          const SizedBox(height: 15),

          sectionTitle('ব্যক্তিগত তথ্য'),

          TextField(
            controller: nameController,
            onChanged: (_) => setState(() {}),
            decoration: const InputDecoration(
              labelText: 'নাম',
              prefixIcon:
                  Icon(Icons.person_outline),
            ),
          ),

          const SizedBox(height: 12),

          TextField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: 'মোবাইল নম্বর',
              prefixIcon: Icon(Icons.phone),
            ),
          ),

          const SizedBox(height: 12),

          DropdownButtonFormField<String>(
            value: district,
            decoration: const InputDecoration(
              labelText: 'জেলা / অবস্থান',
              prefixIcon:
                  Icon(Icons.location_on_outlined),
            ),
            items: districts
                .map(
                  (d) => DropdownMenuItem(
                    value: d,
                    child: Text(d),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value == null) return;

              setState(() {
                district = value;
              });
            },
          ),

          const SizedBox(height: 18),

          primaryButton(
            'পরিবর্তন সংরক্ষণ করুন',
            saveProfile,
          ),

          const SizedBox(height: 15),

          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.notifications_outlined,
                  ),
                  title: const Text(
                    'বিজ্ঞপ্তি',
                  ),
                  trailing:
                      Switch(
                    value: true,
                    onChanged: (_) {},
                    activeColor:
                        const Color(0xFF218838),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(
                    Icons.language,
                  ),
                  title: const Text(
                    'ভাষা (বাংলা)',
                  ),
                  trailing:
                      const Icon(
                    Icons.chevron_right,
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(
                    Icons.help_outline,
                  ),
                  title: const Text(
                    'হেল্পলাইন এবং সাপোর্ট',
                  ),
                  trailing:
                      const Icon(
                    Icons.chevron_right,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const HelpScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          OutlinedButton(
            onPressed: widget.onLogout,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.red,
              side: const BorderSide(
                color: Colors.red,
              ),
              minimumSize:
                  const Size.fromHeight(48),
            ),
            child: const Text(
              'লগআউট',
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// ============================================================
// EXPERT
// ============================================================

class ExpertScreen extends StatefulWidget {
  const ExpertScreen({super.key});

  @override
  State<ExpertScreen> createState() =>
      _ExpertScreenState();
}

class _ExpertScreenState
    extends State<ExpertScreen> {
  final questionController =
      TextEditingController();

  String? answer;

  void ask() {
    final question =
        questionController.text.trim();

    if (question.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'আপনার সমস্যাটি লিখুন',
          ),
        ),
      );
      return;
    }

    setState(() {
      answer = generateExpertAnswer(question);
    });
  }

  String generateExpertAnswer(String q) {
    final text = q.toLowerCase();

    // ========================================================
    // RICE YELLOW LEAF
    // ========================================================

    if ((text.contains('ধান') ||
            text.contains('rice')) &&
        (text.contains('হলুদ') ||
            text.contains('yellow') ||
            text.contains('পাতা'))) {
      return '''
সম্ভাব্য কারণ:

• নাইট্রোজেনের ঘাটতি
• জমিতে অতিরিক্ত পানি জমে থাকা
• শিকড়ের সমস্যা
• রোগ বা পোকামাকড়ের আক্রমণ


প্রতিকার:

১. জমিতে অতিরিক্ত পানি থাকলে পানি নিষ্কাশনের ব্যবস্থা করুন।

২. মাটির অবস্থা অনুযায়ী সুষম সার ব্যবহার করুন।

৩. প্রয়োজন অনুযায়ী ইউরিয়া/নাইট্রোজেন সার ভাগ করে প্রয়োগ করুন।

৪. পাতায় দাগ, পোকা বা অন্য কোনো রোগের লক্ষণ আছে কি না পরীক্ষা করুন।


গুরুত্বপূর্ণ:

অতিরিক্ত সার বা কীটনাশক ব্যবহার করবেন না। সমস্যা বেশি হলে স্থানীয় কৃষি কর্মকর্তা বা কৃষি বিশেষজ্ঞের পরামর্শ নিন।
''';
    }

    // ========================================================
    // PEST
    // ========================================================

    if (text.contains('পোকা') ||
        text.contains('কীট') ||
        text.contains('pest') ||
        text.contains('insect')) {
      return '''
সম্ভাব্য কারণ:

ফসলে বিভিন্ন ধরনের পোকামাকড়ের আক্রমণের কারণে পাতা, কাণ্ড বা ফল ক্ষতিগ্রস্ত হতে পারে।


প্রতিকার:

• আক্রান্ত গাছ ও পাতা নিয়মিত পর্যবেক্ষণ করুন।
• আক্রান্ত অংশ আলাদা করে ফেলুন।
• জমি পরিষ্কার রাখুন।
• প্রয়োজন হলে স্থানীয় কৃষি কর্মকর্তার পরামর্শ অনুযায়ী অনুমোদিত বালাইনাশক ব্যবহার করুন।


অপ্রয়োজনীয়ভাবে কীটনাশক ব্যবহার করবেন না।
''';
    }

    // ========================================================
    // FERTILIZER
    // ========================================================

    if (text.contains('সার') ||
        text.contains('ইউরিয়া') ||
        text.contains('ইউরিয়া') ||
        text.contains('fertilizer') ||
        text.contains('urea')) {
      return '''
সার ব্যবস্থাপনা:

ফসলের ধরন, মাটির অবস্থা এবং ফসলের বৃদ্ধির পর্যায় অনুযায়ী সারের প্রয়োজন পরিবর্তিত হয়।

• সম্ভব হলে মাটি পরীক্ষা করুন।
• সুষম সার ব্যবহার করুন।
• ইউরিয়া একবারে বেশি না দিয়ে প্রয়োজন অনুযায়ী ভাগ করে প্রয়োগ করুন।
• অতিরিক্ত সার ব্যবহার এড়িয়ে চলুন।
''';
    }

    // ========================================================
    // WATER
    // ========================================================

    if (text.contains('পানি') ||
        text.contains('সেচ') ||
        text.contains('water') ||
        text.contains('irrigation')) {
      return '''
সেচ ব্যবস্থাপনা:

• মাটির আর্দ্রতা পরীক্ষা করুন।
• মাটি শুকিয়ে গেলে প্রয়োজন অনুযায়ী সেচ দিন।
• জমিতে অতিরিক্ত পানি জমতে দেবেন না।
• পানি নিষ্কাশনের ব্যবস্থা ভালো রাখুন।
''';
    }

    // ========================================================
    // TOMATO
    // ========================================================

    if (text.contains('টমেটো') ||
        text.contains('tomato')) {
      return '''
টমেটোর সমস্যার কারণ হতে পারে পুষ্টির ঘাটতি, অতিরিক্ত পানি, রোগ অথবা পোকামাকড়।

প্রথমে পাতার রং, দাগ, পোকা এবং ফলের অবস্থা পরীক্ষা করুন।

জমিতে অতিরিক্ত পানি জমতে দেবেন না এবং সুষম সার ব্যবস্থাপনা করুন।

সমস্যা বেশি হলে কৃষি বিশেষজ্ঞের পরামর্শ নিন।
''';
    }

    // ========================================================
    // GENERAL
    // ========================================================

    return '''
আপনার সমস্যাটি আরও ভালোভাবে বুঝতে নিচের তথ্যগুলো দিন:

• কোন ফসল?
• সমস্যাটি কী?
• কতদিন ধরে হচ্ছে?
• পাতার রং বা আকৃতিতে কী পরিবর্তন হয়েছে?
• কোনো পোকা বা দাগ দেখা যাচ্ছে কি?


সম্ভব হলে আক্রান্ত ফসলের একটি ছবি দেখালে সমস্যা শনাক্ত করা সহজ হবে।

অতিরিক্ত সার বা কীটনাশক নিজের সিদ্ধান্তে ব্যবহার করবেন না।
''';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'কৃষি বিশেষজ্ঞ',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF2E8B35),
              borderRadius:
                  BorderRadius.circular(18),
            ),
            child: const Column(
              children: [
                Icon(
                  Icons.support_agent,
                  size: 55,
                  color: Colors.white,
                ),
                SizedBox(height: 9),
                Text(
                  'কৃষি বিশেষজ্ঞকে জিজ্ঞাসা করুন',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  'আপনার ফসলের সমস্যা লিখুন',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            'আপনার সমস্যা',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'উদাহরণ: ধানের পাতা হলুদ হয়ে যাচ্ছে কেন?',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 10),

          TextField(
            controller: questionController,
            maxLines: 5,
            decoration: const InputDecoration(
              hintText:
                  'আপনার সমস্যাটি লিখুন...',
              alignLabelWithHint: true,
            ),
          ),

          const SizedBox(height: 13),

          primaryButton(
            'পরামর্শ নিন',
            ask,
          ),

          if (answer != null) ...[
            const SizedBox(height: 20),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(17),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        CircleAvatar(
                          backgroundColor:
                              Color(0xFFE1F5E7),
                          child: Icon(
                            Icons.lightbulb_outline,
                            color:
                                Color(0xFF218838),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'বিশেষজ্ঞের পরামর্শ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const Divider(height: 25),

                    Text(
                      answer!,
                      style: const TextStyle(
                        height: 1.55,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ============================================================
// HELP / SUPPORT
// ============================================================

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'হেল্পলাইন এবং সাপোর্ট',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'জরুরি যোগাযোগ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Card(
            color: const Color(0xFFE1F5E7),
            child: const ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.agriculture,
                  color: Color(0xFF218838),
                ),
              ),
              title: Text(
                'Agriculture Helpline',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'National Krishi Service • 16123',
              ),
            ),
          ),

          const SizedBox(height: 12),

          Card(
            child: const ListTile(
              leading: Icon(
                Icons.location_city,
                color: Color(0xFF218838),
              ),
              title: Text(
                'স্থানীয় কৃষি অফিস',
              ),
              subtitle: Text(
                'আপনার এলাকার কৃষি কর্মকর্তার সাথে যোগাযোগ করুন',
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            'অ্যাপ সম্পর্কে মতামত',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          TextField(
            maxLines: 5,
            decoration: const InputDecoration(
              hintText:
                  'আপনার মতামত লিখুন...',
            ),
          ),

          const SizedBox(height: 13),

          primaryButton(
            'মতামত পাঠান',
            () {
              ScaffoldMessenger.of(context)
                  .showSnackBar(
                const SnackBar(
                  content: Text(
                    'আপনার মতামতের জন্য ধন্যবাদ',
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ============================================================
// UTILITIES
// ============================================================

Widget primaryButton(
  String text,
  VoidCallback onPressed,
) {
  return SizedBox(
    height: 50,
    width: double.infinity,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            const Color(0xFF218838),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

int getTemperature(String district) {
  final value = district.codeUnits.fold(
    0,
    (sum, code) => sum + code,
  );

  return 28 + (value % 6);
}