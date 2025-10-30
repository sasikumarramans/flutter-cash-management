import 'package:bearnshare/app/di/base/injectable_module.dart';
import 'package:bearnshare/data/network/group/group_api.dart';
import 'package:bearnshare/data/network/split_add/split_api.dart';
import 'package:bearnshare/domain/group/group_repository.dart';
import 'package:bearnshare/domain/group/use_cases/search_users_use_case.dart';
import 'package:bearnshare/domain/split_add/split_repository.dart';
import 'package:bearnshare/domain/split_add/use_cases/add_split_use_case.dart';
import 'package:bearnshare/presentation/split_add/bloc/add_expense_split_bloc.dart';

class AddSplitModule extends InjectableModule {
  @override
  Future<void> inject() async {
    safeRegisterSingleton<GroupRepository>(() => GroupApi());
    safeRegisterSingleton<SplitRepository>(() => SplitApi());
    safeRegisterSingleton<AddSplitUseCase>(() => AddSplitUseCase());
    safeRegisterSingleton<SearchUsersUseCase>(() => SearchUsersUseCase());
  }

  @override
  void injectBloc() {
    safeRegisterSingleton<AddExpenseSplitBloc>(() => AddExpenseSplitBloc());
  }

  @override
  void dispose() {
    safeUnregister<SplitRepository>();
    safeUnregister<GroupRepository>();
    safeUnregister<AddSplitUseCase>();
    safeUnregister<SearchUsersUseCase>();
    safeUnregister<AddExpenseSplitBloc>();
  }
}
