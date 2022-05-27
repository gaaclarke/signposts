
import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:isolate';
import 'package:ffi/ffi.dart';

import 'signposts_bindings_generated.dart';

/// Emits a Point-of-interest signpost for the "flutter" category.  These will
/// show up in Instruments with the "Points of interest" instrument.
void emitEvent(String msg) {
  int result = _bindings.flt_signposts_emit(msg.toNativeUtf8().cast());
  if (result != 0) {
    throw Exception('emitEvent error: $result');
  }
}

/// Starts recording a region.
/// see also: [endInterval]
void beginInterval(int identifier, String msg) {
  int result = _bindings.flt_signposts_begin_interval(identifier, msg.toNativeUtf8().cast());
  if (result != 0) {
    throw Exception('beginInterval error: $result');
  }
}

/// Ends recording a region (previously started with beginInterval).
/// see also: [beginInterval]
void endInterval(int identifier, String msg) {
  int result = _bindings.flt_signposts_end_interval(identifier, msg.toNativeUtf8().cast());
  if (result != 0) {
    throw Exception('beginInterval error: $result');
  }
}

/// Convenience wrapper for [beginInterval] and [endInterval].
class Interval {
  static int _count = 1;
  Interval(String msg) : identifier = _count++ {
    beginInterval(identifier, msg);
  }
  final int identifier;
  void end(String msg) {
    endInterval(identifier, msg);
  }
}

const String _libName = 'signposts';

/// The dynamic library in which the symbols for [SignpostsBindings] can be found.
final DynamicLibrary _dylib = () {
  if (Platform.isMacOS || Platform.isIOS) {
    return DynamicLibrary.open('$_libName.framework/$_libName');
  }
  if (Platform.isAndroid || Platform.isLinux) {
    return DynamicLibrary.open('lib$_libName.so');
  }
  if (Platform.isWindows) {
    return DynamicLibrary.open('$_libName.dll');
  }
  throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
}();

/// The bindings to the native functions in [_dylib].
final SignpostsBindings _bindings = SignpostsBindings(_dylib);
