
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
