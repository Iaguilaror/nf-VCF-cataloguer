#!/bin/bash

find -L . \
  -type f \
  -name "*.vcf" \
| sed "s#.vcf#.SEPARATE_miRNA#" \
| xargs mk
