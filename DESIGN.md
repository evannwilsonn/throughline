---
name: Throughline
description: Executive KPIs from 100,000 real marketplace orders, printed as shipping labels in a parcel depot.
colors:
  stamp-teal: "#0e6f6a"
  stamp-wash: "rgba(14,111,106,.12)"
  kraft-board: "#d5bf98"
  kraft-board-deep: "#c8af84"
  kraft-ink: "#3b2f1f"
  kraft-ink-soft: "#5c4a33"
  charcoal-kraft: "#24211c"
  charcoal-kraft-raised: "#2e2a23"
  charcoal-ink: "#e9dfcc"
  charcoal-ink-soft: "#bfb29b"
  thermal-white: "#fcfbf7"
  thermal-white-dark: "#f4f2ec"
  print-black: "#141412"
  print-grey: "#4a4944"
  print-faint: "#6c6a63"
  hairline: "#d9d6cc"
typography:
  display:
    fontFamily: "Bricolage Grotesque, system-ui, sans-serif"
    fontSize: "clamp(30px, 4.6vw, 50px)"
    fontWeight: 800
    lineHeight: 1
    letterSpacing: "-0.035em"
    fontVariation: "\"opsz\" 96"
  headline:
    fontFamily: "Bricolage Grotesque, system-ui, sans-serif"
    fontSize: "clamp(22px, 2.8vw, 32px)"
    fontWeight: 700
    lineHeight: 1.15
    letterSpacing: "-0.02em"
  title:
    fontFamily: "Bricolage Grotesque, system-ui, sans-serif"
    fontSize: "26px"
    fontWeight: 800
    lineHeight: 1.15
    letterSpacing: "-0.025em"
  body:
    fontFamily: "Bricolage Grotesque, system-ui, sans-serif"
    fontSize: "15.5px"
    fontWeight: 400
    lineHeight: 1.55
  figure:
    fontFamily: "Martian Mono, ui-monospace, Menlo, monospace"
    fontSize: "30px"
    fontWeight: 600
    lineHeight: 1.05
    letterSpacing: "-0.04em"
  label:
    fontFamily: "Martian Mono, ui-monospace, Menlo, monospace"
    fontSize: "12px"
    fontWeight: 500
  stamp:
    fontFamily: "Bricolage Grotesque, system-ui, sans-serif"
    fontSize: "13px"
    fontWeight: 800
    lineHeight: 1
    letterSpacing: "0.06em"
rounded:
  none: "0px"
  die-cut: "4px"
spacing:
  xs: "8px"
  sm: "12px"
  md: "16px"
  lg: "22px"
  section: "38px"
components:
  kpi-label:
    backgroundColor: "{colors.thermal-white}"
    textColor: "{colors.print-black}"
    rounded: "{rounded.die-cut}"
    typography: "{typography.figure}"
  packing-slip:
    backgroundColor: "{colors.thermal-white}"
    textColor: "{colors.print-black}"
    rounded: "{rounded.none}"
    padding: "18px 22px"
    typography: "{typography.headline}"
  stamp-off-track:
    backgroundColor: "{colors.stamp-teal}"
    textColor: "{colors.thermal-white}"
    typography: "{typography.stamp}"
    padding: "6px 8px 5px"
  stamp-on-track:
    textColor: "{colors.stamp-teal}"
    typography: "{typography.stamp}"
    padding: "6px 8px 5px"
  ship-date-picker:
    backgroundColor: "{colors.thermal-white}"
    textColor: "{colors.print-black}"
    rounded: "{rounded.none}"
    padding: "7px 34px 7px 10px"
  data-card:
    backgroundColor: "{colors.thermal-white}"
    textColor: "{colors.print-black}"
    rounded: "{rounded.none}"
    padding: "14px 16px 16px"
---

# Design System: Throughline

## Overview

**Creative North Star: "The Parcel Depot"**

Every reading surface is a piece of paper printed by a shipping counter and laid on corrugated board: thermal labels for KPIs, a packing slip for the month's brief, a tracking sheet for a KPI's history, a customs declaration for the data notes. The board is the room; paper is where the data lives. One ink, a customs-stamp teal, carries verdicts and selection, and nothing else competes with it.

Density is a working depot's: labels sit edge to edge in a wall, print rules box every field, figures run in a monospace thermal face. Ornament is limited to things a depot actually has: torn slip edges, die-cut label corners, dashed tear lines, rubber stamps. Labels stay white in both themes; only the board turns from kraft to warm charcoal.

**Key Characteristics:**
- Kraft board ground (warm charcoal in dark); white thermal paper for every data surface, in both themes.
- One accent ink, stamp teal, for verdicts, selection, plan lines, late-delivery marks and cohort intensity.
- 2px black print rules divide label fields; 1px dashed hairlines divide rows and legs.
- Bricolage Grotesque for words, Martian Mono for figures and label print.
- Verdict always spoken by a stamp's word and its style, never by colour alone.

## Colors

A two-material palette: brown board and white paper, printed in black, stamped in one teal.

### Primary
- **Customs Stamp Teal** (`stamp-teal`): verdict stamps, the selected label's 3px ring, the tracking panel's ring, the dashed plan line, late-delivery route dots and one-star bars, cohort cells (opacity scaled .12 to 1). The same value in both themes because it always prints on white paper. `stamp-wash` is its 12% tint, used only as a highlighter behind bold figures in the journey callout.

### Neutral
- **Kraft Board** / **Charcoal Kraft** (`kraft-board`, `charcoal-kraft`): page ground in light and dark. `-deep` / `-raised` variants are the board's second tone.
- **Kraft Ink** / **Charcoal Ink** and their soft variants: headings, deks, header metadata, dashed tear lines and footer that sit directly on the board.
- **Thermal White** (`thermal-white`, dimmed to `thermal-white-dark` in dark mode): every paper surface.
- **Print Black** (`print-black`): label text, print rules, barcode bars, trend line, share-of-orders bars. Identical in both themes.
- **Print Grey** / **Print Faint** (`print-grey`, `print-faint`): secondary print, row keys, axis, table heads, the no-target stamp.
- **Hairline** (`hairline`): dashed row and leg dividers, empty bar tracks, chart gridlines, empty cohort cells.

### Named Rules
**The Paper Stays White Rule.** Data surfaces never theme. Dark mode changes the board and the board's ink only; label, print and stamp tokens are fixed.

**The One Ink Rule.** Stamp teal is the only chromatic colour. No second accent; status variety comes from stamp style, not hue.

## Typography

**Display Font:** Bricolage Grotesque (with system-ui)
**Figure/Label Font:** Martian Mono (with ui-monospace, Menlo)

**Character:** A sturdy, slightly quirky grotesque speaks in sentences; a wide thermal-printer mono prints the numbers.

### Hierarchy
- **Display** (800, clamp 30 to 50px, 1, optical size 96): the wordmark only.
- **Headline** (700, clamp 22 to 32px, 1.15, max 30ch): the packing slip's data-written sentence.
- **Title** (800, 26px): section heads on the board. Paper headings step down to 700 at 20px (tracking), 17px (cards), 15px (label names).
- **Body** (400, 15.5px, 1.55, 64 to 80ch): deks, slip body, notes.
- **Figure** (Mono 600, 30px, -0.04em; 21px at ≤600px; 26px for journey review scores): KPI values and headline figures.
- **Label** (Mono 400 to 600, 10.5 to 12px): label rows, table heads, axis, leg names, slip and page footer lines, the picker caption.
- **Stamp** (800, 13px, +0.06em, uppercase): stamp words only.

### Named Rules
**The Print Belongs To Mono Rule.** Martian Mono sets figures and the short machine print around them (row keys, axis, table heads, footer lines); headings, sentences and stamp words are Bricolage. Never set prose in mono.

## Layout

Single column, max 1320px, side padding clamp(16px, 3vw, 36px). Sections are board headings (38px above) with a dek, then paper. The label wall is an auto-fill grid, min 262px, 16px gap, labels at least 206px tall. Tracking opens full-width directly under the wall. The journey runs six equal legs under a dashed route line. The lower row is three equal cards, collapsing to one column at ≤1000px; the customs declaration flows in two columns (min 380px).

At ≤900px the journey becomes two legs per row and the route line hides. At ≤600px the wall stays two-up (10px gap): values drop to 21px, stamps leave the value cell and sit beneath the figure at -3deg, and row keys shorten to `plan / yr / mo`.

## Elevation & Depth

Flat. Paper lies on board; depth is the contrast of paper against board, the slip's -0.4deg tilt and torn top edge, and outlines. No ambient shadows. The single box-shadow in the system is the Watch stamp's second ring (a 2px paper gap then a 2px teal ring), which is ink, not elevation.

### Named Rules
**The Paper On Board Rule.** Separate surfaces by material, rules and outlines, never by drop shadow.

## Shapes

Square paper everywhere except KPI labels, which carry 4px die-cut corners. Boxes are drawn by 2px print-black rules; secondary divisions are 1px dashed hairlines; board-level divisions (header, footer) are 2px dashed tear lines in soft board ink. The packing slip's top edge is a 10px zigzag tear. Stamps rotate -7deg (-3deg on phones).

## Components

### KPI Thermal Label
White paper, 2px print-black border, 4px die-cut corners, stacked fields each closed by a 2px rule: name (Bricolage 700, 15px); value cell (mono figure) holding the stamp at right; plan / vs last year / vs last month rows (mono 12px, keys grey, values black and right-aligned); barcode trend and a human-readable month range (mono 10.5px, +0.2em). The barcode is the last 12 months, zero-based, thin bars with the ship month drawn solid and wide. Hover lifts 1px; selected gets a 3px teal outline at 3px offset. The whole label is a button.

### Rubber Stamp
Uppercase Bricolage 800 in teal, -7deg, multiply blend. Four styles, each with its own word: **Off track** filled teal with white text; **Watch** double ring; **On track** single 2px ring; **no target** 1px dashed grey, weight 600.

### Packing Slip
White, tilted -0.4deg, torn top edge, max 880px. A headline sentence written from the data, a grey body line, and a mono footer line (`Packing slip n of N · Month`) above a dashed hairline.

### Ship-Date Picker
A white select with a 2px print-black border, square, mono 600 15px, CSS chevron; captioned by a mono uppercase label. Focus: the global 3px teal ring.

### Tracking Panel
White sheet with a 3px teal outline. Black value line (2px) with small dots and a ringed current month; teal dashed plan line labelled `plan`; two hairline gridlines labelled in mono.

### Journey
White sheet. A dashed black route with six dots (white on time or early, teal once late); each leg shows a mono review figure, a teal one-star bar and a black share-of-orders bar on hairline tracks. A callout highlights key figures with the teal wash.

### Data Cards and Tables
Square white cards. Table heads mono uppercase grey over a 2px black rule; rows split by dashed hairlines; figures mono, names Bricolage; inline black magnitude bars before GMV. Cohort grid: teal cells at scaled opacity, dashed empty cells for months not yet reached.

### Customs Declaration
White sheet, two columns, uppercase Bricolage 800 heading over a 2px rule; each note leads with a bold black phrase.

## Do's and Don'ts

### Do:
- **Do** put every number on white thermal paper (`thermal-white`) in print black, in both themes.
- **Do** carry a verdict with both a stamp word and a stamp style (filled, double ring, single ring, dashed).
- **Do** box label fields with 2px print-black rules and keep the 4px die-cut corner for labels only.
- **Do** keep barcodes and bars zero-based so small changes stay small.
- **Do** set figures in Martian Mono and words in Bricolage Grotesque.

### Don't:
- **Don't** add a second accent hue; blue, orange, green, plum, lime, rust, taxi yellow and hot pink belong to sibling projects.
- **Don't** theme the paper or the stamp ink in dark mode.
- **Don't** use drop shadows for depth; paper on board is the depth.
- **Don't** lay the page out as a newspaper broadsheet or a generic KPI-tile grid.
