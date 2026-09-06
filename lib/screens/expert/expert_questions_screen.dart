import 'package:flutter/material.dart';

class ExpertScreen extends StatefulWidget {
  const ExpertScreen({super.key});

  @override
  State<ExpertScreen> createState() => _ExpertScreenState();
}

class _ExpertScreenState extends State<ExpertScreen> {
  final TextEditingController questionController = TextEditingController();

  String? answer;
  bool submitted = false;

  void submitQuestion() {
    final question = questionController.text.trim().toLowerCase();

    if (question.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('দয়া করে আপনার প্রশ্ন লিখুন।'),
        ),
      );
      return;
    }

    String generatedAnswer;

    if (question.contains('ধান') &&
        (question.contains('হলুদ') || question.contains('পাতা'))) {
      generatedAnswer =
          'ধানের পাতা হলুদ হওয়ার প্রধান কারণ হতে পারে নাইট্রোজেনের ঘাটতি, অতিরিক্ত পানি বা রোগের আক্রমণ।\n\n'
          'প্রতিকার:\n'
          '• জমিতে অতিরিক্ত পানি জমে থাকলে পানি নিষ্কাশন করুন।\n'
          '• প্রয়োজন অনুযায়ী ইউরিয়া সার প্রয়োগ করুন।\n'
          '• রোগের লক্ষণ বেশি হলে স্থানীয় কৃষি কর্মকর্তার পরামর্শ নিন।';
    } else if (question.contains('পোকা') ||
        question.contains('কীট') ||
        question.contains('পোকামাকড়')) {
      generatedAnswer =
          'ফসলে পোকামাকড়ের আক্রমণ হলে প্রথমে আক্রান্ত গাছ শনাক্ত করুন।\n\n'
          'প্রতিকার:\n'
          '• আক্রান্ত পাতা বা অংশ সরিয়ে ফেলুন।\n'
          '• জমি পরিষ্কার রাখুন।\n'
          '• প্রয়োজন হলে অনুমোদিত কীটনাশক ব্যবহার করুন এবং স্থানীয় কৃষি কর্মকর্তার পরামর্শ নিন।';
    } else if (question.contains('সার') ||
        question.contains('ইউরিয়া')) {
      generatedAnswer =
          'সঠিক সার প্রয়োগ ফসলের ভালো ফলনের জন্য গুরুত্বপূর্ণ। '
          'ফসলের ধরন, জমির অবস্থা ও বৃদ্ধির পর্যায় অনুযায়ী সারের পরিমাণ নির্ধারণ করা উচিত।\n\n'
          'প্রয়োজনে মাটির পরীক্ষা করে স্থানীয় কৃষি কর্মকর্তার পরামর্শ নিন।';
    } else if (question.contains('টমেটো') ||
        question.contains('সবজি')) {
      generatedAnswer =
          'টমেটো ও সবজির ভালো ফলনের জন্য পর্যাপ্ত আলো, পানি এবং সঠিক সার ব্যবস্থাপনা প্রয়োজন।\n\n'
          'পাতায় দাগ, পাতা কুঁকড়ে যাওয়া বা পোকামাকড় দেখা দিলে দ্রুত ব্যবস্থা নিন। '
          'গুরুতর হলে কৃষি কর্মকর্তার পরামর্শ নিন।';
    } else {
      generatedAnswer =
          'আপনার প্রশ্নটি পেয়েছি। সমস্যাটি সঠিকভাবে শনাক্ত করার জন্য ফসলের নাম, '
          'আক্রান্ত অংশ এবং সমস্যার লক্ষণ বিস্তারিতভাবে জানানো ভালো।\n\n'
          'প্রয়োজনে স্থানীয় কৃষি কর্মকর্তা বা কৃষি বিশেষজ্ঞের পরামর্শ নিন।';
    }

    setState(() {
      answer = generatedAnswer;
      submitted = true;
    });
  }

  @override
  void dispose() {
    questionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1FAF3),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'বিশেষজ্ঞের পরামর্শ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'কৃষি বিশেষজ্ঞকে প্রশ্ন করুন',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B5E20),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'আপনার ফসলের সমস্যা সম্পর্কে প্রশ্ন লিখুন।',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'আপনার প্রশ্ন',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 10),

                    TextField(
                      controller: questionController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText:
                            'যেমন: ধানের পাতা হলুদ হয়ে যাচ্ছে, এর কারণ কী?',
                        filled: true,
                        fillColor: const Color(0xFFF7FAF7),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: submitQuestion,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF168B3A),
                          foregroundColor: Colors.white,
                          padding:
                              const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'প্রশ্ন পাঠান',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              if (submitted && answer != null) ...[
                const SizedBox(height: 24),

                const Text(
                  'বিশেষজ্ঞের উত্তর',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B5E20),
                  ),
                ),

                const SizedBox(height: 10),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFC8E6C9),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.verified,
                            color: Color(0xFF2E7D32),
                          ),
                          SizedBox(width: 8),
                          Text(
                            'কৃষি পরামর্শ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2E7D32),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      Text(
                        answer!,
                        style: const TextStyle(
                          fontSize: 15,
                          height: 1.6,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
