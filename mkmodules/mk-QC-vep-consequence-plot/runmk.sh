#!/bin/bash

find -L . \
  -type f \
  -name "*.tsv.gz" \
| sed "s#.tsv.gz#.vep_consequence.png#" \
| xargs mk
