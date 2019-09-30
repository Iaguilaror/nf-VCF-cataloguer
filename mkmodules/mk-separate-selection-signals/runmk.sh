#!/bin/bash

find -L . \
  -type f \
  -name "*.vcf" \
| sed "s#.vcf#.SEPARATE_BY_SELECTION_SIGNALS#" \
| xargs mk
