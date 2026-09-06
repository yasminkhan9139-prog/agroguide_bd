class CropItem {
  final String name;
  final String season;
  final String description;
  final String icon;
  final List<String> tips;

  const CropItem({
    required this.name,
    required this.season,
    required this.description,
    required this.icon,
    required this.tips,
  });
}

class MarketItem {
  final String crop;
  final String market;
  final String unit;
  final String price;
  final bool rising;

  const MarketItem({
    required this.crop,
    required this.market,
    required this.unit,
    required this.price,
    required this.rising,
  });
}

class WeatherDay {
  final String day;
  final String temp;
  final String condition;
  final String icon;

  const WeatherDay({
    required this.day,
    required this.temp,
    required this.condition,
    required this.icon,
  });
}

const crops = [
  CropItem(
    name: 'ধান',
    season: 'আমন মৌসুম',
    description: 'বাংলাদেশের প্রধান খাদ্যশস্য। সঠিক পানি, সার ও রোগ ব্যবস্থাপনা প্রয়োজন।',
    icon: '🌾',
    tips: ['জমি ভালোভাবে প্রস্তুত করুন', 'সুষম সার প্রয়োগ করুন', 'নিয়মিত আগাছা পরিষ্কার করুন'],
  ),
  CropItem(
    name: 'গম',
    season: 'রবি মৌসুম',
    description: 'শীতকালীন গুরুত্বপূর্ণ শস্য। পানি নিষ্কাশন ভালো এমন জমি উপযোগী।',
    icon: '🌿',
    tips: ['সময়মতো বীজ বপন করুন', 'সেচের সময় ঠিক রাখুন', 'পাতার রোগ নিয়মিত দেখুন'],
  ),
  CropItem(
    name: 'টমেটো',
    season: 'শীতকাল',
    description: 'সবজি হিসেবে জনপ্রিয়। রোগমুক্ত চারা ও পর্যাপ্ত আলো দরকার।',
    icon: '🍅',
    tips: ['সুস্থ চারা নির্বাচন করুন', 'গাছের গোড়ায় পানি দিন', 'পোকা দেখা দিলে দ্রুত ব্যবস্থা নিন'],
  ),
  CropItem(
    name: 'আলু',
    season: 'রবি মৌসুম',
    description: 'দেশের অন্যতম গুরুত্বপূর্ণ কন্দজাতীয় ফসল।',
    icon: '🥔',
    tips: ['উর্বর ঝুরঝুরে মাটি ব্যবহার করুন', 'অতিরিক্ত পানি এড়িয়ে চলুন', 'পাতার দাগ পর্যবেক্ষণ করুন'],
  ),
];

const marketItems = [
  MarketItem(crop: 'ধান', market: 'টাঙ্গাইল বাজার', unit: 'মণ', price: '৳ ১,৪২০', rising: true),
  MarketItem(crop: 'আলু', market: 'মির্জাপুর বাজার', unit: 'কেজি', price: '৳ ৩৮', rising: true),
  MarketItem(crop: 'টমেটো', market: 'টাঙ্গাইল বাজার', unit: 'কেজি', price: '৳ ৫৫', rising: false),
  MarketItem(crop: 'গম', market: 'বাসাইল বাজার', unit: 'কেজি', price: '৳ ৪৬', rising: true),
];

const weatherDays = [
  WeatherDay(day: 'আজ', temp: '32°C', condition: 'আংশিক মেঘলা', icon: '☁️'),
  WeatherDay(day: 'শুক্রবার', temp: '31°C', condition: 'বৃষ্টির সম্ভাবনা', icon: '🌦️'),
  WeatherDay(day: 'শনিবার', temp: '33°C', condition: 'রৌদ্রোজ্জ্বল', icon: '☀️'),
  WeatherDay(day: 'রবিবার', temp: '30°C', condition: 'বৃষ্টির সম্ভাবনা', icon: '🌧️'),
];
