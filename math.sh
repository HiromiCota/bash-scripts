#!/bin/bash

# Integer math
mathparen1=$((4+4))
(( mathparen2 = 4 + 4 ))

mathbrack=$[4+4]
mathexpr=$(expr 4 + 4)
let mathlet=4+4

# Floating point math
mathfpline=$(echo "scale=2; 4 / 3" | bc)
mathfpmline=$(bc << EOF
scale=4
4 / 3
EOF
)

echo "parenthisis   - $mathparen1"
echo "brackets      - $mathbrack"
echo "expr command  - $mathexpr"
echo "let           - $mathlet"
echo "bc one line   - $mathfpline"
echo "bc multi line - $mathfpmline"

