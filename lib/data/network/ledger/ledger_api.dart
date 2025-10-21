import 'package:bearnshare/data/network/core/dio_client.dart';
import 'package:bearnshare/domain/ledger/ledger_repository.dart';
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
import 'package:get_it/get_it.dart';

class LedgerApi extends LedgerRepository {
  final _dioClient = GetIt.I<DioClient>();
  static const String _entriesPath = '/api/entries';
  static const String _recentEntriesPath = '/api/entries/recent';
  static const String _dashboardPath = '/api/entries/dashboard';
  static const String _searchEntriesPath = '/api/entries/search';
  static const String _reportSummaryPath = '/api/reports/user/summary';
  static const String _createBookPath = '/api/books';
  static const String _getBookPath = '/api/books';
  static const String _searchBooksPath = '/api/books/search';
  static const String _deleteBookPath = '/api/books';

  @override
  Future<EntriesData> getEntries(GetEntriesRequest request) async {
    final response = await _dioClient.getRequest<EntriesData>(
      _entriesPath,
      queryParameters: request.toJson(),
      parseDataJson: EntriesData.fromJson,
    );
    return response;
  }

  @override
  Future<EntriesData> getRecentEntries(
      GetRecentEntriesRequest request, CancelToken? cancelToken) async {
    final response = await _dioClient.getRequest<EntriesData>(
      _recentEntriesPath,
      queryParameters: request.toJson(),
      parseDataJson: EntriesData.fromJson,
      cancelToken: cancelToken,
    );
    return response;
  }

  @override
  Future<EntriesData> searchEntries(
      SearchEntriesRequest request, CancelToken? cancelToken) async {
    final response = await _dioClient.getRequest<EntriesData>(
        _searchEntriesPath,
        queryParameters: request.toJson(),
        parseDataJson: EntriesData.fromJson,
        cancelToken: cancelToken);
    return response;
  }

  @override
  Future<CreateBookResponse> createBook(CreateBookRequest request) async {
    final response = await _dioClient.postRequest<CreateBookResponse>(
      _createBookPath,
      data: request.toJson(),
      parseDataJson: CreateBookResponse.fromJson,
    );
    return response;
  }

  @override
  Future<BooksResponse> getBooks(GetBooksRequest request) async {
    final response = await _dioClient.getRequest<BooksResponse>(
      _getBookPath,
      queryParameters: request.toJson(),
      parseDataJson: BooksResponse.fromJson,
    );
    return response;
  }

  @override
  Future<BooksResponse> searchBooks(
      SearchBooksRequest request, CancelToken? cancelToken) async {
    final response = await _dioClient.getRequest<BooksResponse>(
        _searchBooksPath,
        queryParameters: request.toJson(),
        parseDataJson: BooksResponse.fromJson,
        cancelToken: cancelToken);
    return response;
  }

  @override
  Future<CreateBookResponse> deleteBook(int bookId) async {
    final response = await _dioClient.deleteRequest<CreateBookResponse>(
      '$_deleteBookPath/$bookId',
      parseDataJson: CreateBookResponse.fromJson,
    );
    return response;
  }

  @override
  Future<CreateBookResponse> editBook(EditBookRequest request) async {
    final response = await _dioClient.putRequest<CreateBookResponse>(
      '$_createBookPath/${request.id}',
      data: request.toJson(),
      parseDataJson: CreateBookResponse.fromJson,
    );
    return response;
  }

  @override
  Future<CreateEntryResponse> createEntry(CreateEntryRequest request) async {
    final response = await _dioClient.postRequest<CreateEntryResponse>(
      _entriesPath,
      data: request.toJson(),
      parseDataJson: CreateEntryResponse.fromJson,
    );
    return response;
  }

  @override
  Future<CreateEntryResponse> updateEntry(UpdateEntryRequest request) async {
    final response = await _dioClient.putRequest<CreateEntryResponse>(
      '$_entriesPath/${request.id}',
      data: request.toJson(),
      parseDataJson: CreateEntryResponse.fromJson,
    );
    return response;
  }

  @override
  Future<CreateEntryResponse> deleteEntry(int entryId) async {
    final response = await _dioClient.deleteRequest<CreateEntryResponse>(
      '$_entriesPath/$entryId',
      parseDataJson: CreateEntryResponse.fromJson,
    );
    return response;
  }

  @override
  Future<CreateBookResponse> getBookById(int request) async {
    final response = await _dioClient.getRequest<CreateBookResponse>(
      '$_getBookPath/$request',
      parseDataJson: CreateBookResponse.fromJson,
    );
    return response;
  }

  @override
  Future<DashboardResponse> getDashboard(GetDashboardRequest request) async {
    final response = await _dioClient.getRequest<DashboardResponse>(
      _dashboardPath,
      queryParameters: request.toJson(),
      parseDataJson: DashboardResponse.fromJson,
    );
    return response;
  }

  @override
  Future<ReportSummaryData> getReportSummary(
      GetReportSummaryRequest request) async {
    final response = await _dioClient.getRequest<ReportSummaryData>(
      _reportSummaryPath,
      queryParameters: request.toJson(),
      parseDataJson: ReportSummaryData.fromJson,
    );
    return response;
  }
}
