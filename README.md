# Progress Cloud

A **visual-first progress tracking app** that connects goals, tasks, and personal lists (movies, restaurants, etc.) into an interactive **node-and-connection “cloud” view**. Built with **Flutter** for cross-platform mobile support.

---

## ✨ Concept

Most progress trackers treat goals as flat lists. **Progress Cloud** treats them as **connected systems**.

* A yearly goal can connect to monthly or weekly goals
* Tasks don’t need strict parent/child relationships
* Lists (movies, restaurants, books, etc.) can link directly to goals
* Everything is visualized as nodes with vector connections

Example:

> “Watch 1 movie per month” → connected to a **Movies List** → individual movie items

---

## 🧠 Core Ideas

* **Non-hierarchical goal relationships**
* **Visual graph-based progress tracking**
* **Flexible timeframes** (daily, weekly, monthly, yearly)
* **Lists as actionable progress inputs**
* **One-off tasks OR chained goals**

---

## 📱 Platform & Tech Stack

### Frontend

* **Flutter**
* Custom rendering using:

  * `CustomPainter`
  * Gesture detection
  * Zoom / pan canvas
* State management (TBD):

  * Riverpod / Bloc / Provider

### Backend (Initial Options)

* Local-first (SQLite / Drift)
* Optional cloud sync later:

  * Firebase
  * Supabase
  * Custom REST API

---

## 🧩 Core Features

### 1. Tasks & Goals

* One-off tasks
* Chained goals (Year → Month → Week → Day)
* Goals don’t require strict correlation
  (e.g. yearly = 365 days, weekly = 5 days)

### 2. Lists

* Custom lists:

  * Movies to watch
  * Restaurants to try
  * Books to read
  * Anything user-defined
* List items can:

  * Stand alone
  * Be linked to tasks or goals

### 3. Connections (The “Cloud”)

* Nodes represent:

  * Tasks
  * Goals
  * Lists
  * List items
* Lines represent relationships
* Interactive graph:

  * Tap to inspect
  * Drag to reposition
  * Zoom / pan canvas

---

## 🗂️ High-Level Data Model

### Entities

**Task**

* id
* title
* description
* timeframe (daily / weekly / monthly / yearly)
* progress tracking rules

**Goal**

* id
* name
* optional timeframe
* optional completion logic

**List**

* id
* name
* type (movies, restaurants, custom)

**ListItem**

* id
* listId
* title
* optional metadata (rating, location, etc.)

**Connection**

* fromNodeId
* toNodeId
* relationshipType

---

## 🧭 User Flows

### Example Flow

1. User creates a **Movies list**
2. Adds movies they want to watch
3. Creates a task: *“Watch 1 movie per month”*
4. Links the task to the Movies list
5. Marks movies as watched → task progress updates
6. Views everything in the cloud visualization

---

## 🖼️ Visualization Approach

* Infinite canvas
* Force-directed or manual node layout
* Curved or straight vector lines
* Color-coded node types
* Subtle animations for interactions

---

## 🚧 Project Status

**Early architecture & concept phase**

Planned next steps:

* Flutter project scaffolding
* Core data models
* Basic list + task CRUD
* Initial static cloud visualization
* Interactive node selection

---

## 🔮 Future Ideas

* Progress analytics
* Smart suggestions (e.g. “You’re close to completing this goal”)
* Templates for common goals
* AI-assisted goal breakdown
* Sharing / collaboration
* Cloud sync & multi-device support

---

## 🤝 Contribution

This project is currently a **learning + exploration project**.
Contributions, ideas, and feedback are welcome once the core structure is in place.

---

## 📄 License

TBD
