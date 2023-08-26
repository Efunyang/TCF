// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_repo_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authRepoHash() => r'e1ca4ee3ff699506340e2a8a75a232c28a8128be';

/// See also [authRepo].
@ProviderFor(authRepo)
final authRepoProvider = Provider<IntfAuthRepo>.internal(
  authRepo,
  name: r'authRepoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authRepoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthRepoRef = ProviderRef<IntfAuthRepo>;
String _$authStateChangesHash() => r'ad9e31320fa9170ce805a06406a3176b89e49af8';

/// See also [authStateChanges].
@ProviderFor(authStateChanges)
final authStateChangesProvider = StreamProvider<Auth?>.internal(
  authStateChanges,
  name: r'authStateChangesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authStateChangesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthStateChangesRef = StreamProviderRef<Auth?>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
