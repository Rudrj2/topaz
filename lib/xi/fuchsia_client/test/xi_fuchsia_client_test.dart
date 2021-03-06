// Copyright 2018 The Fuchsia Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:test/test.dart';
import 'package:xi_fuchsia_client/client.dart';

void main() {
  test('XiFuchsiaClient constructor', () {
    XiFuchsiaClient client = new XiFuchsiaClient(null);
    expect(client.initialized, equals(false));
  });
}
