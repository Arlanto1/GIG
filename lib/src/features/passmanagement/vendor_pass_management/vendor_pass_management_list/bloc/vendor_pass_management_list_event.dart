
part of 'vendor_pass_management_list_bloc.dart';

abstract class VendorPassManagementListEvent extends Equatable {
  const VendorPassManagementListEvent();

  @override
  List<Object?> get props => [];
}

class FetchVendorPassData extends VendorPassManagementListEvent {
  final int startPos;
  final int maxPos;
  final bool newSearch;
  final BaseFilterModel filters;

  const FetchVendorPassData(
      {required this.startPos,
        required this.maxPos,
        required this.newSearch,
        required this.filters});
}

class InitializeVendorPassValues extends VendorPassManagementListEvent {
  const InitializeVendorPassValues();
}

class RefreshVendorPassList extends VendorPassManagementListEvent {
  const RefreshVendorPassList();
}
