#!/bin/bash

find -L . \
  -type f \
  -name "*.vcf" \
| sed "s#.vcf#.SEPARATE_COMMONAMR_LOWEUR#" \
| xargs mk
