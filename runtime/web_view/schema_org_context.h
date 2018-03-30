// Copyright 2017 The Fuchsia Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#pragma once

#include <string>
#include <vector>

#include <fuchsia/cpp/modular.h>

class WebView;

class SchemaOrgContext {
 public:
  SchemaOrgContext(WebView& web_view);

  void set_context_writer(modular::ContextWriterPtr context_writer) {
    context_writer_ = std::move(context_writer);
  }
  void set_component_context(modular::ComponentContextPtr component_context) {
    component_context_ = std::move(component_context);
  }

 private:
  void PageLoaded();
  void EntitiesChanged();

  WebView& web_view_;
  std::string script_ = "";

  modular::ComponentContextPtr component_context_;
  modular::ContextWriterPtr context_writer_;
  std::vector<modular::ContextValueWriterPtr> context_values_;
};
