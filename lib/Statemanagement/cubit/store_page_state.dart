part of 'store_page_cubit.dart';

@immutable
sealed class StorePageState {}

final class StorePageInitial extends StorePageState {}

final class StorePageSubscriptionSuccess extends StorePageState {}

final class StorePageIconPurchased extends StorePageState {}
