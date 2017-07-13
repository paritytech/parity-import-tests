# Parity Import Tests

These tests are used to ensure that import and snapshot restoration of certain pre-created chains continues to function correctly.

Each directory contains a few things:
  - A chain specification
  - A "blocks.rlp" file containing all the blocks (produced by `parity export blocks`)
  - A "snap" file (produced by `parity snapshot`)
