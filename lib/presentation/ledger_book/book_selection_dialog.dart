import 'package:bearnshare/app/theme/app_theme.dart';
import 'package:bearnshare/presentation/component/app_button.dart';
import 'package:bearnshare/presentation/component/app_text_field.dart';
import 'package:flutter/material.dart';

class BookSelectionDialog extends StatefulWidget {
  const BookSelectionDialog({super.key});

  @override
  State<BookSelectionDialog> createState() => _BooksBottomSheetState();
}

class _BooksBottomSheetState extends State<BookSelectionDialog> {
  final TextEditingController _searchController = TextEditingController();
  int? selectedIndex;

  final List<BookData> books = [
    BookData(
      icon: Icons.home,
      title: 'Home Expenses',
      iconBg: const Color(0xFF4A4A5A),
    ),
    BookData(
      icon: null,
      title: 'House Rent',
      iconBg: const Color(0xFF6A6A7A),
    ),
    BookData(
      icon: null,
      title: 'New Year 2025',
      iconBg: const Color(0xFF8B4513),
      customImage: true,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: AppTheme.homePageCardBgColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          _buildHeader(context),
          _buildSearchBar(),
          _buildBooksList(),
          _buildSubmitButton(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Text(
            'Books',
            style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 22),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.close, color: Colors.white, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: AppTextField(
        controller: _searchController,
        textFieldStyle: TextFieldStyle.filled,
        textFieldState: TextFieldState.enabled,
        textFieldType: TextFieldType.text,
        hint: 'Search Books',
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.white54,
          size: 22,
        ),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      ),
    );
  }

  Widget _buildBooksList() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Book',
                  style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 18),
                ),
                AppButton(
                  textString: 'Add',
                  buttonType: ButtonType.filled,
                  leadingIcon: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 16,
                  ),
                  onPressed: (_) {},
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  enabledButtonFilledStyle: BoxDecoration(
                    color: AppTheme.amountPosTextColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledTextStyle: AppTheme.ledgerTitleTextStyle.copyWith(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return Column(
                  children: [
                    _buildBookItem(
                      index: index,
                      icon: book.icon,
                      title: book.title,
                      iconBg: book.iconBg,
                      customImage: book.customImage,
                    ),
                    if (index < books.length - 1) _buildDivider(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookItem({
    required int index,
    IconData? icon,
    required String title,
    required Color iconBg,
    bool customImage = false,
  }) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        color: isSelected ? const Color(0xFF3A3A4A) : Colors.transparent,
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconBg,
                shape: BoxShape.circle,
              ),
              child: customImage
                  ? ClipOval(
                      child: Image.network(
                        'https://images.unsplash.com/photo-1482517967863-00e15c9b44be?w=100&h=100&fit=crop',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.celebration,
                            color: Colors.white70,
                            size: 28,
                          );
                        },
                      ),
                    )
                  : icon != null
                      ? Icon(icon, color: Colors.white, size: 28)
                      : const SizedBox(),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 14),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: AppTheme.amountPosTextColor,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 1,
        color: const Color(0xFF3A3A4A),
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom +
        MediaQuery.of(context).padding.bottom;

    return Padding(
      padding: EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        top: 20.0,
        bottom: bottomPadding > 0 ? bottomPadding : 20.0,
      ),
      child: AppButton(
        textString: 'Submit',
        buttonType: ButtonType.filled,
        expandButton: true,
        buttonState:
            selectedIndex != null ? ButtonState.enabled : ButtonState.disabled,
        onPressed: (_) {
          Navigator.pop(context);
        },
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        enabledButtonFilledStyle: BoxDecoration(
          color: AppTheme.amountPosTextColor,
          borderRadius: BorderRadius.circular(30),
        ),
        enabledTextStyle: AppTheme.loginText.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class BookData {
  final IconData? icon;
  final String title;
  final Color iconBg;
  final bool customImage;

  BookData({
    this.icon,
    required this.title,
    required this.iconBg,
    this.customImage = false,
  });
}
