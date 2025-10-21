import 'package:bearnshare/app/theme/app_theme.dart';
import 'package:bearnshare/domain/ledger/model/get_entries_response.dart';
import 'package:bearnshare/presentation/component/app_button.dart';
import 'package:bearnshare/presentation/component/app_text_field.dart';
import 'package:bearnshare/presentation/ledger_book/bloc/ledger_book_bloc.dart';
import 'package:bearnshare/presentation/ledger_book/book_selection_dialog.dart';
import 'package:bearnshare/presentation/ledger_entries/bloc/ledger_entries_bloc.dart';
import 'package:bearnshare/presentation/ledger_entries/bloc/ledger_entries_event.dart';
import 'package:bearnshare/presentation/ledger_entries/bloc/ledger_entries_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class AddIncomeScreen extends StatefulWidget {
  final int bookId;
  final String entryType;
  final int? entryId;
  final EntryItem? entryItem;

  const AddIncomeScreen({
    super.key,
    required this.bookId,
    this.entryType = 'EXPENSE',
    this.entryId,
    this.entryItem,
  });

  @override
  State<AddIncomeScreen> createState() => _AddIncomeScreenState();
}

class _AddIncomeScreenState extends State<AddIncomeScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final _bloc = GetIt.I<LedgerEntriesBloc>();
  late DateTime _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _selectedDateTime = DateTime.now();
    _dateController.text = _formatDateTime(_selectedDateTime);
    if (widget.entryItem != null) {
      _bloc.add(InitializeEntryEditMode(
        entryItem: widget.entryItem!,
      ));
      _descriptionController.text = widget.entryItem?.title ?? "";
      _amountController.text = (widget.entryItem?.amount ?? 0).toString();
      try {
        _selectedDateTime = DateTime.parse(widget.entryItem!.dateTime!);
        _dateController.text = _formatDateTime(_selectedDateTime);
      } catch (e) {
        _dateController.text = _formatDateTime(DateTime.now());
      }
    } else {
      _bloc.add(InitializeBookForEntry(
        bookId: widget.bookId,
        entryType: widget.entryType,
      ));
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _dateController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy, hh:mm a').format(dateTime);
  }

  void _showDateTimePicker() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppTheme.amountPosTextColor,
              onPrimary: Colors.white,
              surface: AppTheme.homePageCardBgColor,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
        builder: (context, child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.dark(
                primary: AppTheme.amountPosTextColor,
                onPrimary: Colors.white,
                surface: AppTheme.homePageCardBgColor,
                onSurface: Colors.white,
              ),
            ),
            child: child!,
          );
        },
      );

      if (time != null) {
        _selectedDateTime = DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        );
        _dateController.text = _formatDateTime(_selectedDateTime);
        _bloc.add(DateTimeChanged(_selectedDateTime.toIso8601String()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LedgerEntriesBloc, LedgerEntriesState>(
      listener: (context, state) {
        if (state.status == CreateEntriesStatus.success) {
          context.pop(true);
        }
      },
      builder: (context, state) {
        final isEditMode = state.isEditMode;
        final entryType = state.type;
        final isIncome = entryType == 'INCOME';

        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                _buildHeader(isEditMode, isIncome),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildAmountSection(state, isIncome),
                        _buildFormSection(state),
                      ],
                    ),
                  ),
                ),
                _buildActionButtons(state),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(bool isEditMode, bool isIncome) {
    return Container(
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
            isEditMode
                ? 'Edit ${isIncome ? 'Income' : 'Expense'}'
                : 'Add ${isIncome ? 'Income' : 'Expense'}',
            style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountSection(LedgerEntriesState state, bool isIncome) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30),
      decoration: const BoxDecoration(
        color: AppTheme.homePageCardBgColor,
        border: Border(
          bottom: BorderSide(color: Color(0xFF3A3A4A), width: 1),
        ),
      ),
      child: Column(
        children: [
          _buildTypeToggle(state, isIncome),
          const SizedBox(height: 20),
          const Text(
            'Amount',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.homePageCardBgColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Row(
                  children: [
                    Text(
                      '₹',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_drop_down, color: Colors.white, size: 24),
                  ],
                ),
              ),
              Flexible(
                child: IntrinsicWidth(
                  child: AppTextField(
                    controller: _amountController,
                    textFieldType: TextFieldType.mobile,
                    textAlign: TextAlign.center,
                    textFieldStyle: TextFieldStyle.filled,
                    textFieldState: TextFieldState.enabled,
                    textStyle: AppTheme.homePageContentAmntTextStyle
                        .copyWith(fontSize: 36, color: Colors.white),
                    hint: '0.00',
                    filledEnabledStyle: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: AppTheme.homePageContentAmntTextStyle
                          .copyWith(fontSize: 36, color: Colors.grey),
                    ),
                    onChanged: (value) {
                      _bloc.add(AmountChanged(value));
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFormSection(LedgerEntriesState state) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!state.isEditMode) _buildBookSelectionField(state),
          if (!state.isEditMode) const SizedBox(height: 24),
          _buildDescriptionField(state),
          const SizedBox(height: 24),
          _buildDateTimeField(),
        ],
      ),
    );
  }

  Widget _buildDescriptionField(LedgerEntriesState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: 'Particulars',
            style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 15),
            children: const [
              TextSpan(
                text: '*',
                style: TextStyle(
                  color: Color(0xFFFF5252),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        AppTextField(
          controller: _descriptionController,
          textFieldStyle: TextFieldStyle.filled,
          textFieldState: TextFieldState.enabled,
          textFieldType: TextFieldType.text,
          hint: 'Enter description',
          maxLines: 3,
          onChanged: (value) {
            _bloc.add(EntriesNameChanged(value));
          },
          onValidation: (isValid) {
            _bloc.add(EntriesNameCompleted(isValid: isValid));
          },
          padding: const EdgeInsets.all(16),
        ),
      ],
    );
  }

  Widget _buildBookSelectionField(LedgerEntriesState state) {
    final selectedBook = GetIt.I<LedgerBookBloc>().state.selectedBookItem;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Book',
          style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 15),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: _showBookSelectionDialog,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.homePageCardBgColor.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.splitBorderLineColor,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.book,
                  color: Colors.white60,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    selectedBook?.name ?? 'Select Book',
                    style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 14),
                  ),
                ),
                const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white60,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showBookSelectionDialog() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BlocProvider<LedgerBookBloc>.value(
        value: GetIt.I<LedgerBookBloc>(),
        child: const BookSelectionDialog(),
      ),
    );
    _bloc.add(InitializeBookForEntry(
      bookId: GetIt.I<LedgerBookBloc>().state.selectedBookItem?.id ?? 0,
      entryType: _bloc.state.type,
    ));
  }

  Widget _buildDateTimeField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date & Time',
          style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 15),
        ),
        const SizedBox(height: 12),
        AppTextField(
          controller: _dateController,
          textFieldStyle: TextFieldStyle.filled,
          textFieldState: TextFieldState.enabled,
          textFieldType: TextFieldType.text,
          readOnly: true,
          suffixIcon: const Icon(
            Icons.calendar_today,
            color: Colors.white60,
            size: 20,
          ),
          onTap: _showDateTimePicker,
          padding: const EdgeInsets.all(16),
        ),
      ],
    );
  }

  Widget _buildTypeToggle(LedgerEntriesState state, bool isIncome) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF3A3A4A),
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              if (!isIncome) {
                _bloc.add(const TypeChanged('INCOME'));
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              decoration: BoxDecoration(
                color:
                    isIncome ? AppTheme.amountPosTextColor : Colors.transparent,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                'Income',
                style: AppTheme.ledgerTitleTextStyle,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (isIncome) {
                _bloc.add(const TypeChanged('EXPENSE'));
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              decoration: BoxDecoration(
                color:
                    !isIncome ? AppTheme.addExpenseBtnClr : Colors.transparent,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                'Expense',
                style: AppTheme.ledgerTitleTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(LedgerEntriesState state) {
    final isEditMode = state.isEditMode;
    final isIncome = state.type == 'INCOME';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        children: [
          AppButton(
            textString: isEditMode ? 'Update' : 'Save',
            buttonType: ButtonType.filled,
            expandButton: true,
            buttonState: state.isButtonEnabled
                ? ButtonState.enabled
                : ButtonState.disabled,
            onPressed: (_) {
              if (isEditMode) {
                _bloc.add(const UpdateEntry());
              } else {
                _bloc.add(const CreateEntry());
              }
            },
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
            enabledButtonFilledStyle: BoxDecoration(
              color: AppTheme.splitGroupColor,
              borderRadius: BorderRadius.circular(30),
            ),
            enabledTextStyle: AppTheme.loginText.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          if (isEditMode)
            AppButton(
              textString: 'Delete',
              buttonType: ButtonType.filled,
              expandButton: true,
              buttonState: ButtonState.enabled,
              onPressed: (_) {
                _bloc.add(DeleteEntry(widget.entryId!));
              },
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
              enabledButtonFilledStyle: BoxDecoration(
                color: AppTheme.addExpenseBtnClr.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(30),
              ),
              enabledTextStyle: AppTheme.loginText.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isIncome
                    ? AppTheme.addExpenseBtnClr
                    : AppTheme.addExpenseBtnClr,
              ),
            ),
        ],
      ),
    );
  }
}
