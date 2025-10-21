import 'package:bearnshare/domain/ledger/model/create_book_request.dart';
import 'package:bearnshare/domain/ledger/model/create_book_response.dart';
import 'package:bearnshare/domain/ledger/model/create_entry_request.dart';
import 'package:bearnshare/domain/ledger/model/create_entry_response.dart';
import 'package:bearnshare/domain/ledger/model/edit_book_request.dart';
import 'package:bearnshare/domain/ledger/model/get_books_request.dart';
import 'package:bearnshare/domain/ledger/model/get_books_response.dart';
import 'package:bearnshare/domain/ledger/model/get_dashboard_request.dart';
import 'package:bearnshare/domain/ledger/model/get_dashboard_response.dart';
import 'package:bearnshare/domain/ledger/model/get_entries_request.dart';
import 'package:bearnshare/domain/ledger/model/get_entries_response.dart';
import 'package:bearnshare/domain/ledger/model/get_recent_entries_request.dart';
import 'package:bearnshare/domain/ledger/model/search_books_request.dart';
import 'package:bearnshare/domain/ledger/model/search_entries_request.dart';
import 'package:bearnshare/domain/ledger/model/update_entry_request.dart';
import 'package:bearnshare/domain/reports/model/get_report_summary_request.dart';
import 'package:bearnshare/domain/reports/model/get_report_summary_response.dart';
import 'package:dio/dio.dart';

abstract class LedgerRepository {
  Future<EntriesData> getEntries(GetEntriesRequest request);
  Future<EntriesData> getRecentEntries(
      GetRecentEntriesRequest request, CancelToken? cancelToken);
  Future<EntriesData> searchEntries(
      SearchEntriesRequest request, CancelToken? cancelToken);
  Future<CreateBookResponse> createBook(CreateBookRequest request);
  Future<BooksResponse> getBooks(GetBooksRequest request);
  Future<BooksResponse> searchBooks(
      SearchBooksRequest request, CancelToken? cancelToken);
  Future<CreateBookResponse> deleteBook(int bookId);
  Future<CreateBookResponse> editBook(EditBookRequest request);
  Future<CreateEntryResponse> createEntry(CreateEntryRequest request);
  Future<CreateEntryResponse> updateEntry(UpdateEntryRequest request);
  Future<CreateEntryResponse> deleteEntry(int entryId);
  Future<CreateBookResponse> getBookById(int bookId);
  Future<DashboardResponse> getDashboard(GetDashboardRequest request);
  Future<ReportSummaryData> getReportSummary(GetReportSummaryRequest request);
}
