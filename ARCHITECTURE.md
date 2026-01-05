# Progress Cloud – Architecture

This document describes the high-level architecture for **Progress Cloud**, a Flutter-based progress tracking application centered around visualizing goals, tasks, and lists as a connected graph.

---

## 1. Architectural Goals

* **Visual-first**: The graph (cloud) view is a first-class feature, not an add-on.
* **Flexible relationships**: Avoid rigid parent/child hierarchies.
* **Local-first**: App should work fully offline.
* **Mobile-first, cross-platform**: Designed in Flutter for future iOS, Android, and web support.
* **Extensible**: Easy to add new node types and relationship types.

---

## 2. High-Level System Overview

```
┌─────────────────────────┐
│        Flutter UI        │
│  - Screens & Navigation  │
│  - Cloud Visualization   │
│  - Forms & Editors       │
└─────────────┬───────────┘
              │
┌─────────────▼───────────┐
│   State Management       │
│  (Riverpod / Bloc TBD)   │
└─────────────┬───────────┘
              │
┌─────────────▼───────────┐
│   Domain Layer           │
│  - Models                │
│  - Business Rules        │
│  - Progress Logic        │
└─────────────┬───────────┘
              │
┌─────────────▼───────────┐
│   Persistence Layer      │
│  - SQLite / Drift        │
│  - Repositories          │
└─────────────┬───────────┘
              │
┌─────────────▼───────────┐
│ Optional Cloud Sync      │
│ (Firebase / Supabase)    │
└─────────────────────────┘
```

---

## 3. Core Domain Concepts

### 3.1 Node System

All visual elements in the cloud are represented as **nodes**.

**Node (base concept)**

* id
* nodeType
* title
* metadata
* position (x, y)

**Node Types**

* Task
* Goal
* List
* ListItem

This allows the visualization layer to remain generic.

---

### 3.2 Connections

Connections define relationships between nodes.

**Connection**

* id
* fromNodeId
* toNodeId
* relationshipType
* direction (optional)

Examples:

* Goal → Task
* Task → List
* Task → ListItem
* Goal → Goal

---

## 4. Tasks & Goals Architecture

### 4.1 Tasks

Tasks represent actionable units of work.

**Key Properties**

* timeframe (daily / weekly / monthly / yearly)
* completion rules (count-based, boolean, streak)
* progress state
* metricType (distance / time / count / custom / none)
* metricUnit (miles / km / minutes / hours / reps / pages / etc.)
* metricTarget (optional numeric goal)

**Task Metrics**

Tasks can track quantitative data:

* **Boolean tasks**: Simple completion (e.g. "meditate daily")
* **Count tasks**: Track occurrences (e.g. "3 workouts per week")
* **Metric tasks**: Track measurable values (e.g. "run 5 miles daily")

Tasks may:

* Exist independently
* Be connected to multiple goals
* Be linked to list items
* Aggregate metrics across timeframes

---

### 4.2 Goals

Goals represent higher-level intent.

**Design Principles**

* Goals do NOT enforce hierarchy
* Goals can overlap
* Goals can share tasks
* Goals can have metric-based targets

**Goal Properties**

* id
* name
* timeframe (optional)
* completion logic (optional)
* metricType (optional - inherits from connected tasks)
* metricTarget (numeric goal, e.g. "500 miles this year")

Examples:

* "Be healthier" (qualitative)
* "Watch more movies" (count-based)
* "Travel more" (qualitative)
* "Run 500 miles this year" (metric-based)

---

## 5. Lists Architecture

Lists act as **content collections** that can drive progress.

### 5.1 Lists

**Examples**

* Movies to Watch
* Restaurants to Visit
* Books to Read

**List Properties**

* id
* name
* type

---

### 5.2 List Items

List items represent actionable or consumable entries.

**Examples**

* A single movie
* A restaurant
* A book

List items may:

* Stand alone
* Be linked to tasks or goals
* Affect progress when completed

---

## 6. Progress Calculation

Progress is **contextual**, not global.

### 6.1 Boolean & Count Progress

Examples:

* A task may count progress by number of connected list items completed
* A weekly goal may require 5 completions, while a yearly goal requires 365

### 6.2 Metric-Based Progress

**Metric Entry**

* id
* taskId
* timestamp
* metricValue (numeric)
* metricUnit
* notes (optional)

**Aggregation Rules**

Metrics aggregate hierarchically:

* **Daily task**: Individual metric entries
* **Weekly view**: SUM(daily entries in week)
* **Monthly view**: SUM(daily entries in month)
* **Yearly view**: SUM(daily entries in year)

**Progress Calculation Examples**

1. Task: "Run daily" (3 miles target)
   * Daily: 3.2/3 miles (107%)
   * Weekly: 18.5/21 miles (88%)
   * Monthly: 92/90 miles (102%)

2. Task: "Read 30 min/day"
   * Daily: 45/30 minutes (150%)
   * Weekly: 210/210 minutes (100%)
   * Monthly: 890/900 minutes (99%)

**Metric Aggregation Types**

* **SUM**: Total distance, time, count (default)
* **AVERAGE**: Average pace, average duration
* **MAX**: Personal records
* **MIN**: Minimum thresholds

Progress logic lives in the **domain layer**, not the UI.

---

## 7. Visualization Layer

### 7.1 Cloud Canvas

* Infinite 2D canvas
* Zoom & pan
* Freeform node placement

### 7.2 Rendering

* Flutter `CustomPainter`
* Separate painters for:

  * Nodes
  * Connections
  * Interaction overlays

### 7.3 Interaction

* Tap: inspect node
* Long-press: edit
* Drag: reposition
* Multi-select (future)

---

## 8. State Management

Responsibilities:

* Maintain graph state
* Track UI selections
* Coordinate persistence

Candidates:

* Riverpod (preferred)
* Bloc
* Provider

---

## 9. Persistence Strategy

### 9.1 Local Storage

* SQLite via Drift
* Repository pattern

### 9.2 Data Stored

* Nodes
* Connections
* Node positions
* Progress history
* **Metric entries** (timestamp, value, unit)
* Metric aggregation cache (optional optimization)

---

## 10. Optional Cloud Sync (Future)

* User accounts
* Multi-device sync
* Conflict resolution

Potential providers:

* Firebase
* Supabase

---

## 11. Extensibility

Planned extension points:

* New node types (Habits, Events)
* New relationship types
* AI-assisted goal generation
* Analytics modules
* **New metric types** (weight, calories, mood, etc.)
* **New aggregation functions** (average, max, min, custom)
* **Metric visualization** (charts, graphs, trends)

---

## 12. Non-Goals (For Now)

* Real-time collaboration
* Public sharing
* Web-first UX

---

## 13. Summary

Progress Cloud is architected around a **graph-first mental model**:

* Everything is a node
* Relationships are explicit
* Progress is contextual
* Visualization drives understanding

This architecture prioritizes flexibility, clarity, and long-term extensibility.
