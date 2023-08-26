// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_repo_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userRepoHash() => r'6c7d1b06ec2ce5b654e658a01f25769098958c29';

/// See also [userRepo].
@ProviderFor(userRepo)
final userRepoProvider = Provider<IntfUserRepo>.internal(
  userRepo,
  name: r'userRepoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userRepoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserRepoRef = ProviderRef<IntfUserRepo>;
String _$userStateChangesHash() => r'9836b5bd39859f72fbd57e8adf7ca74da5bbccb7';

/// See also [userStateChanges].
@ProviderFor(userStateChanges)
final userStateChangesProvider = StreamProvider<User?>.internal(
  userStateChanges,
  name: r'userStateChangesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userStateChangesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserStateChangesRef = StreamProviderRef<User?>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
