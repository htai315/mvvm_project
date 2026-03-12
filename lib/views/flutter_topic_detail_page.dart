import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FlutterTopic {
  final IconData icon;
  final String title;
  final String subtitle;
  final String overview;
  final List<String> essentials;
  final List<String> practiceSteps;
  final String codeSample;
  final String learnNext;

  const FlutterTopic({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.overview,
    required this.essentials,
    required this.practiceSteps,
    required this.codeSample,
    required this.learnNext,
  });
}

class FlutterTopicDetailPage extends StatelessWidget {
  final FlutterTopic topic;

  const FlutterTopicDetailPage({
    super.key,
    required this.topic,
  });

  @override
  Widget build(BuildContext context) {
    const pageBackground = Color(0xFFF0F4F8);
    const primaryBlue = Color(0xFF1A56BE);
    const secondaryBlue = Color(0xFF4285F4);

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryBlue, secondaryBlue],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        title: Text(
          topic.title,
          style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          // Header Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: secondaryBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(topic.icon, color: secondaryBlue, size: 32),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        topic.title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1A202C),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        topic.subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Sections
          _SectionCard(
            title: 'Tổng quan',
            icon: Icons.info_outline,
            child: Text(
              topic.overview,
              style: const TextStyle(
                fontSize: 15,
                height: 1.6,
                color: Color(0xFF2D3748),
              ),
            ),
          ),

          _SectionCard(
            title: 'Điểm chính cần nhớ',
            icon: Icons.lightbulb_outline,
            child: _BulletList(items: topic.essentials, iconColor: Colors.orange),
          ),

          _SectionCard(
            title: 'Áp dụng thực tế',
            icon: Icons.construction_outlined,
            child: _BulletList(items: topic.practiceSteps, iconColor: Colors.green),
          ),

          if (topic.codeSample.trim().isNotEmpty)
            _SectionCard(
              title: 'Ví dụ minh họa',
              icon: Icons.code,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: const BoxDecoration(
                      color: Color(0xFF2D3748),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.circle, color: Colors.red, size: 10),
                        SizedBox(width: 6),
                        Icon(Icons.circle, color: Colors.orange, size: 10),
                        SizedBox(width: 6),
                        Icon(Icons.circle, color: Colors.green, size: 10),
                        Spacer(),
                        Text(
                          'dart',
                          style: TextStyle(color: Colors.white54, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Color(0xFF1A202C),
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
                    ),
                    child: SelectableText(
                      topic.codeSample,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 13,
                        height: 1.5,
                        color: Color(0xFFE2E8F0),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          _SectionCard(
            title: 'Lộ trình tiếp theo',
            icon: Icons.trending_up,
            child: Text(
              topic.learnNext,
              style: const TextStyle(
                fontSize: 15,
                height: 1.6,
                color: Color(0xFF2D3748),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: const Color(0xFF1A56BE)),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1A56BE),
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1),
          ),
          child,
        ],
      ),
    );
  }
}

class _BulletList extends StatelessWidget {
  final List<String> items;
  final Color iconColor;

  const _BulletList({required this.items, this.iconColor = Colors.blue});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items
          .map(
            (item) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Icon(
                  Icons.check_circle,
                  size: 16,
                  color: iconColor.withOpacity(0.8),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 14.5,
                    height: 1.5,
                    color: Color(0xFF4A5568),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
          .toList(),
    );
  }
}