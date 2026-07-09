# Behavior Benchmarks

These are deterministic fixture evaluations for output-contract regression testing. They do not measure a live model, compare model vendors, or guarantee that every agent run will reproduce the checked-in text.

Each task includes:

- A public prompt and artifact.
- A deliberately weak baseline fixture.
- A skill-guided fixture.
- Required evidence, impact, fix, verification, confidence, missing-evidence, and safety fields.
- Local path validation so invented evidence fails.

Run:

```bash
./scripts/validate-benchmarks.sh
```

The invalid fixtures prove that hallucinated paths, missing evidence fields, and unsafe capture claims are rejected.
