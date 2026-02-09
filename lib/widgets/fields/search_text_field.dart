import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jk_tech_exam/shared/colors.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({
    super.key,
    this.hintText = 'Search',
    this.onSearch,
    this.debounceDuration = const Duration(milliseconds: 400),
    this.initialValue,
  });

  final String hintText;
  final ValueChanged<String>? onSearch;
  final Duration debounceDuration;
  final String? initialValue;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  late TextEditingController _controller;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(widget.debounceDuration, () {
      widget.onSearch?.call(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      controller: _controller,
      style: theme.textTheme.bodyMedium,
      cursorColor: AppColor.primaryColor,
      onChanged: _onChanged,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: theme.textTheme.bodyMedium!.copyWith(
          color: AppColor.hintColor,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12.0),
        ),
        filled: true,
        fillColor: const Color(0xFFF1F5F9),
        prefixIcon: const Icon(
          Icons.search,
          color: AppColor.hintColor,
          size: 22,
        ),
      ),
    );
  }
}
