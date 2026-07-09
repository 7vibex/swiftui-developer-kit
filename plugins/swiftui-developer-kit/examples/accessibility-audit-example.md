# Accessibility Audit

## Executive Summary

StudyOS is usable with standard text sizes but has VoiceOver and Dynamic Type gaps in Canvas, Flashcards, and AI Tutor.

## Critical Accessibility Issues

- Canvas tool buttons are icon-only without labels.
- Flashcard answer state is communicated by color only.

## VoiceOver Issues

- AI Tutor suggestions read as separate fragments instead of grouped actions.
- Planner task rows do not announce due status.

## Dynamic Type Issues

- Notebook toolbar clips at accessibility sizes.
- Flashcard controls overlap when text is extra large.

## Contrast and Readability

- Secondary text on translucent cards fails in bright wallpapers.

## Motion/Transparency Concerns

- Animated card flips need a Reduce Motion alternative.
- Blurred Home cards need a Reduce Transparency fallback.

## Recommended Fixes

Add labels and traits, replace color-only state with text or symbols, remove fixed heights in Flashcards, and provide reduced motion transitions.

## Verification Checklist

- VoiceOver read-through.
- Extra-large Dynamic Type.
- Increase Contrast.
- Reduce Motion.
- Reduce Transparency.
