#!/bin/bash

find -L . \
  -type f \
  -name "*.filtered.snv.tsv.gz" \
| sed "s#.filtered.snv.tsv.gz#.snv-variants_summary.tsv#" \
| xargs mk
