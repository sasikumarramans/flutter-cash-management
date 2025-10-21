import 'package:bearnshare/app/theme/app_theme.dart';
import 'package:bearnshare/domain/ledger/model/get_books_response.dart';
import 'package:bearnshare/presentation/component/app_button.dart';
import 'package:bearnshare/presentation/component/app_text_field.dart';
import 'package:bearnshare/presentation/create_book/bloc/create_book_bloc.dart';
import 'package:bearnshare/presentation/create_book/bloc/create_book_event.dart';
import 'package:bearnshare/presentation/create_book/bloc/create_book_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class AddBookScreen extends StatefulWidget {
  final BooksItem? bookItem;

  const AddBookScreen({super.key, this.bookItem});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final TextEditingController _bookNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late final CreateBookBloc _bloc;
  int? selectedIconIndex;

  final List<IconData> defaultIcons = [
    Icons.flight,
    Icons.home,
    Icons.group,
    Icons.coffee,
    Icons.restaurant,
    Icons.credit_card,
    Icons.favorite,
    Icons.directions_car,
  ];

  final List<String> currencies = ['INR', 'USD', 'EUR', 'GBP'];

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.I.get<CreateBookBloc>();
    _bloc.add(const InitBook());
    if (widget.bookItem != null) {
      _bloc.add(InitializeEditMode(bookItem: widget.bookItem!));
      _bookNameController.text = widget.bookItem!.name;
      _descriptionController.text = widget.bookItem!.description;
    }
  }

  @override
  void dispose() {
    _bookNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBackgroundColor,
      body: SafeArea(
        child: BlocConsumer<CreateBookBloc, CreateBookState>(
          listener: (context, state) {
            if (state.status == CreateBookStatus.success) {
              context.pop();
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                _buildHeader(context, state),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildBookNameField(),
                        const SizedBox(height: 16),
                        _buildDescriptionField(),
                      ],
                    ),
                  ),
                ),
                _buildCreateButton(state),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, CreateBookState state) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              context.pop();
            },
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Text(
            state.isEditMode ? 'Edit Book' : 'Add Book',
            style:
                AppTheme.homePageContentHeaderTextStyle.copyWith(fontSize: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildBookNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Book Name',
          style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 15),
        ),
        const SizedBox(height: 12),
        AppTextField(
          controller: _bookNameController,
          textFieldStyle: TextFieldStyle.outlined,
          textFieldState: TextFieldState.enabled,
          textFieldType: TextFieldType.text,
          onChanged: (value) {
            context.read<CreateBookBloc>().add(
                  BookNameChanged(value),
                );
          },
          onValidation: (isValid) => context
              .read<CreateBookBloc>()
              .add(BookNameCompleted(isValid: isValid)),
          textStyle: AppTheme.historyTextStyle.copyWith(fontSize: 15),
          outlinedEnabledStyle: InputDecoration(
            hintText: 'Enter a Book Name',
            hintStyle: AppTheme.homePageTitleTextStyle.copyWith(
              fontSize: 15,
              color: AppTheme.homePageSubtitleColor,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(color: AppTheme.splitBorderLineColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(color: AppTheme.splitBorderLineColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(color: AppTheme.splitBorderLineColor),
            ),
            filled: true,
            fillColor: AppTheme.primaryColor,
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 15),
        ),
        const SizedBox(height: 12),
        AppTextField(
          controller: _descriptionController,
          textFieldStyle: TextFieldStyle.outlined,
          textFieldState: TextFieldState.enabled,
          textFieldType: TextFieldType.text,
          onChanged: (value) {
            context.read<CreateBookBloc>().add(
                  BookDescChanged(value),
                );
          },
          textStyle: AppTheme.historyTextStyle.copyWith(fontSize: 15),
          outlinedEnabledStyle: InputDecoration(
            hintText: 'Enter Description',
            hintStyle: AppTheme.homePageTitleTextStyle.copyWith(
              fontSize: 15,
              color: AppTheme.homePageSubtitleColor,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(color: AppTheme.splitBorderLineColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(color: AppTheme.splitBorderLineColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(color: AppTheme.splitBorderLineColor),
            ),
            filled: true,
            fillColor: AppTheme.primaryColor,
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }

  Widget _buildCreateButton(CreateBookState state) {
    final isButtonEnabled = state.isButtonEnabled;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: AppButton(
        textString: state.isEditMode ? 'Update Book' : 'Create Book',
        buttonType: ButtonType.filled,
        expandButton: true,
        buttonState:
            isButtonEnabled ? ButtonState.enabled : ButtonState.disabled,
        onPressed: (_) {
          if (state.isEditMode) {
            _bloc.add(const EditBook());
          } else {
            _bloc.add(const CreateBook());
          }
        },
        enabledButtonFilledStyle: BoxDecoration(
          color: AppTheme.splitGroupColor,
          borderRadius: BorderRadius.circular(12),
        ),
        enabledTextStyle: AppTheme.loginText.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      ),
    );
  }
}
