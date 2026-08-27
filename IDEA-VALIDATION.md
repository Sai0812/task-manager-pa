# TaskPilot - Personal Task Manager for Corporate Managers

## Idea Validation Report

### Problem Statement
Corporate managers juggle 20-50 micro-tasks daily. Context-switching between meetings, emails, and team requests causes tasks to slip through cracks. Existing solutions (Notepad, heavy task managers like Jira/Asana) are either too dumb (no reminders) or too complex (too many clicks to add a simple task).

### Target Audience
- **Primary:** Managers with 5+ direct reports handling daily task overload
- **Secondary:** Any corporate employee who needs a quick-capture tool with reminders

### Why This Works

| Strength | Why It Matters |
|----------|---------------|
| Floating toggle widget | Zero friction - always accessible without switching apps |
| One-click task capture | Managers can add tasks mid-meeting in 3 seconds |
| Browser notifications + sound | Can't miss reminders unlike silent notepad |
| Snooze (5m/15m/1hr/4hr) | "I see it but can't act now" - real manager workflow |
| Priority color-coding | Instant visual triage at a glance |
| Persistent localStorage | Nothing lost on browser refresh |
| Keyboard shortcut (Ctrl+Shift+T) | Power users never leave the keyboard |

### What Was Removed (Scope Control)

| Removed Feature | Reason |
|----------------|--------|
| Team collaboration | This is PERSONAL, not Jira. Keep it focused. |
| Calendar sync | Adds API complexity, low ROI for v1 |
| AI suggestions | Overkill for quick-capture |
| File attachments | Scope creep - tasks should be actionable text |
| Recurring tasks | Adds complexity. v2 feature if validated. |
| Cloud sync | localStorage is sufficient for single-device use |

### What Was Added (Improvements)

| Added Feature | Why |
|--------------|-----|
| Priority levels (U/H/M/L) | Managers need to triage, not just list |
| 3 categories (Task/Follow-up/Meeting) | Captures 90% of manager task types |
| Snooze with multiple durations | Real workflow: "remind me again in 15min" |
| Filter chips (All/Overdue/Today/Done) | Quick status view without scrolling |
| Search | When you have 30+ tasks, you need this |
| Overdue highlighting | Red left border + count badge for urgency |
| Desktop notifications | Browser-level alerts that work even when tab is background |
| Double-click to edit | Quick inline editing |
| Badge count on toggle button | See pending count without opening panel |
| Escape key to close | Standard UX pattern |

### Competitive Advantage
- **vs Notepad:** Has reminders, priority, search, snooze
- **vs Jira/Asana:** 10x faster to add a task, no overhead
- **vs Sticky Notes:** Reminders, priority system, searchable
- **vs Phone reminders:** Always on work screen, category system

### Key Metrics to Track (if deployed)
1. Tasks added per day per user
2. Snooze frequency (indicates reminder timing accuracy)
3. Time from open-to-add (should be < 5 seconds)
4. Overdue task ratio (should decrease over time)

### Tech Stack
- **Pure HTML/CSS/JS** - zero dependencies
- **localStorage** for persistence
- **Browser Notification API** for reminders
- **Single file** - easy to deploy anywhere

### Future v2 Features (if validated)
- Recurring tasks
- Export to CSV
- Dark/Light theme toggle
- Drag-and-drop reordering
- Multiple task lists/projects
- Browser extension version
