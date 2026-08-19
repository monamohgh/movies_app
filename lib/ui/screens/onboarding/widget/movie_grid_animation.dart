import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_assets.dart';
// تأكدي من استيراد ملف الـ Assets الخاص بكِ هنا
// import 'path_to_your_app_assets.dart';

class MovieGridAnimation extends StatefulWidget {
  const MovieGridAnimation({Key? key}) : super(key: key);

  @override
  State<MovieGridAnimation> createState() => _MovieGridAnimationState();
}

class _MovieGridAnimationState extends State<MovieGridAnimation> {
  final ScrollController _scrollController = ScrollController();

  // قائمة تحتوي على مسارات الصور من كلاس AppAssets
  final List<String> movieImages = [
    AppAssets.onboar1,
    AppAssets.onboar2,
    AppAssets.onboar3,
    AppAssets.onboar4,
    AppAssets.onboar5,
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoScroll();
    });
  }

  void _startAutoScroll() async {
    while (_scrollController.hasClients) {
      await Future.delayed(const Duration(seconds: 1));
      if (_scrollController.hasClients) {
        await _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(seconds: 20),
          curve: Curves.linear,
        );
        if (_scrollController.hasClients) {
          await _scrollController.animateTo(
            0,
            duration: const Duration(seconds: 20),
            curve: Curves.linear,
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -0.1,
      child: GridView.builder(
        controller: _scrollController,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.6,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: 18,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              movieImages[index % movieImages.length],
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: Colors.amber.shade900,
                child: const Icon(Icons.movie, color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}