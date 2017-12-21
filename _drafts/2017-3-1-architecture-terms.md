# STOPPED on p 54 of POODR

Define:
architecture of a system =(df) the implementation of a system

y is an implementation of x =(df) y is a way of coding feature x

software architect =(df) someone whose job is to determine the optimal
implementation of a system

best practices =(df)...

technical debt =(df) time and/or resources required to make a system conform to
best practices

terms suggesting dependence:
* coupling, coupled
* knows, knowledge (27)
* encapsulation (27)
* entangled (21)

terms needing clarification:
* everything the class does [should] be _highly related_ to its purpose. (Metz, 22)
* each sender [. . .] must have __complete knowledge__ of what piece of data is at
  which index in the array

> SRP requires that a class be cohesive—that everything the class does be highly related to its purpose. (Metz, 22)

> To do anything useful, each sender of data must have complete knowledge of what piece
of data is at which index in the array. (Metz, 27)
