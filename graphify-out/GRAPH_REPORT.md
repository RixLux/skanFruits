# Graph Report - .  (2026-05-24)

## Corpus Check

<details markdown="1">
<summary>Click to see details</summary>

- 16 files · ~9,699 words
- Verdict: corpus is large enough that graph structure adds value.

</details>

## Summary

<details markdown="1">
<summary>Click to see details</summary>

- 247 nodes · 243 edges · 42 communities (28 shown, 14 thin omitted)
- Extraction: 95% EXTRACTED · 5% INFERRED · 0% AMBIGUOUS · INFERRED: 13 edges (avg confidence: 0.86)
- Token cost: 0 input · 0 output

</details>

## Community Hubs (Navigation)

<details markdown="1">
<summary>Click to see details</summary>

- [[_COMMUNITY_Scanner UI & Camera Flow|Scanner UI & Camera Flow]]
- [[_COMMUNITY_Windows Native Implementation|Windows Native Implementation]]
- [[_COMMUNITY_AI Config & Label Mapping|AI Config & Label Mapping]]
- [[_COMMUNITY_Debugging & LLDB Helpers|Debugging & LLDB Helpers]]
- [[_COMMUNITY_Branding & Main Entry|Branding & Main Entry]]
- [[_COMMUNITY_Linux Platform Runner|Linux Platform Runner]]
- [[_COMMUNITY_Scanning Controller & Logic|Scanning Controller & Logic]]
- [[_COMMUNITY_Windows Runner Entry|Windows Runner Entry]]
- [[_COMMUNITY_macOS Plugin Registration|macOS Plugin Registration]]
- [[_COMMUNITY_Web App Manifest|Web App Manifest]]
- [[_COMMUNITY_Project Metadata|Project Metadata]]
- [[_COMMUNITY_Swift Unit Tests|Swift Unit Tests]]
- [[_COMMUNITY_Asset Metadata (LaunchImage)|Asset Metadata (LaunchImage)]]
- [[_COMMUNITY_Flutter Widget Tests|Flutter Widget Tests]]
- [[_COMMUNITY_Asset Metadata (AppIcon)|Asset Metadata (AppIcon)]]
- [[_COMMUNITY_Asset Metadata (Generic)|Asset Metadata (Generic)]]
- [[_COMMUNITY_Android Native Config|Android Native Config]]
- [[_COMMUNITY_Dart Package Graph|Dart Package Graph]]
- [[_COMMUNITY_Web Icons & Favicon|Web Icons & Favicon]]
- [[_COMMUNITY_Gemini Settings & Hooks|Gemini Settings & Hooks]]
- [[_COMMUNITY_iOS Launch Screen|iOS Launch Screen]]
- [[_COMMUNITY_macOS App Icons|macOS App Icons]]
- [[_COMMUNITY_Windows Build System|Windows Build System]]
- [[_COMMUNITY_Web Plugin Registration|Web Plugin Registration]]
- [[_COMMUNITY_Graphify Documentation|Graphify Documentation]]
- [[_COMMUNITY_iOS Environment Setup|iOS Environment Setup]]
- [[_COMMUNITY_PRD & Project Docs|PRD & Project Docs]]
- [[_COMMUNITY_Flutter External Docs|Flutter External Docs]]
- [[_COMMUNITY_Android Root Config|Android Root Config]]
- [[_COMMUNITY_iOS App Icons|iOS App Icons]]
- [[_COMMUNITY_macOS Unit Tests|macOS Unit Tests]]
- [[_COMMUNITY_Dart Test Entry|Dart Test Entry]]
- [[_COMMUNITY_DPI Support|DPI Support]]
- [[_COMMUNITY_AI Model Modes|AI Model Modes]]

</details>

## God Nodes (most connected - your core abstractions)

<details markdown="1">
<summary>Click to see details</summary>

1. `ScannerScreen` - 27 edges
2. `MyApplication (GTK)` - 14 edges
3. `ScannerController` - 13 edges
4. `FruitAnalyzerService` - 13 edges
5. `WindowClassRegistrar` - 7 edges
6. `Create()` - 7 edges
7. `Destroy()` - 7 edges
8. `AppDelegate (macOS)` - 7 edges
9. `SkanFruitApp` - 6 edges
10. `Win32Window()` - 5 edges

</details>

## Surprising Connections (you probably didn't know these)

<details markdown="1">
<summary>Click to see details</summary>

- `runner (executable)` --conceptually_related_to--> `wWinMain()`  [INFERRED]
  skanfruits/windows/runner/CMakeLists.txt → skanfruits/windows/runner/main.cpp
- `Graphify Instructions` --rationale_for--> `Graphify Tool Hooks`  [EXTRACTED]
  GEMINI.md → .gemini/settings.json
- `App Launcher Icon` --references--> `Android Application ID`  [INFERRED]
  skanfruits/android/app/src/main/res/mipmap-hdpi/ic_launcher.png → skanfruits/android/app/build.gradle.kts
- `Linux Project Configuration` --references--> `Linux Main Entry Point`  [INFERRED]
  skanfruits/linux/CMakeLists.txt → skanfruits/linux/runner/main.cc
- `ScannerScreen` --semantically_similar_to--> `ScannerController`  [INFERRED] [semantically similar]
  skanfruits/lib/presentation/scanner/scanner_screen.dart → skanfruits/lib/presentation/scanner/scanner_controller.dart

</details>

## Hyperedges (group relationships)

<details markdown="1">
<summary>Click to see details</summary>

- **Inference Flow** — scanner_scanner_screen_scannerscreen, scanner_scanner_controller_scannercontroller, services_fruit_analyzer_service_fruitanalyzerservice, models_recognition_result_recognitionresult [INFERRED 0.95]
- **App Configuration** — config_app_config_appconfig, config_app_theme_apptheme, constants_label_mapping_labelmapping [INFERRED 0.85]

</details>

## Communities (42 total, 14 thin omitted)

<details markdown="1">
<summary>Click to see details</summary>

### Community 0 - "Scanner UI & Camera Flow"
Cohesion: 0.08
Nodes (26): package:skanfruits/presentation/scanner/scanner_controller.dart, scannerProvider, ScannerScreen, package:camera/camera.dart, package:flutter/material.dart, package:flutter_riverpod/flutter_riverpod.dart, package:skanfruits/core/config/app_theme.dart, build (+18 more)

### Community 1 - "Windows Native Implementation"
Cohesion: 0.15
Nodes (19): OnCreate(), Create(), Destroy(), EnableFullDpiSupportIfAvailable(), GetClientArea(), GetThisFromHandle(), GetWindowClass(), MessageHandler() (+11 more)

### Community 2 - "AI Config & Label Mapping"
Cohesion: 0.09
Nodes (19): AppConfig, ModelManifest, LabelMapping, dart:typed_data, RecognitionResult, package:flutter/services.dart, package:image/image.dart, package:skanfruits/core/constants/label_mapping.dart (+11 more)

### Community 3 - "Debugging & LLDB Helpers"
Cohesion: 0.12
Nodes (11): Flutter LLDB Helper, handle_new_rx_page(), Intercept NOTIFY_DEBUGGER_ABOUT_RX_PAGES and touch the pages., Flutter Framework, FlutterAppDelegate, FlutterImplicitEngineDelegate, FlutterSceneDelegate, AppDelegate (macOS) (+3 more)

### Community 4 - "Branding & Main Entry"
Cohesion: 0.13
Nodes (13): AppTheme, main(), SkanFruitApp, package:google_fonts/google_fonts.dart, package:skanfruits/presentation/scanner/scanner_screen.dart, package:flutter/material.dart, package:flutter/material.dart, package:flutter_riverpod/flutter_riverpod.dart (+5 more)

### Community 5 - "Linux Platform Runner"
Cohesion: 0.15
Nodes (6): Linux Project Configuration, main(), Linux Main Entry Point, MyApplication (GTK), dart_entrypoint_arguments, parent_instance

### Community 6 - "Scanning Controller & Logic"
Cohesion: 0.17
Nodes (12): package:image_picker/image_picker.dart, package:skanfruits/data/services/fruit_analyzer_service.dart, ScannerController, ScannerState, dart:io, package:camera/camera.dart, package:flutter_riverpod/flutter_riverpod.dart, package:skanfruits/core/config/app_config.dart (+4 more)

### Community 7 - "Windows Runner Entry"
Cohesion: 0.23
Nodes (6): runner (executable), FlutterWindow, wWinMain(), CreateAndAttachConsole(), GetCommandLineArguments(), Utf8FromUtf16()

### Community 8 - "macOS Plugin Registration"
Cohesion: 0.20
Nodes (7): fl_register_plugins(), RegisterGeneratedPlugins(), NSWindow, -registerWithRegistry, MainFlutterWindow Setup, MyApplication Activation, my_application_activate()

### Community 9 - "Web App Manifest"
Cohesion: 0.18
Nodes (10): background_color, description, display, icons, name, orientation, prefer_related_applications, short_name (+2 more)

### Community 10 - "Project Metadata"
Cohesion: 0.25
Nodes (7): configVersion, flutterRoot, flutterVersion, generator, generatorVersion, packages, pubCache

### Community 11 - "Swift Unit Tests"
Cohesion: 0.29
Nodes (3): RunnerTests, RunnerTests, XCTestCase

### Community 12 - "Asset Metadata (LaunchImage)"
Cohesion: 0.40
Nodes (4): images, info, author, version

### Community 13 - "Flutter Widget Tests"
Cohesion: 0.40
Nodes (4): package:flutter/material.dart, package:flutter_test/flutter_test.dart, package:skanfruits/main.dart, main

### Community 14 - "Asset Metadata (AppIcon)"
Cohesion: 0.40
Nodes (4): images, info, author, version

### Community 15 - "Asset Metadata (Generic)"
Cohesion: 0.40
Nodes (4): images, info, author, version

### Community 16 - "Android Native Config"
Cohesion: 0.50
Nodes (4): Android Plugin Management, Android Application ID, App Launcher Icon, MainActivity Class

### Community 17 - "Dart Package Graph"
Cohesion: 0.50
Nodes (3): configVersion, packages, roots

### Community 18 - "Web Icons & Favicon"
Cohesion: 0.50
Nodes (4): Web Icon 512x512, Web Favicon, Web Entry Point, Web App Manifest

### Community 21 - "iOS Launch Screen"
Cohesion: 0.67
Nodes (3): Launch Image Metadata, Launch Image PNG, Launch Screen Customization Guide

</details>

## Knowledge Gaps

<details markdown="1">
<summary>Click to see details</summary>

- **124 isolated node(s):** `BeforeTool`, `main`, `package:flutter/material.dart`, `package:flutter_test/flutter_test.dart`, `package:skanfruits/main.dart` (+119 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **14 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

</details>

## Suggested Questions

<details markdown="1">
<summary>Click to see details</summary>

_Questions this graph is uniquely positioned to answer:_

- **Why does `ScannerScreen` connect `Scanner UI & Camera Flow` to `Branding & Main Entry`, `Scanning Controller & Logic`?**
  _High betweenness centrality (0.058) - this node is a cross-community bridge._
- **Why does `ScannerController` connect `Scanning Controller & Logic` to `Scanner UI & Camera Flow`, `AI Config & Label Mapping`?**
  _High betweenness centrality (0.042) - this node is a cross-community bridge._
- **Why does `FruitAnalyzerService` connect `AI Config & Label Mapping` to `Scanning Controller & Logic`?**
  _High betweenness centrality (0.039) - this node is a cross-community bridge._
- **What connects `BeforeTool`, `main`, `package:flutter/material.dart` to the rest of the system?**
  _128 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Scanner UI & Camera Flow` be split into smaller, more focused modules?**
  _Cohesion score 0.07692307692307693 - nodes in this community are weakly interconnected._
- **Should `AI Config & Label Mapping` be split into smaller, more focused modules?**
  _Cohesion score 0.09090909090909091 - nodes in this community are weakly interconnected._
- **Should `Debugging & LLDB Helpers` be split into smaller, more focused modules?**
  _Cohesion score 0.11764705882352941 - nodes in this community are weakly interconnected._
</details>

