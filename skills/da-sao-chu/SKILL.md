---
name: da-sao-chu
description: "Audit and clean up code, modules, files, documents, or mechanisms. Use removal impact, usage evidence, source-of-truth and projection roles, and maintenance mechanisms to recommend deletion, archiving, merging, repair, or retention. Pause the affected action when evidence or deletion authority is missing. Use when the user requests cleanup, reduction, or an asset audit."
---

## Preparation

For a complex target, first read [Responsibility Atom](references/responsibility-atom.md) and produce a complete, non-overlapping decomposition into responsibility atoms that can be acted on and verified independently. Assess each established atom using the activity diagram below. Record unresolved boundaries as `HOLD`.

## Activity diagram

```plantuml
@startuml
start
:Define the scope and inventory responsibilities, consumers, triggers,\ndependencies, outputs, and retention obligations read-only;
if (Complex target?) then (yes)
  :Establish independently actionable and verifiable responsibility atoms;
  :Record any unresolved boundaries as HOLD;
else (no)
  :Assess the target as one unit;
endif
while (Another established unit?) is (yes)
  if (Enough evidence to judge removal impact?) then (yes)
    if (Would removal worsen user or agent behavior?) then (yes)
      if (Compatible existing replacement?) then (yes)
        :Recommend merging into the authoritative home;
      elseif (Reliable maintenance mechanism?) then (yes)
        :Recommend keeping;
      else (no)
        :Recommend repair or replacement;
      endif
    elseif (Retention obligation?) then (yes)
      :Recommend archiving;
    else (no)
      :Recommend deletion;
    endif
  else (no)
    :Record HOLD for the affected unit and identify missing evidence;
  endif
endwhile (no)
:Report the disposition plan;

while (Another proposed change within the requested scope?) is (yes)
  if (Specific authorization and execution checks satisfied?) then (yes)
    :Perform the authorized change;
    :Verify the impact on affected consumers and report the result;
  else (no)
    :Leave the change pending and record the unmet conditions;
  endif
endwhile (no)
stop
@enduml
```

## Execution checks

Missing usage evidence does not prove that an item is unused. If a condition needed for a disposition is unresolved, record `HOLD` for the affected unit and continue assessing independent units.

For a review-only request, stop after reporting the plan. Before changing anything, confirm that the user's authorization covers the specific action and target, and verify the recovery method, retention obligations, and impact boundary.

An equivalent replacement must preserve compatibility for consumers, triggers, input contracts, and output semantics. For an authorized merge, migrate any unique value still in use and verify the replacement path before removing redundant material covered by the authorization.
