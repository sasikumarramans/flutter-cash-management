import 'package:bearnshare/app/theme/app_theme.dart';
import 'package:bearnshare/generated/assets.gen.dart';
import 'package:bearnshare/presentation/component/app_button.dart';
import 'package:bearnshare/presentation/component/app_text_field.dart';
import 'package:bearnshare/presentation/ledger_book/bloc/ledger_book_bloc.dart';
import 'package:bearnshare/presentation/ledger_book/bloc/ledger_book_event.dart';
import 'package:bearnshare/presentation/ledger_book/bloc/ledger_book_state.dart';
import 'package:bearnshare/presentation/main_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class BookSelectionDialog extends StatefulWidget {
  final Function(int bookId, String bookName)? onBookSelected;

  const BookSelectionDialog({super.key, this.onBookSelected});

  @override
  State<BookSelectionDialog> createState() => _BooksBottomSheetState();
}

class _BooksBottomSheetState extends State<BookSelectionDialog> {
  final TextEditingController _searchController = TextEditingController();
  late final LedgerBookBloc _bloc;
  late final ScrollController _scrollController;
  int? selectedBookId;

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.I.get<LedgerBookBloc>();
    _bloc.add(const LoadBooks());
    selectedBookId = GetIt.I.get<LedgerBookBloc>().state.selectedBookItem?.id;
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      _bloc.add(const LoadMoreBooks());
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
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
          //  _buildSubmitButton(context),
        ],
      ),
    );
  }

  void _handleDeleteBook(book) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.homePageCardBgColor,
        title: Text(
          'Delete Book',
          style: AppTheme.ledgerTitleTextStyle
              .copyWith(color: AppTheme.addExpenseBtnClr),
        ),
        content: Text(
          'Are you sure you want to delete this book?',
          style: AppTheme.homePageTitleTextStyle,
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text(
              'Cancel',
              style: AppTheme.homePageTitleTextStyle.copyWith(
                color: AppTheme.genderInfoTextColor,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              context.pop();
              _bloc.add(DeleteBook(book.id));
            },
            child: Text(
              'Delete',
              style: AppTheme.homePageTitleTextStyle.copyWith(
                color: AppTheme.addExpenseBtnClr,
              ),
            ),
          ),
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
            style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 16),
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
        debounceDuration: const Duration(milliseconds: 1000),
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.white54,
          size: 22,
        ),
        onChanged: (value) {
          _bloc.add(SearchBooksChanged(value));
        },
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      ),
    );
  }

  Widget _buildBooksList() {
    return Expanded(
      child: BlocConsumer<LedgerBookBloc, LedgerBookState>(
        bloc: _bloc,
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '',
                      style:
                          AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 18),
                    ),
                    AppButton(
                      textString: 'Add',
                      buttonType: ButtonType.filled,
                      leadingIcon: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 16,
                      ),
                      onPressed: (_) {
                        context.pop();
                        context.pushNamed(MainRouter.addBookRoute);
                      },
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
                child: _buildBooksListContent(state),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBooksListContent(LedgerBookState state) {
    if (state.books.isEmpty) {
      return Center(
        child: Text(
          'No books found',
          style: AppTheme.ledgerTitleTextStyle.copyWith(
            color: AppTheme.genderInfoTextColor,
          ),
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.zero,
      itemCount: state.books.length + 1,
      itemBuilder: (context, index) {
        if (index == state.books.length) {
          return state.isLoadingMoreBooks
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppTheme.amountPosTextColor,
                    ),
                  ),
                )
              : const SizedBox(height: 20);
        }

        final book = state.books[index];
        final isSelected = selectedBookId == book.id;

        return Column(
          children: [
            _buildBookItemFromApi(
              book: book,
              index: index,
              isSelected: isSelected,
            ),
            if (index < state.books.length - 1) _buildDivider(),
          ],
        );
      },
    );
  }

  Widget _buildBookItemFromApi({
    required book,
    required int index,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: () {
        _bloc.add(SelectedBook(book));
        _bloc.add(LoadEntries(bookId: book.id));
        context.pop();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        color: Colors.transparent,
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFF4A4A5A),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.book, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.name,
                    style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 14),
                  ),
                  if (book.description.isNotEmpty)
                    Text(
                      book.description,
                      style: AppTheme.homePageTitleTextStyle.copyWith(
                        fontSize: 12,
                        color: AppTheme.genderInfoTextColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                context.pushNamed(MainRouter.addBookRoute,
                    extra: {"bookItem": book});
              },
              child: Assets.icons.editIcon.svg(),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () {
                _handleDeleteBook(book);
              },
              child: Assets.icons.deleteIcon.svg(),
            ),
            const SizedBox(width: 12),
            Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              color: isSelected
                  ? AppTheme.amountPosTextColor
                  : AppTheme.splitBorderLineColor,
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
        color: AppTheme.splitBorderLineColor,
      ),
    );
  }
}
