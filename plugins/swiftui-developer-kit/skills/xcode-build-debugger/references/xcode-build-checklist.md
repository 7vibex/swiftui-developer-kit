# Xcode Build Checklist

- Detect project type: workspace, project, or Swift package.
- Identify scheme and destination.
- Check package resolution errors.
- Separate compile errors from linker, signing, provisioning, and runtime launch errors.
- Look for generated file or asset catalog errors.
- Check minimum deployment target mismatches.
- Check Swift language mode and package platform support.
- Prefer the smallest failing target when reproducing.
