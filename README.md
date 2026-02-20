# Riverpod V3 — ProviderScope + LayoutBuilder Rebuild Issue

This repository demonstrates an unintended rebuild behavior in **Riverpod V3** (`flutter_riverpod: ^3.1.0`).

## The Problem

When a `ProviderScope` is placed as a child of a `LayoutBuilder`, **all elements inside the `LayoutBuilder` are rebuilt** whenever the parent widget tree changes — even if there is no interaction with those elements.

For example, tapping the FloatingActionButton (which performs no state change at all) triggers a ripple animation that causes the parent tree to rebuild. This in turn causes every `ProviderScope` nested under a `LayoutBuilder` to be fully rebuilt, leading to unnecessary work.

## How to Reproduce

1. Run the app.
2. Tap the FloatingActionButton — it intentionally does **nothing** (no counter increment, no state change).
3. Observe that the green containers inside the `ListView` (each wrapped in `LayoutBuilder` > `ProviderScope`) are rebuilt despite having no reason to.

## Code Structure

The key widget hierarchy in `lib/main.dart`:

```
ListView.builder
  └── Container (blue)
        └── LayoutBuilder
              └── ProviderScope   ← triggers unnecessary rebuilds
                    └── Container (green)
```

The `FloatingActionButton.onPressed` callback is intentionally empty — only the ripple animation's repaint is enough to trigger the issue.

## Screen Recording

<video src="documentation/ScreenRecording.mp4" controls width="80%"></video>

## Expected Behavior

Widgets inside the `LayoutBuilder` / `ProviderScope` should **not** rebuild when the parent tree changes if their constraints and dependencies have not changed.

## Actual Behavior

Every `ProviderScope` under a `LayoutBuilder` is rebuilt on any parent tree change, causing unnecessary rebuilds across the entire list.
