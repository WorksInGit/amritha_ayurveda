import 'package:amritha_ayurveda/core/constants.dart';
import 'package:amritha_ayurveda/services/size_utils.dart';
import 'package:amritha_ayurveda/theme/theme.dart';
import 'package:amritha_ayurveda/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SelectionBottomSheet<T> extends StatefulWidget {
  final String title;
  final List<T> items;
  final T? selectedItem;
  final String Function(T) displayText;

  const SelectionBottomSheet({
    super.key,
    required this.title,
    required this.items,
    this.selectedItem,
    required this.displayText,
  });

  @override
  State<SelectionBottomSheet<T>> createState() =>
      _SelectionBottomSheetState<T>();
}

class _SelectionBottomSheetState<T> extends State<SelectionBottomSheet<T>> {
  final _searchController = TextEditingController();
  late List<T> _filteredItems;

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
  }

  void _filter(String query) {
    if (query.isEmpty) {
      setState(() => _filteredItems = widget.items);
      return;
    }
    setState(() {
      _filteredItems = widget.items.where((item) {
        return widget
            .displayText(item)
            .toLowerCase()
            .contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: EdgeInsets.fromLTRB(20.w, 20.w, 20.w, 0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: context.poppins60018.copyWith(color: appBlackColor),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.close, size: 24.r),
              ),
            ],
          ),
          Gap(20.w),
          AppTextField(
            label: '',
            hintText: 'Search...',
            controller: _searchController,
            onChanged: _filter,
            prefixIcon: Icon(Icons.search, size: 24.r),
          ),
          Gap(20.w),
          Expanded(
            child: ListView.separated(
              itemCount: _filteredItems.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final item = _filteredItems[index];
                final isSelected = item == widget.selectedItem;
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    widget.displayText(item),
                    style: context.poppins60016.copyWith(
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                      color: isSelected ? primaryColor : appBlackColor,
                    ),
                  ),
                  trailing: isSelected
                      ? Icon(
                          Icons.check_circle,
                          color: primaryColor,
                          size: 24.r,
                        )
                      : null,
                  onTap: () => Navigator.pop(context, item),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
