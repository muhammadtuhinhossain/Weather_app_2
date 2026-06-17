import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/frosted_glass_card.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key, required this.controller, required this.onSearch});

  final TextEditingController controller;
  final VoidCallback onSearch;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: FrostedGlassCard(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 0),
              child: TextFormField(
                controller: controller,
                style: TextStyle(color: Colors.white, fontSize: 16),
                textInputAction: TextInputAction.search,
                onFieldSubmitted: (_) => onSearch(),
                decoration: InputDecoration(
                  hintText: 'Search city...',
                  hintStyle: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 15,
                  ),
                  prefixIcon: Icon(
                    CupertinoIcons.search,
                    color: Colors.white.withValues(alpha: 0.7),
                    size: 20,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          FrostedGlassCard(
            padding: EdgeInsets.zero,
            child: GestureDetector(
              onTap: onSearch,
              child: SizedBox(
                height: 44,
                width: 44,
                child: Icon(CupertinoIcons.arrow_right, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
