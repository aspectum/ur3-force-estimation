#!/usr/bin/env wolframscript
(* ::Package:: *)

(* ::Text:: *)
(*Setting up notebook*)


SetDirectory[FileNameJoin[{NotebookDirectory[], "files"}]]  (*Path where the generated matrices are going to be saved*)
$Assumptions = _ \[Element] Reals  (*To avoid complex numbers showing up in simplifications*)


(* ::Text:: *)
(*Joint positions, velocities and accelerations vectors*)


q = {q1, q2, q3, q4, q5, q6}
dq = {dq1, dq2, dq3, dq4, dq5, dq6}
ddq = {ddq1, ddq2, ddq3, ddq4, ddq5, ddq6}


(* ::Subsection::Closed:: *)
(*Denavit-Hartenberg parameters*)


theta = {q1, q2, q3, q4, q5, q6};
d = {0.1519, 0, 0, 0.11235, 0.08535, 0.0819};
a = {0, 0.24365, 0.21325, 0, 0, 0};
alpha = {-Pi/2, 0, 0, -Pi/2, Pi/2, 0};


(* ::Text:: *)
(*Calculating transformation matrices*)


A = ConstantArray[0,{6,4,4}];
For[i=1, i<7, i++,
A[[i, All, All]] = {{Cos[theta[[i]]], -Sin[theta[[i]]]*Cos[alpha[[i]]],  Sin[theta[[i]]]*Sin[alpha[[i]]], a[[i]]*Cos[theta[[i]]]},
                   {Sin[theta[[i]]],  Cos[theta[[i]]]*Cos[alpha[[i]]], -Cos[theta[[i]]]*Sin[alpha[[i]]], a[[i]]*Sin[theta[[i]]]},
                   {              0,                 Sin[alpha[[i]]],                  Cos[alpha[[i]]],                 d[[i]]},
                   {              0,                               0,                                0,                     1}}]


(T1 = A[[1, All, All]])//MatrixForm;
(T2 = Simplify[T1.A[[2, All, All]]])//MatrixForm;
(T3 = Simplify[T2.A[[3, All, All]]])//MatrixForm;
(T4 = Simplify[T3.A[[4, All, All]]])//MatrixForm;
(T5 = Simplify[T4.A[[5, All, All]]])//MatrixForm;
(T6 = Simplify[T5.A[[6, All, All]]])//MatrixForm;


(* ::Text:: *)
(*Rotations between coordinate frames and base frame*)


(R01 = T1[[1;;3, 1;;3]])//MatrixForm;
(R02 = T2[[1;;3, 1;;3]])//MatrixForm;
(R03 = T3[[1;;3, 1;;3]])//MatrixForm;
(R04 = T4[[1;;3, 1;;3]])//MatrixForm;
(R05 = T5[[1;;3, 1;;3]])//MatrixForm;
(R06 = T6[[1;;3, 1;;3]])//MatrixForm;


(* ::Text:: *)
(*Translations between coordinate frames and base frame*)


o01 = T1[[1;;3, 4]];
o02 = T2[[1;;3, 4]];
o03 = T3[[1;;3, 4]];
o04 = T4[[1;;3, 4]];
o05 = T5[[1;;3, 4]];
o06 = T6[[1;;3, 4]];


(* ::Text:: *)
(*Orientations of the z axis of the coordinate frames*)


z00 = {0, 0, 1};
z01 = R01 . z00;
z02 = R02 . z00;
z03 = R03 . z00;
z04 = R04 . z00;
z05 = R05 . z00;


(* ::Subsection::Closed:: *)
(*Regular Jacobian (end - effector)*)


(* ::Text:: *)
(*Position of the centers of mass in link coordinates*)


cm1 = {rx1, ry1, rz1};
cm2 = {rx2, ry2, rz2};
cm3 = {rx3, ry3, rz3};
cm4 = {rx4, ry4, rz4};
cm5 = {rx5, ry5, rz5};
cm6 = {rx6, ry6, rz6};


(* ::Text:: *)
(*Position of the centers of mass in base frame*)


r01 = Simplify[o01 + R01 . cm1];
r02 = Simplify[o02 + R02 . cm2];
r03 = Simplify[o03 + R03 . cm3];
r04 = Simplify[o04 + R04 . cm4];
r05 = Simplify[o05 + R05 . cm5];
r06 = Simplify[o06 + R06 . cm6];


(* ::Subsection::Closed:: *)
(*G matrix - gravity component of dynamic model*)


g = {0, 0, -9.81};

P1 = m1 * g . r01;
P2 = m2 * g . r02;
P3 = m3 * g . r03;
P4 = m4 * g . r04;
P5 = m5 * g . r05;
P6 = m6 * g . r06;

(P = P1 + P2 + P3 + P4 + P5 + P6);


g1 = Simplify[D[P, q1]];
g2 = Simplify[D[P, q2]];
g3 = Simplify[D[P, q3]];
g4 = Simplify[D[P, q4]];
g5 = Simplify[D[P, q5]];
g6 = Simplify[D[P, q6]];

(GG = {g1, g2, g3, g4, g5, g6}) // MatrixForm;


(* ::Text:: *)
(*Saving G matrix*)


Directory[]
Export["G_matrix.mx", GG]
ClearAll[ToMatlab]
<<ToMatlab`
Export["G_matlab.txt", (GG // ToMatlab)]


(* ::Subsection::Closed:: *)
(*Center of mass Jacobians*)


(* ::Text:: *)
(*Angular component*)


vzeros = ConstantArray[0, 3];
(Jc1w = Transpose[{z00, vzeros, vzeros, vzeros, vzeros, vzeros}]) // MatrixForm;
(Jc2w = Transpose[{z00, z01, vzeros, vzeros, vzeros, vzeros}]) // MatrixForm;
(Jc3w = Transpose[{z00, z01, z02, vzeros, vzeros, vzeros}]) // MatrixForm;
(Jc4w = Transpose[{z00, z01, z02, z03, vzeros, vzeros}]) // MatrixForm;
(Jc5w = Transpose[{z00, z01, z02, z03, z04, vzeros}]) // MatrixForm;
(Jc6w = Transpose[{z00, z01, z02, z03, z04, z05}]) // MatrixForm;


(* ::Text:: *)
(*Linear component*)


(Jc1v = Simplify[Transpose[{D[r01, q1], vzeros, vzeros, vzeros, vzeros, vzeros}]]) // MatrixForm;
(Jc2v = Simplify[Transpose[{D[r02, q1], D[r02, q2], vzeros, vzeros, vzeros, vzeros}]]) // MatrixForm;
(Jc3v = Simplify[Transpose[{D[r03, q1], D[r03, q2], D[r03, q3], vzeros, vzeros, vzeros}]]) // MatrixForm;
(Jc4v = Simplify[Transpose[{D[r04, q1], D[r04, q2], D[r04, q3], D[r04, q4], vzeros, vzeros}]]) // MatrixForm;
(Jc5v = Simplify[Transpose[{D[r05, q1], D[r05, q2], D[r05, q3], D[r05, q4], D[r05, q5], vzeros}]]) // MatrixForm;
(Jc6v = Simplify[Transpose[{D[r06, q1], D[r06, q2], D[r06, q3], D[r06, q4], D[r06, q5], D[r06, q6]}]]) // MatrixForm;


(* ::Text:: *)
(*Inertia tensors of links*)


(I1 = {{XX1, XY1, XZ1}, {XY1, YY1, YZ1}, {XZ1, YZ1, ZZ1}}) // MatrixForm;
(I2 = {{XX2, XY2, XZ2}, {XY2, YY2, YZ2}, {XZ2, YZ2, ZZ2}}) // MatrixForm;
(I3 = {{XX3, XY3, XZ3}, {XY3, YY3, YZ3}, {XZ3, YZ3, ZZ3}}) // MatrixForm;
(I4 = {{XX4, XY4, XZ4}, {XY4, YY4, YZ4}, {XZ4, YZ4, ZZ4}}) // MatrixForm;
(I5 = {{XX5, XY5, XZ5}, {XY5, YY5, YZ5}, {XZ5, YZ5, ZZ5}}) // MatrixForm;
(I6 = {{XX6, XY6, XZ6}, {XY6, YY6, YZ6}, {XZ6, YZ6, ZZ6}}) // MatrixForm;


(* ::Subsection::Closed:: *)
(*D matrix - inertia matrix*)


start = AbsoluteTime[];
(D1 = Simplify[m1 * Transpose[Jc1v] . Jc1v + Transpose[Jc1w] . R01 . I1 . Transpose[R01] . Jc1w] // Chop) // MatrixForm
(D2 = Simplify[m2 * Transpose[Jc2v] . Jc2v + Transpose[Jc2w] . R02 . I2 . Transpose[R02] . Jc2w] // Chop) // MatrixForm
(D3 = Simplify[m3 * Transpose[Jc3v] . Jc3v + Transpose[Jc3w] . R03 . I3 . Transpose[R03] . Jc3w] // Chop) // MatrixForm
(D4 = Simplify[m4 * Transpose[Jc4v] . Jc4v + Transpose[Jc4w] . R04 . I4 . Transpose[R04] . Jc4w] // Chop) // MatrixForm
(D5 = Simplify[m5 * Transpose[Jc5v] . Jc5v + Transpose[Jc5w] . R05 . I5 . Transpose[R05] . Jc5w] // Chop) // MatrixForm
(D6 = Simplify[m6 * Transpose[Jc6v] . Jc6v + Transpose[Jc6w] . R06 . I6 . Transpose[R06] . Jc6w] // Chop) // MatrixForm
AbsoluteTime[] - start

start = AbsoluteTime[];
(DD = Simplify[D1 + D2 + D3 + D4 + D5 + D6]) // MatrixForm
AbsoluteTime[] - start


Directory[]
Export["D_matrix.mx", DD]
<<ToMatlab`
Export["D_matlab.txt", (DD // ToMatlab)]


(* ::Text:: *)
(*Loading from file*)


(*(DD = Import["D_matrix.mx"]) //MatrixForm*)


(* ::Subsection::Closed:: *)
(*C matrix - coriolis and centrifugal components*)


SetOptions[Simplify, TimeConstraint -> 500]


(* ::Text:: *)
(*Differentiating D matrix with respect to joint variables*)


dD1 = D[DD, q1];
dD2 = D[DD, q2];
dD3 = D[DD, q3];
dD4 = D[DD, q4];
dD5 = D[DD, q5];
dD6 = D[DD, q6];


(* ::Text:: *)
(*Simplifying derivatives*)


Directory[]
start = AbsoluteTime[];
(dd1 = Simplify[dD1] // Chop) // MatrixForm
Export["dd1.mx", dd1]
AbsoluteTime[] - start
(dd2 = Simplify[dD2] // Chop) // MatrixForm
Export["dd2.mx", dd2]
AbsoluteTime[] - start
(dd3 = Simplify[dD3] // Chop) // MatrixForm
Export["dd3.mx", dd3]
AbsoluteTime[] - start
(dd4 = Simplify[dD4] // Chop) // MatrixForm
Export["dd4.mx", dd4]
AbsoluteTime[] - start
(dd5 = Simplify[dD5] // Chop) // MatrixForm
Export["dd5.mx", dd5]
AbsoluteTime[] - start
(dd6 = Simplify[dD6] // Chop) // MatrixForm
Export["dd6.mx", dd6]
AbsoluteTime[] - start


dd1 = Import["dd1.mx"];
dd2 = Import["dd2.mx"];
dd3 = Import["dd3.mx"];
dd4 = Import["dd4.mx"];
dd5 = Import["dd5.mx"];
dd6 = Import["dd6.mx"];


ddd = ConstantArray[0,{6,6,6}];
ddd[[1, All, All]] = dd1;
ddd[[2, All, All]] = dd2;
ddd[[3, All, All]] = dd3;
ddd[[4, All, All]] = dd4;
ddd[[5, All, All]] = dd5;
ddd[[6, All, All]] = dd6;


(* ::Text:: *)
(*Calculating C matrix*)


CCC = ConstantArray[0,{6,6}];
start = AbsoluteTime[];
Monitor[
For[k=1, k<7, k++,
	For[j=1, j<7, j++,
		acc = 0;
		For[i=1, i<7, i++,
			acc += ddd[[i, k, j]] * dq[[i]] + ddd[[j, k, i]] * dq[[i]] - ddd[[k, i, j]] * dq[[i]];
		];
		CCC[[k, j]] = acc/2;
	];
];, {6*(k-1)+j, AbsoluteTime[] - start}]
AbsoluteTime[] - start


(* ::Text:: *)
(*Simplifying C matrix, element by element*)


CC = ConstantArray[0,{6,6}];
start = AbsoluteTime[];
Monitor[
	For[i=1, i<37, i++,
		entry = Simplify[CCC[[Quotient[i-1,6]+1, Mod[i-1,6]+1]]] // Chop;
		Export[StringJoin["cc_", TextString[i], ".mx"], entry];
		CC[[Quotient[i-1,6]+1, Mod[i-1,6]+1]] = entry]
, {i, AbsoluteTime[] - start}]

AbsoluteTime[] - start


(*start = AbsoluteTime[];
entry = Simplify[CCC[[4, 1]]] // Chop;
Export[StringJoin["cc_19.txt"], entry, "Text"];
AbsoluteTime[] - start*)
(*entry = Simplify[CCC[[4, 6]]] // Chop;
Export[StringJoin["cc_24.txt"], entry, "Text"];
AbsoluteTime[] - start
entry = Simplify[CCC[[6, 3]]] // Chop;
Export[StringJoin["cc_33.txt"], entry, "Text"];
AbsoluteTime[] - start*)


CC = ConstantArray[0,{6,6}];
start = AbsoluteTime[];
Monitor[
	For[i=1, i<37, i++,
		entry = Import[StringJoin["cc_", TextString[i], ".mx"]];
		CC[[Quotient[i-1,6]+1, Mod[i-1,6]+1]] = entry];
, {i, AbsoluteTime[] - start}]


CC // MatrixForm;


Directory[]
Export["C_matrix.mx", CC]
<<ToMatlab`
Export["C_matlab.txt", (CC // ToMatlab)]


(* ::Subsection::Closed:: *)
(*Generating torque expression*)


DD = Import["D_matrix.mx"]
CC = Import["C_matrix.mx"]
GG = Import["G_matrix.mx"]


(* ::Text:: *)
(*Expression of dynamic model*)


(tau = DD . ddq + CC . dq + GG) // MatrixForm


Directory[]
Export["tau_big.mx", tau]


(* ::Text:: *)
(*Simplifying*)


start = AbsoluteTime[];
Directory[]
tauSimp = ConstantArray[0,{6}];
Monitor[
For[i=1, i<7, i++,
	tauSimp[[i]] = Simplify[tau[[i]]] // Chop;
	Export[StringJoin["tausimp_", TextString[i], ".mx"], tauSimp[[i]]];
];, {i, AbsoluteTime[] - start}]
AbsoluteTime[] - start


tauSimp = ConstantArray[0,{6}];
start = AbsoluteTime[];
Monitor[
	For[i=1, i<7, i++,
		entry = Import[StringJoin["tausimp_", TextString[i], ".mx"]];
		tauSimp[[i]] = entry];
, {i, AbsoluteTime[] - start}]


(* ::Text:: *)
(*Saving*)


$RecursionLimit = Infinity (*Need to temporarily increase recursion limit for the ToMatlab script process tauSimp, because the expression is too complex*)
Export["tau_matlab.txt", (tauSimp // ToMatlab)]
$RecursionLimit = 1024
Export["tau_simp.mx", tauSimp]


(* ::Text:: *)
(*Checking the expressions*)


tau // MatrixForm
tauSimp // MatrixForm
Sort@DeleteDuplicates@Cases[tau, _Symbol, \[Infinity]] (*Shows the variables in the expression*)
Sort@DeleteDuplicates@Cases[tauSimp, _Symbol, \[Infinity]]


(* ::Text:: *)
(*Function to count number of operations (Source: https://mathematica.stackexchange.com/a/25764)*)


ClearAll[opCount];
opCount[x_, oper_: Times] := Tr @ ((Length[#] - 1) & /@
                       (Extract[x, {Sequence @@ Drop[#, -1]}] & /@ Position[x, oper]))


opCount[tau]
opCount[tauSimp]


(* ::Subsection::Closed:: *)
(*End effector Jacobian, for calculating external force contribution in torques*)


(Jw = Transpose[{z00, z01, z02, z03, z04, z05}]) // MatrixForm


(Jv = Simplify[Transpose[{D[o06, q1], D[o06, q2], D[o06, q3], D[o06, q4], D[o06, q5], D[o06, q6]}]]) // MatrixForm


J = ArrayFlatten[{{Jv}, {Jw}}];
J // MatrixForm


Export["J.mx", J]
<< ToMatlab`
Export["J_matlab.txt", (J // ToMatlab)]
