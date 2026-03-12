import 'package:flutter/material.dart';

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
    const pageBackground = Color(0xFFE9F4FF);
    const headerBlue = Color(0xFF1D4E9E);
    const accentBlue = Color(0xFF2C86C8);

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        backgroundColor: headerBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(topic.title),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE7F1FB),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    topic.icon,
                    color: accentBlue,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        topic.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: accentBlue,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        topic.subtitle,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF6A6E74),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _SectionCard(
            title: 'Tổng quan',
            child: Text(
              topic.overview,
              style: const TextStyle(
                fontSize: 15,
                height: 1.45,
                color: Color(0xFF202226),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _SectionCard(
            title: 'Điểm chính cần nhớ',
            child: _BulletList(items: topic.essentials),
          ),
          const SizedBox(height: 12),
          _SectionCard(
            title: 'Áp dụng vào dự án của bạn',
            child: _BulletList(items: topic.practiceSteps),
          ),
          if (topic.codeSample.trim().isNotEmpty) ...[
            const SizedBox(height: 12),
            _SectionCard(
              title: 'Ví dụ nhanh',
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1F24),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SelectableText(
                  topic.codeSample,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13,
                    height: 1.4,
                    color: Color(0xFFF3F4F6),
                  ),
                ),
              ),
            ),
          ],
          const SizedBox(height: 12),
          _SectionCard(
            title: 'Học tiếp',
            child: Text(
              topic.learnNext,
              style: const TextStyle(
                fontSize: 15,
                height: 1.45,
                color: Color(0xFF202226),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionCard({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1D4E9E),
            ),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

class _BulletList extends StatelessWidget {
  final List<String> items;

  const _BulletList({required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items
          .map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: Icon(
                      Icons.circle,
                      size: 7,
                      color: Color(0xFF2C86C8),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.4,
                        color: Color(0xFF202226),
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
