import 'package:flutter/material.dart';
import 'package:mvvm_project/views/flutter_topic_detail_page.dart';

class FlutterOverviewPage extends StatelessWidget {
  const FlutterOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    const pageBackground = Color(0xFFDDE5EF);
    const headerBlue = Color(0xFF1D4E9E);
    const titleBlue = Color(0xFF2C86C8);

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        backgroundColor: headerBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Tổng quan Flutter',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.85),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Text(
              'Flutter là framework UI đa nền tảng dùng Dart.\n'
              'Bạn có thể build app Android/iOS/Web/Desktop\n'
              'từ 1 codebase.',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF202226),
                height: 1.35,
              ),
            ),
          ),
          const SizedBox(height: 14),
          ..._topics.map(
            (topic) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _OverviewCard(
                topic: topic,
                titleColor: titleBlue,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => FlutterTopicDetailPage(topic: topic),
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
}

class _OverviewCard extends StatelessWidget {
  final FlutterTopic topic;
  final Color titleColor;
  final VoidCallback onTap;

  const _OverviewCard({
    required this.topic,
    required this.titleColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(0.86),
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFE7F1FB),
                ),
                child: Icon(
                  topic.icon,
                  color: const Color(0xFF2C86C8),
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      topic.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: titleColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      topic.subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF686B70),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFF2C86C8),
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const _topics = <FlutterTopic>[
  FlutterTopic(
    icon: Icons.widgets_rounded,
    title: 'Widget',
    subtitle: 'Stateless/Stateful, build(), lifecycle',
    overview:
        'Trong Flutter, mọi thứ đều là widget: từ text, button, icon cho tới '
        'layout và cả màn hình. Học tốt widget là gốc của mọi module khác.',
    essentials: [
      'Dùng StatelessWidget khi UI chỉ hiển thị dữ liệu nhận vào, không tự đổi trạng thái.',
      'Dùng StatefulWidget khi có state nội bộ như loading, selected tab, form value.',
      'Hàm build() chỉ nên dựng UI, không gọi API trực tiếp trong build.',
      'Tách widget nhỏ để dễ đọc, dễ tái sử dụng và dễ test.',
    ],
    practiceSteps: [
      'Tách từng khối trên màn hình thành widget riêng: Header, CardItem, ActionBar.',
      'Ưu tiên constructor có required field để truyền dữ liệu rõ ràng.',
      'Dùng const cho widget tĩnh để tối ưu render.',
    ],
    codeSample: '''class ProfileName extends StatelessWidget {
  final String name;
  const ProfileName({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(name, style: const TextStyle(fontSize: 18));
  }
}''',
    learnNext:
        'Học tiếp về widget composition, const widget và cách chia component '
        'để màn hình lớn vẫn dễ bảo trì.',
  ),
  FlutterTopic(
    icon: Icons.dashboard_customize_rounded,
    title: 'Layout',
    subtitle: 'Row/Column/Flex, Stack, GridView',
    overview:
        'Layout quyết định cách các widget sắp xếp trên nhiều cỡ màn hình. '
        'Nắm rõ constraint và Expanded/Flexible giúp tránh lỗi tràn.',
    essentials: [
      'Row/Column cho bố cục tuyến tính; Expanded/Flexible để chia không gian.',
      'Stack dùng khi cần chồng lớp (badge, overlay, floating action).',
      'ListView/GridView cho danh sách dài, tránh dùng Column với dữ liệu lớn.',
      'MediaQuery và LayoutBuilder giúp làm giao diện responsive.',
    ],
    practiceSteps: [
      'Màn danh sách: dùng ListView.builder thay vì Column + map.',
      'Card có avatar + text: Row + Expanded cho phần text.',
      'Màn hình nhỏ: giảm padding, tăng xuống dòng thay vì cố giữ 1 hàng.',
    ],
    codeSample: '''Row(
  children: [
    const Icon(Icons.person),
    const SizedBox(width: 8),
    Expanded(
      child: Text(userName, overflow: TextOverflow.ellipsis),
    ),
  ],
)''',
    learnNext:
        'Học thêm BoxConstraints, IntrinsicHeight và Sliver để làm UI phức tạp '
        'mượt hơn.',
  ),
  FlutterTopic(
    icon: Icons.alt_route_rounded,
    title: 'Navigation',
    subtitle: 'Navigator 1.0/Named routes',
    overview:
        'Navigation quản lý việc chuyển màn, truyền dữ liệu và quay lại đúng ngữ cảnh. '
        'Dùng nhất quán sẽ giúp luồng app rõ ràng, ít bug.',
    essentials: [
      'Navigator.push để mở màn mới, Navigator.pop để quay lại.',
      'pushReplacement dùng khi không muốn quay lại màn cũ (ví dụ sau login).',
      'Có thể truyền object qua constructor thay vì dùng biến global.',
      'Kiểm tra context.mounted sau await trước khi pop/push.',
    ],
    practiceSteps: [
      'Màn list -> detail: push với model được chọn.',
      'Màn edit thành công: pop(result) để trả dữ liệu về màn trước.',
      'Logout: pushAndRemoveUntil để dọn stack.',
    ],
    codeSample: '''Navigator.of(context).push(
  MaterialPageRoute(
    builder: (_) => UserDetailPage(user: user),
  ),
);''',
    learnNext:
        'Khi app lớn hơn, bạn có thể chuyển sang Router API hoặc go_router '
        'để quản lý route theo URL.',
  ),
  FlutterTopic(
    icon: Icons.swap_horiz_rounded,
    title: 'State',
    subtitle: 'setState, Provider (ChangeNotifier)',
    overview:
        'State management giữ cho UI và dữ liệu luôn đồng bộ. '
        'Dự án của bạn đang dùng Provider + ChangeNotifier là hướng phù hợp.',
    essentials: [
      'State cục bộ (setState) phù hợp cho toggle, tab, input tạm thời.',
      'State chia sẻ dùng ChangeNotifier/Provider để nhiều widget cùng nghe.',
      'Mỗi lần đổi dữ liệu cần gọi notifyListeners() để UI cập nhật.',
      'Tách logic sang ViewModel giúp code UI gọn và dễ test.',
    ],
    practiceSteps: [
      'Giữ business logic trong ViewModel, UI chỉ gọi method.',
      'Dùng context.watch cho widget cần re-render khi state đổi.',
      'Dùng context.read khi chỉ gọi action (không cần rebuild).',
    ],
    codeSample: '''class CounterVM extends ChangeNotifier {
  int count = 0;

  void increment() {
    count++;
    notifyListeners();
  }
}''',
    learnNext:
        'Có thể học thêm Riverpod/BLoC để so sánh cách quản lý state khi dự án '
        'đạt quy mô lớn.',
  ),
  FlutterTopic(
    icon: Icons.cloud_download_rounded,
    title: 'Networking',
    subtitle: 'HTTP, REST API, JSON',
    overview:
        'Networking là cầu nối app với backend. Làm tốt phần này giúp app ổn định, '
        'dễ debug và dễ mở rộng chức năng.',
    essentials: [
      'Dùng package http để gọi GET/POST và đọc statusCode.',
      'Chuyển JSON sang DTO rồi map sang Entity để tách tầng data/domain.',
      'Luôn có try/catch để xử lý lỗi mạng và lỗi parse dữ liệu.',
      'Hiển thị loading + error rõ ràng ở UI.',
    ],
    practiceSteps: [
      'Tạo interface API để dễ mock khi test.',
      'Tạo repository để gom logic mapping và xử lý lỗi.',
      'Chuẩn hóa message lỗi để user dễ hiểu.',
    ],
    codeSample: '''final response = await http.get(Uri.parse(url));
if (response.statusCode == 200) {
  final data = jsonDecode(response.body);
} else {
  throw Exception('Load failed');
}''',
    learnNext:
        'Học thêm timeout, retry và cache để trải nghiệm mạng yếu vẫn mượt.',
  ),
  FlutterTopic(
    icon: Icons.storage_rounded,
    title: 'Local DB',
    subtitle: 'SQLite (sqflite), SharedPreferences',
    overview:
        'Local storage giúp app hoạt động nhanh và dùng được ngay cả khi mất mạng. '
        'Bạn đang dùng sqflite cho login/session/user management là hợp lý.',
    essentials: [
      'SQLite phù hợp dữ liệu có cấu trúc và cần query theo điều kiện.',
      'SharedPreferences phù hợp cờ đơn giản như theme hoặc first-open.',
      'Quản lý schema bằng version + onUpgrade để tránh lỗi khi update app.',
      'Ẩn SQL phía sau repository để UI không phụ thuộc DB.',
    ],
    practiceSteps: [
      'Tạo bảng rõ ràng, có khóa chính và field created_at.',
      'Viết seed data cho môi trường dev/demo.',
      'Khi đổi schema, tăng version và viết migration cụ thể.',
    ],
    codeSample: '''await db.insert('managed_users', {
  'full_name': fullName,
  'dob': dob,
  'address': address,
  'created_at': DateTime.now().toIso8601String(),
});''',
    learnNext:
        'Có thể tìm hiểu drift hoặc isar nếu muốn query mạnh và type-safe hơn.',
  ),
  FlutterTopic(
    icon: Icons.palette_outlined,
    title: 'UI/UX',
    subtitle: 'Theme, Material 3, responsive',
    overview:
        'UI/UX tốt không chỉ đẹp mà còn dễ dùng, đồng nhất và phản hồi rõ ràng. '
        'Chất lượng UI quyết định cảm nhận chuyên nghiệp của sản phẩm.',
    essentials: [
      'Dùng ThemeData để đồng bộ màu, typography, button style.',
      'Giữ spacing nhất quán theo hệ 8dp để giao diện gọn.',
      'Ưu tiên độ tương phản đủ cao, cỡ chữ dễ đọc.',
      'Luôn có trạng thái loading, empty, error cho từng màn.',
    ],
    practiceSteps: [
      'Đưa màu chính và text style về hằng số/theme.',
      'Kiểm tra giao diện trên màn nhỏ để tránh overflow.',
      'Tạo component tái sử dụng như card, header, action button.',
    ],
    codeSample: '''return MaterialApp(
  theme: ThemeData(
    useMaterial3: true,
    colorSchemeSeed: const Color(0xFF1D4E9E),
  ),
);''',
    learnNext:
        'Học thêm về accessibility (semantics), dark mode và motion nhẹ để UX '
        'hoàn thiện hơn.',
  ),
];
