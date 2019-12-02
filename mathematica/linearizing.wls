#!/usr/bin/env wolframscript
(* ::Package:: *)

SetDirectory[FileNameJoin[{NotebookDirectory[], "files"}]]
$Assumptions = _ \[Element] Reals


(* ::Text:: *)
(*Importing tau expression from previous script (dynamics.wls)*)


(tau = Import["tau_simp.mx"]) // MatrixForm
Dimensions[tau]


(* ::Text:: *)
(*Printing variables*)


Sort@DeleteDuplicates@Cases[tau, _Symbol, \[Infinity]]


(* ::Text:: *)
(*Variables that compose the dynamic parameters*)


params = {m1,m2,m3,m4,m5,m6,rx1,ry1,rz1,rx2,ry2,rz2,rx3,ry3,rz3,rx4,ry4,rz4,rx5,ry5,rz5,rx6,ry6,rz6,XX1,XY1,XZ1,YX1,YY1,YZ1,ZX1,ZY1,ZZ1,XX2,XY2,XZ2,YX2,YY2,YZ2,ZX2,ZY2,ZZ2,XX3,XY3,XZ3,YX3,YY3,YZ3,ZX3,ZY3,ZZ3,XX4,XY4,XZ4,YX4,YY4,YZ4,ZX4,ZY4,ZZ4,XX5,XY5,XZ5,YX5,YY5,YZ5,ZX5,ZY5,ZZ5,XX6,XY6,XZ6,YX6,YY6,YZ6,ZX6,ZY6,ZZ6};


(* ::Subsection::Closed:: *)
(*Obtaining the dynamic parameters and their coefficients*)


(* ::Subsubsection::Closed:: *)
(*Separating dynamic parameters from their coefficients*)


(* ::Text:: *)
(*This cell is repeated 6 times, for the torque of each joint*)
(*Expand[tau[[1]]] executes the distributive property of the multiplication, so that the final result is a sum of small expressions. The Chop eliminates small elements*)
(*Level[Expand[tau[[1]]] //Chop, {1}] makes an array of each parcel of the sum*)
(*Then, we iterate over those parcels (they would look something like 5.32 m1 XX2 ry1 cos(q1+q3) for instance)and break them down to each factor in the multiplication*)
(*Then we check whether those factors are dynamic parameters of coefficients (in the example above, the dynamic parameter would be m1 XX2 ry1 while the coefficient would be 5.32 cos(q1+q3)*)
(*Those parameters and coefficients are stored in the t1 and c1 arrays*)


start = AbsoluteTime[];
(children1 = Level[Expand[tau[[1]]] //Chop, {1}]) // MatrixForm;
stop = Length[children1]+1
t1 = {};
c1 = {};
Monitor[
For[i=1, i<stop, i++,
	parts = Level[children1[[i]], {1}];
	stop2 = Length[parts]+1;
	ti = 1;
	ci = 1;
	For[j=1, j<stop2, j++,
		If[ ContainsAny[params, Level[parts[[j]],{-1}]],
			ti = ti * parts[[j]];
			,
			ci = ci * parts[[j]];
		];
	];
	AppendTo[t1, ti];
	AppendTo[c1, ci];
];, i]
AbsoluteTime[] - start


start = AbsoluteTime[];
(children2 = Level[Expand[tau[[2]]] //Chop, {1}]) // MatrixForm;
stop = Length[children2]+1
t2 = {};
c2 = {};
Monitor[
For[i=1, i<stop, i++,
	parts = Level[children2[[i]], {1}];
	stop2 = Length[parts]+1;
	ti = 1;
	ci = 1;
	For[j=1, j<stop2, j++,
		If[ ContainsAny[params, Level[parts[[j]],{-1}]],
			ti = ti * parts[[j]];
			,
			ci = ci * parts[[j]];
		];
	];
	AppendTo[t2, ti];
	AppendTo[c2, ci];
];, i]
AbsoluteTime[] - start


start = AbsoluteTime[];
(children3 = Level[Expand[tau[[3]]] //Chop, {1}]) // MatrixForm;
stop = Length[children3]+1
t3 = {};
c3 = {};
Monitor[
For[i=1, i<stop, i++,
	parts = Level[children3[[i]], {1}];
	stop2 = Length[parts]+1;
	ti = 1;
	ci = 1;
	For[j=1, j<stop2, j++,
		If[ ContainsAny[params, Level[parts[[j]],{-1}]],
			ti = ti * parts[[j]];
			,
			ci = ci * parts[[j]];
		];
	];
	AppendTo[t3, ti];
	AppendTo[c3, ci];
];, i]
AbsoluteTime[] - start


start = AbsoluteTime[];
(children4 = Level[Expand[tau[[4]]] //Chop, {1}]) // MatrixForm;
stop = Length[children4]+1
t4 = {};
c4 = {};
Monitor[
For[i=1, i<stop, i++,
	parts = Level[children4[[i]], {1}];
	stop2 = Length[parts]+1;
	ti = 1;
	ci = 1;
	For[j=1, j<stop2, j++,
		If[ ContainsAny[params, Level[parts[[j]],{-1}]],
			ti = ti * parts[[j]];
			,
			ci = ci * parts[[j]];
		];
	];
	AppendTo[t4, ti];
	AppendTo[c4, ci];
];, i]
AbsoluteTime[] - start


start = AbsoluteTime[];
(children5 = Level[Expand[tau[[5]]] //Chop, {1}]) // MatrixForm;
stop = Length[children5]+1
t5 = {};
c5 = {};
Monitor[
For[i=1, i<stop, i++,
	parts = Level[children5[[i]], {1}];
	stop2 = Length[parts]+1;
	ti = 1;
	ci = 1;
	For[j=1, j<stop2, j++,
		If[ ContainsAny[params, Level[parts[[j]],{-1}]],
			ti = ti * parts[[j]];
			,
			ci = ci * parts[[j]];
		];
	];
	AppendTo[t5, ti];
	AppendTo[c5, ci];
];, i]
AbsoluteTime[] - start


start = AbsoluteTime[];
(children6 = Level[Expand[tau[[6]]] //Chop, {1}]) // MatrixForm;
stop = Length[children6]+1
t6 = {};
c6 = {};
Monitor[
For[i=1, i<stop, i++,
	parts = Level[children6[[i]], {1}];
	stop2 = Length[parts]+1;
	ti = 1;
	ci = 1;
	For[j=1, j<stop2, j++,
		If[ ContainsAny[params, Level[parts[[j]],{-1}]],
			ti = ti * parts[[j]];
			,
			ci = ci * parts[[j]];
		];
	];
	AppendTo[t6, ti];
	AppendTo[c6, ci];
];, i]
AbsoluteTime[] - start


(* ::Subsubsection::Closed:: *)
(*Obtaining all the dynamic parameters*)


(* ::Text:: *)
(*The dynamic parameters are the unique entries in the concatenation of all of the dynamic parameters of each joint*)


t = Join[t1, t2, t3, t4, t5, t6];
Length[t]
Length[DeleteDuplicates[t]]
theta = Sort@DeleteDuplicates[t]


(* ::Subsection::Closed:: *)
(*Linearizing the model*)


(* ::Subsubsection::Closed:: *)
(*Linearizing each joint's torque*)


(* ::Text:: *)
(*Now we want to take the model and rewrite it linearly with respect to the dynamic parameters, tau(q, dq, ddq) = Y(q, dq, ddq) * theta*)
(*The following 6 cells do the same thing for each of the joints, which is creating a matrix with the coefficients (Y) by comparing*)
(*the dynamic parameters in that joint's torque expression with the dynamic parameters of the whole model*)


Y1 = ConstantArray[0, Length[theta]];
stop = Length[children1] + 1
Monitor[
For[i=1, i<stop, i++,
	parts = Level[children1[[i]], {1}];
	stop2 = Length[parts]+1;
	par = 1;
	For[j=1, j<stop2, j++,
		If[ ContainsAny[params, Level[parts[[j]],{-1}]],
			par = par * parts[[j]];
		];
	];
	pos = Position[theta, par, 1];
	pos = pos[[1,1]];
	Y1[[pos]] = Y1[[pos]] + c1[[i]];
];, i]


Y2 = ConstantArray[0, Length[theta]];
stop = Length[children2] + 1
Monitor[
For[i=1, i<stop, i++,
	parts = Level[children2[[i]], {1}];
	stop2 = Length[parts]+1;
	par = 1;
	For[j=1, j<stop2, j++,
		If[ ContainsAny[params, Level[parts[[j]],{-1}]],
			par = par * parts[[j]];
		];
	];
	pos = Position[theta, par, 1];
	pos = pos[[1,1]];
	Y2[[pos]] = Y2[[pos]] + c2[[i]];
];, i]


Y3 = ConstantArray[0, Length[theta]];
stop = Length[children3] + 1
Monitor[
For[i=1, i<stop, i++,
	parts = Level[children3[[i]], {1}];
	stop2 = Length[parts]+1;
	par = 1;
	For[j=1, j<stop2, j++,
		If[ ContainsAny[params, Level[parts[[j]],{-1}]],
			par = par * parts[[j]];
		];
	];
	pos = Position[theta, par, 1];
	pos = pos[[1,1]];
	Y3[[pos]] = Y3[[pos]] + c3[[i]];
];, i]


Y4 = ConstantArray[0, Length[theta]];
stop = Length[children4] + 1
Monitor[
For[i=1, i<stop, i++,
	parts = Level[children4[[i]], {1}];
	stop2 = Length[parts]+1;
	par = 1;
	For[j=1, j<stop2, j++,
		If[ ContainsAny[params, Level[parts[[j]],{-1}]],
			par = par * parts[[j]];
		];
	];
	pos = Position[theta, par, 1];
	pos = pos[[1,1]];
	Y4[[pos]] = Y4[[pos]] + c4[[i]];
];, i]


Y5 = ConstantArray[0, Length[theta]];
stop = Length[children5] + 1
Monitor[
For[i=1, i<stop, i++,
	parts = Level[children5[[i]], {1}];
	stop2 = Length[parts]+1;
	par = 1;
	For[j=1, j<stop2, j++,
		If[ ContainsAny[params, Level[parts[[j]],{-1}]],
			par = par * parts[[j]];
		];
	];
	pos = Position[theta, par, 1];
	pos = pos[[1,1]];
	Y5[[pos]] = Y5[[pos]] + c5[[i]];
];, i]


Y6 = ConstantArray[0, Length[theta]];
stop = Length[children6] + 1
Monitor[
For[i=1, i<stop, i++,
	parts = Level[children6[[i]], {1}];
	stop2 = Length[parts]+1;
	par = 1;
	For[j=1, j<stop2, j++,
		If[ ContainsAny[params, Level[parts[[j]],{-1}]],
			par = par * parts[[j]];
		];
	];
	pos = Position[theta, par, 1];
	pos = pos[[1,1]];
	Y6[[pos]] = Y6[[pos]] + c6[[i]];
];, i]


(* ::Subsubsection::Closed:: *)
(*Regressor*)


(* ::Text:: *)
(*Concatenating the matrices we just obtained*)


Y = ArrayFlatten[{Y1, Y2, Y3, Y4, Y5, Y6}];
Dimensions[Y]
nparams = Length[theta]


Export["Y.mx", Y]


(* ::Text:: *)
(*Simplifying*)


Ysimp = ConstantArray[0,{6,nparams}];
start = AbsoluteTime[];
Monitor[
	For[i=1, i<6*nparams+1, i++,
		entry = Simplify[Y[[Quotient[i-1,nparams]+1, Mod[i-1,nparams]+1]]] // Chop;
		Ysimp[[Quotient[i-1,nparams]+1, Mod[i-1,nparams]+1]] = entry
	];
, {i, AbsoluteTime[] - start}]

AbsoluteTime[] - start


Export["Y_simp.mx", Ysimp]
(*ClearAll[ToMatlab]*)
<<ToMatlab`
Export["Y_matlab.txt", (Ysimp // ToMatlab)]
Export["theta.txt", theta]


Y // MatrixForm;
Ysimp // MatrixForm


Ysimp = Import["Y_simp.mx"];


(* ::Subsection::Closed:: *)
(*Finding the base dynamic parameters*)


(* ::Text:: *)
(*This is a numerical way of obtaining the set of base dynamic parameters*)
(*First we generate a big matrix by stacking the regressor applied to random joint variables over and over*)


gamma = Y /. {q1-> RandomReal[], q2-> RandomReal[], q3-> RandomReal[], q4-> RandomReal[], q5-> RandomReal[], q6-> RandomReal[], dq1-> RandomReal[], dq2-> RandomReal[], dq3-> RandomReal[], dq4-> RandomReal[], dq5-> RandomReal[], dq6-> RandomReal[], ddq1-> RandomReal[], ddq2-> RandomReal[], ddq3-> RandomReal[], ddq4-> RandomReal[], ddq5-> RandomReal[], ddq6-> RandomReal[]};
Monitor[
For[i=1, i<200, i++,
	yi = Y /. {q1-> RandomReal[], q2-> RandomReal[], q3-> RandomReal[], q4-> RandomReal[], q5-> RandomReal[], q6-> RandomReal[], dq1-> RandomReal[], dq2-> RandomReal[], dq3-> RandomReal[], dq4-> RandomReal[], dq5-> RandomReal[], dq6-> RandomReal[], ddq1-> RandomReal[], ddq2-> RandomReal[], ddq3-> RandomReal[], ddq4-> RandomReal[], ddq5-> RandomReal[], ddq6-> RandomReal[]};
	gamma = ArrayFlatten[{{gamma}, {yi}}];
], i]
Dimensions[gamma]


(* ::Text:: *)
(*The rank will give the number of linearly independent columns, which is the number of linearly independent parameters*)


rank = MatrixRank[gamma]


(* ::Text:: *)
(*Finding out a set of linearly independent parameters*)


(*Clear[S, DBS, DL, L, Alpha, alpha, alphai]*)
S = {}; (*Identifiable parameters*)
DBS = {}; (*Base set of identifiable parameters*)
DL = {}; (*Parameters identifiable in linear combinations*)
L = ConstantArray[0, {1,Length[gamma]}]; (*Zero as a dummy value, to not influence rank*) (*L contains the linearly independent columns (lines) related to the parameters already present in subset DBS *)
Alpha = ConstantArray[0, {1,Length[gamma]}]; (*Zero as a dummy value*) (*storing linearly dependent columns to calculate coefficients later*)
Monitor[
For[i=1, i<Length[theta]+1, i++,
	r = MatrixRank[Drop[gamma, 0, {i}]];
	If[r < rank,
		AppendTo[S, i];
		AppendTo[DBS, i];
		L = ArrayFlatten[{{L},{{gamma[[All,i]]}}}];,
	(*else*)
		oldRankL = MatrixRank[L];
		newRankL = MatrixRank[ArrayFlatten[{{L},{{gamma[[All,i]]}}}]];
		If[newRankL > oldRankL,
			AppendTo[DBS, i];
			L = ArrayFlatten[{{L},{{gamma[[All,i]]}}}];,
		(*else*)
			(*Should be removing column from gamma, but that will mess up the index i, so I'm just setting to zero to prevent linear combinations in the future*)
			Alpha = ArrayFlatten[{{Alpha},{{gamma[[All,i]]}}}];
			gamma[[All, i]] = ConstantArray[0, Dimensions[gamma][[1]]];
			AppendTo[DL, i];
		];
	];
];, i]


(*Dropping initial zeros*)
L = Drop[L, {1}, 0];
Alpha = Drop[Alpha, {1}, 0];


(*Just checking*)
S
Length[S]
DBS
Length[DBS]
DL
Length[DL]
Dimensions[L]
L[[1, All]];
Dimensions[Alpha]
Alpha[[1, All]];


(* ::Text:: *)
(*Calculating the coefficients of the linear combinations*)


alpha = ConstantArray[0, Dimensions[L][[1]]]; (*Zero as a dummy value*) (*storing coefficients for the linearly dependent parameters*)
Monitor[
For[i=1, i<Dimensions[Alpha][[1]]+1, i++,
	alphai = Inverse[L . Transpose[L]] . L . Alpha[[i]];
	alpha = ArrayFlatten[{{alpha},{{alphai}}}];
];, i]


Dimensions[alphai]
Dimensions[alpha]
Dimensions[Drop[alpha, {1}, 0]]
Chop[Drop[alpha, {1}, 0], 10^-6] // MatrixForm


(* ::Subsection::Closed:: *)
(*Reducing the regressor to contain only the linearly independent parameters*)


Dimensions[Y]
Yminimal = ConstantArray[0, {6,Length[DBS]}]; (*Zero as a dummy value*)
Monitor[
For[i=1, i<Length[DBS]+1, i++,
	Yminimal[[All, i]] = Y[[All, DBS[[i]]]];
];, i]


start = AbsoluteTime[];
Monitor[
	For[i=1, i<6*Length[DBS]+1, i++,
		entry = Simplify[Yminimal[[Quotient[i-1,Length[DBS]]+1, Mod[i-1,Length[DBS]]+1]]] // Chop;
		Yminimal[[Quotient[i-1,Length[DBS]]+1, Mod[i-1,Length[DBS]]+1]] = entry
	];
, {i, AbsoluteTime[] - start}]

AbsoluteTime[] - start


Dimensions[Yminimal]
Sort@DeleteDuplicates@Cases[Yminimal, _Symbol, \[Infinity]]
Yminimal // MatrixForm


Export["Y_reduced.mx", Yminimal]
<<ToMatlab`
Export["Y_reduced_matlab.txt", (Yminimal // ToMatlab)]


(* ::Text:: *)
(*The base dynamic parameters*)


theta[[DBS]]


(* ::Subsection::Closed:: *)
(*Obtaining expression for forward dynamics*)


(* ::Text:: *)
(*We previously had the inverse dynamics: tau(q, dq, ddq)*)
(*Now we want the forward dynamics: ddq(q, dq, tau)*)
(*We do that by writing tau as: tau = A(q, dq) + B(q)*ddq*)
(*Then the forward dynamics is: ddq = B(q)^(-1) * (tau - A(q, dq))*)


(T = Import["Y_reduced.mx"]) // MatrixForm


(* ::Text:: *)
(*A is the component without acceleration*)


A = T /. {ddq1 -> 0, ddq2 -> 0, ddq3 -> 0, ddq4 -> 0, ddq5 -> 0, ddq6 -> 0} // Chop;
Sort@DeleteDuplicates@Cases[A, _Symbol, \[Infinity]]
Dimensions[A]


(* ::Text:: *)
(*B is what multiplies the acceleration*)


B1 = Coefficient[T, ddq1];
B2 = Coefficient[T, ddq2];
B3 = Coefficient[T, ddq3];
B4 = Coefficient[T, ddq4];
B5 = Coefficient[T, ddq5];
B6 = Coefficient[T, ddq6];


<< ToMatlab`
Export["B1_matlab.txt", (B1 // ToMatlab)]
Export["B2_matlab.txt", (B2 // ToMatlab)]
Export["B3_matlab.txt", (B3 // ToMatlab)]
Export["B4_matlab.txt", (B4 // ToMatlab)]
Export["B5_matlab.txt", (B5 // ToMatlab)]
Export["B6_matlab.txt", (B6 // ToMatlab)]
$RecursionLimit = Infinity
Export["As_matlab.txt", (A // ToMatlab)]
$RecursionLimit = 1024


(* ::Text:: *)
(*In this case, as we broke down Y and not tau, we need to multiply these by theta later*)
