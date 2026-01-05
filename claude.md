# Progress Cloud - Claude Context

This document provides context for AI assistants working on the Progress Cloud project.

## Project Overview

Progress Cloud is a visual-first progress tracking application built with Flutter. It transforms traditional linear goal tracking into an interactive graph-based system where goals, tasks, and lists are connected as nodes in a "cloud" visualization.

## Core Concept

Unlike traditional progress trackers that use flat lists, Progress Cloud treats goals and tasks as **connected systems**:

- Goals can connect to other goals without strict hierarchies
- Tasks can link to multiple goals
- Lists (movies, restaurants, books) can drive progress
- Everything is visualized as an interactive node graph

Example workflow: "Watch 1 movie per month" (task) → "Movies List" → individual movie items

## Tech Stack

### Frontend
- **Flutter** for cross-platform mobile development
- Custom rendering with `CustomPainter`
- Gesture detection for drag, zoom, pan interactions
- State management: TBD (Riverpod/Bloc/Provider - Riverpod preferred)

### Backend
- **Local-first** approach using SQLite/Drift
- Optional cloud sync planned (Firebase/Supabase)

## Architecture

The project follows a layered architecture:

```
Flutter UI Layer
    ↓
State Management Layer (Riverpod/Bloc)
    ↓
Domain Layer (Models, Business Rules, Progress Logic)
    ↓
Persistence Layer (SQLite/Drift, Repositories)
    ↓
Optional Cloud Sync (Future)
```

## Core Domain Models

### Node System
Everything in the cloud visualization is a **node**:

- **Task**: Actionable units with timeframes (daily/weekly/monthly/yearly)
- **Goal**: Higher-level intent without strict hierarchy
- **List**: Content collections (movies, restaurants, etc.)
- **ListItem**: Individual items within lists

### Connections
Relationships between nodes:
- fromNodeId
- toNodeId
- relationshipType
- direction (optional)

### Key Data Entities

**Task**
- timeframe (daily/weekly/monthly/yearly)
- completion rules (count-based, boolean, streak)
- progress state
- can connect to multiple goals and list items

**Goal**
- no enforced hierarchy
- can overlap with other goals
- can share tasks

**List & ListItem**
- lists act as content collections
- items can affect progress when completed
- items can link to tasks/goals

## Design Principles

1. **Visual-first**: The graph view is primary, not supplementary
2. **Flexible relationships**: Avoid rigid parent/child hierarchies
3. **Non-hierarchical goals**: Goals can connect freely
4. **Local-first**: Full offline functionality
5. **Mobile-first**: Designed for cross-platform mobile use
6. **Extensible**: Easy to add new node and relationship types

## Development Status

**Current Phase**: Early architecture & concept

The project is in the planning/design phase. No Flutter code has been written yet.

### Planned Next Steps
1. Flutter project scaffolding
2. Core data models implementation
3. Basic list + task CRUD operations
4. Initial static cloud visualization
5. Interactive node selection

## Key Features to Implement

### 1. Tasks & Goals
- One-off tasks
- Chained goals (Year → Month → Week → Day)
- Goals with flexible correlation (e.g., yearly ≠ 365 days exactly)

### 2. Lists
- Custom user-defined lists
- List items can stand alone or link to tasks/goals
- Common list types: movies, restaurants, books

### 3. Cloud Visualization
- Infinite canvas with zoom/pan
- Tap to inspect, drag to reposition
- Force-directed or manual node layout
- Color-coded node types
- Vector line connections

## Progress Calculation

Progress is **contextual**, not global:
- Calculated based on node type and timeframe
- A task counts connected list item completions
- Weekly goals may require 5 completions vs 365 for yearly
- Logic lives in domain layer, not UI

## Visualization Layer

### Cloud Canvas
- Infinite 2D canvas
- Zoom & pan controls
- Freeform node placement

### Rendering
- Flutter `CustomPainter` for efficient drawing
- Separate painters for nodes, connections, and overlays

### Interactions
- Tap: inspect node
- Long-press: edit
- Drag: reposition
- Multi-select (future enhancement)

## Future Enhancements

- Progress analytics
- Smart suggestions ("You're close to completing this goal")
- Templates for common goals
- AI-assisted goal breakdown
- Sharing/collaboration
- Cloud sync & multi-device support

## Non-Goals (For Now)

- Real-time collaboration
- Public sharing
- Web-first UX

## Working with This Codebase

### Before Writing Code
1. Read README.md and ARCHITECTURE.md
2. Understand the node-based mental model
3. Consider how changes affect the graph visualization
4. Follow Flutter best practices

### Key Considerations
- Maintain separation between domain logic and UI
- Keep progress calculation in domain layer
- Design for offline-first functionality
- Think in terms of nodes and connections
- Avoid rigid hierarchies

### Code Style
- Follow Flutter/Dart conventions
- Prefer composition over inheritance
- Keep business logic out of widgets
- Use repository pattern for data access

## Testing Approach
- Unit tests for domain logic (especially progress calculation)
- Widget tests for UI components
- Integration tests for user flows
- Visual tests for graph rendering

## File Organization (Planned)

```
lib/
  ├── domain/
  │   ├── models/
  │   ├── repositories/
  │   └── services/
  ├── ui/
  │   ├── screens/
  │   ├── widgets/
  │   └── painters/
  ├── state/
  └── persistence/
```

## Contributing Notes

This is currently a learning/exploration project. The architecture is still being finalized.

## Questions to Consider

When adding features, ask:
1. Does this fit the node-based model?
2. Is this a new node type or relationship type?
3. How does this affect the visualization?
4. Can this work offline?
5. Is the domain logic separated from UI?

## Useful Context

- The "cloud" metaphor is central to UX
- Flexibility > Rigid structure
- Visual understanding > Data tables
- Progress is contextual, not absolute
- Lists are first-class citizens, not afterthoughts
