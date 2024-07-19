import 'package:flutter/material.dart';

class HighlightTextField extends StatefulWidget {
  @override
  _HighlightTextFieldState createState() => _HighlightTextFieldState();
}

class _HighlightTextFieldState extends State<HighlightTextField> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final Map<String, Color> targets = {
    "문장": Colors.red,
    "일부": Colors.orange,
    "하이라": Colors.red,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TextField 하이라이트 예시'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '입력하세요',
                ),
                maxLines: null,
                onChanged: (text) {
                  setState(() {}); // 텍스트가 변경될 때마다 화면을 다시 그립니다.
                },
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: RichText(
                  text: _buildHighlightedText(_controller.text, targets),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextSpan _buildHighlightedText(String text, Map<String, Color> targets) {
    List<TextSpan> spans = [];
    int start = 0;

    while (start < text.length) {
      int nearestIndex = text.length;
      String? nearestTarget;
      for (String target in targets.keys) {
        int index = text.indexOf(target, start);
        if (index != -1 && index < nearestIndex) {
          nearestIndex = index;
          nearestTarget = target;
        }
      }

      if (nearestTarget == null) {
        spans.add(TextSpan(text: text.substring(start)));
        break;
      }

      if (nearestIndex > start) {
        spans.add(TextSpan(text: text.substring(start, nearestIndex)));
      }

      spans.add(TextSpan(
        text: nearestTarget,
        style: TextStyle(
          backgroundColor: targets[nearestTarget],
          color: Colors.black,
        ),
      ));

      start = nearestIndex + nearestTarget.length;
    }

    return TextSpan(
        children: spans, style: TextStyle(fontSize: 16, color: Colors.black));
  }
}
