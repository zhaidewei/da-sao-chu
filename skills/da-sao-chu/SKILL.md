---
name: da-sao-chu
description: "Audit and clean up code, modules, files, documents, or mechanisms. Use removal impact, usage evidence, source-of-truth and projection roles, and maintenance mechanisms to recommend deletion, archiving, merging, repair, or retention. Pause the affected action when evidence or deletion authority is missing. Use when the user requests cleanup, reduction, or an asset audit."
---

## Preparation

For a complex target, first read [Responsibility Atom](references/responsibility-atom.md) and produce a complete, non-overlapping decomposition into responsibility atoms that can be acted on and verified independently. Pass each established atom through the decision tree below. A `HOLD` outcome has not yet established an actionable unit.

## Decision tree

```mermaid
flowchart TD
    A["Define the target and inventory it read-only"] --> B{"Enough evidence?"}
    B -- "No" --> P["Pause: obtain missing evidence or authorization"]
    B -- "Yes" --> C{"Would removal worsen user or agent behavior?"}
    C -- "Unknown" --> P
    C -- "No" --> D{"Retention obligations?"}
    D -- "Yes" --> R["Archive"]
    D -- "No" --> G{"Authorized and recoverable?"}
    C -- "Yes" --> E{"Equivalent existing replacement?"}
    E -- "Yes" --> M["Merge into the authoritative home and verify the replacement path"]
    M --> G
    E -- "No" --> F{"Reliable maintenance mechanism?"}
    F -- "Yes" --> K["Keep"]
    F -- "No" --> N["Repair or replace"]
    G -- "No" --> P
    G -- "Yes" --> X["Delete and verify the impact boundary"]
```

## Safety

Missing usage evidence does not prove that something is unused. Pause when evidence is insufficient. This skill produces a disposition plan; deletion, overwriting, or merging requires user authorization for the specific target, followed by impact verification. Before executing a change, confirm the recovery method, retention obligations, and impact boundary. The tree's archive and merge nodes are recommendations until these conditions are met.

An equivalent replacement must preserve compatibility for consumers, triggers, input contracts, and output semantics. Before merging, migrate any unique value that is still in use.
