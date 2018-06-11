// Copyright 2018 The Fuchsia Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';
import 'dart:typed_data';

import '../schema/schema.dart';

/// Uniquely identifies a document.
class DocumentId {
  /// The schema of the document.
  final Schema schema;

  Uint8List _subId;
  static const int _subIdByteCount = 16;
  static const int _schemahashByteCount = 20;
  static final Random _random = new Random();

  /// Default constructor.
  /// |identifier| uniquely identifies documents for the given schema.
  /// |identifier| must be 16 bytes long.
  /// If absent, a randomly generated |identifier| is used.
  DocumentId(this.schema, [Uint8List identifier]) {
    identifier ??= _randomByteArrayForSubIds();
    if (identifier.length != _subIdByteCount) {
      throw new ArgumentError('identifier does not contain 16 bytes');
    }
    _subId = new Uint8List.fromList(identifier);
  }

  /// Convenience factory that builds a DocumentId from the |identifier|'s 8 lowest bytes.
  factory DocumentId.fromIntId(Schema schema, int identifier) {
    Uint8List bytes = new Uint8List(_subIdByteCount)
      ..buffer.asByteData().setUint64(0, identifier, Endian.little);
    return new DocumentId(schema, bytes);
  }

  /// Returns the 36 bytes long prefix to be used to store in Ledger the
  /// document identified with this DocumentId.
  Uint8List get prefix {
    Uint8List prefix = new Uint8List(_schemahashByteCount + _subIdByteCount);
    Uint8List schemaHash = schema.hash;
    assert(schemaHash.length == _schemahashByteCount);
    prefix..setAll(0, schemaHash)..setAll(_schemahashByteCount, _subId);
    return prefix;
  }

  static Uint8List _randomByteArrayForSubIds() {
    final array = new Uint8List(_subIdByteCount);
    for (int i = 0; i < _subIdByteCount; i++) {
      array[i] = _random.nextInt(255);
    }
    return array;
  }
}