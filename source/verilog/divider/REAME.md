The Guild of Divider
===================

Introduction
-------------------

Because the divider is the most complicated one in 4 basic arthrimetic operations, this implementation must focus to down the size and enhance the speed.

Normally, a division is expressed as:

N/D = Q and R with |R| < D;		 [eq1]

However, a division can be implied as reverse of multiplication,

N = DxQ + R;                             [eq2]

Note that almost computers do [eq2] for division.

Infact, to implement a division, we use one of three algorithms: *restoring*, *nonperforming* and *CORDIC*.


