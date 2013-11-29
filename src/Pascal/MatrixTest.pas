program MatrixTest;

uses Matrix2D;

var
	A: Matrix;
	B: Matrix;
	A_inv: RealMatrix;
	LU: array [0..1] of RealMatrix;
	m, n, c: integer;
	F, X: TRealDynArray;
	i, j: integer;

begin
	write('m = ');
	read(m);
	write('n = ');
	read(n);
	A := Gen2DMatrix(m, n);
	Print2DMatrix(A);
	writeln();

	writeln('A^T:');
	Print2DMatrix(Transpose(A));
	writeln();

	B := Gen2DMatrix(n, m);
	Print2DMatrix(A);
	writeln('x');
	Print2DMatrix(B);
	writeln('---');
	Print2DMatrix(Multiply(A, B));
	writeln();

	write('c (in ZZ) = ');
	read(c);
	writeln(c);
	writeln('*');
	Print2DMatrix(A);
	writeln('---');
	Print2DMatrix(Multiply(A, c));

	writeln('LU-decomposition');
	write('n = ');
	read(n);
	A := Gen2DMatrix(n, n);
	Print2DMatrix(A);
	LU := LUDecomposition(A);
	writeln('L = ');
	Print2DMatrix(LU[0]);
	writeln('U = ');
	Print2DMatrix(LU[1]);
	writeln();
	writeln('det: ', Determinant(A):0:2);
	writeln();

	writeln('Forward-backward substitution');
	InitMatrix(A, 3);
	A[0, 0] := 1;
	A[0, 1] := 0;
	A[0, 2] := 2;
	A[1, 0] := 2;
	A[1, 1] := -1;
	A[1, 2] := 3;
	A[2, 0] := 4;
	A[2, 1] := 1;
	A[2, 2] := 8;
	Print2DMatrix(A);
	LU := LUDecomposition(A);
	SetLength(F, 3);
	F[0] := -4;
	F[1] := -6;
	F[2] := -15;
	writeln('F:');
	PrintArray(F, ' ');
	X := ForwardBackwardSubst(LU[0], LU[1], F);
	PrintArray(X, ' ');
	writeln();

	writeln('Inverse');
	{ InitMatrix(A, 3);
	A[0, 0] := 1;
	A[0, 1] := 0;
	A[0, 2] := 2;
	A[1, 0] := 2;
	A[1, 1] := -1;
	A[1, 2] := 3;
	A[2, 0] := 4;
	A[2, 1] := 1;
	A[2, 2] := 8; }
	A := Gen2DMatrix(n, n);
	writeln('A:');
	Print2DMatrix(A);
	writeln();
	LU := LUDecomposition(A);
	SetLength(F, Length(A));
	InitMatrix(A_inv, Length(A));
	for i := 0 to Length(A)-1 do
	begin
		for j := 0 to Length(A)-1 do
			F[j] := Eye(Length(A))[j][i];
		X := ForwardBackwardSubst(LU[0], LU[1], F);
		for j := 0 to Length(A)-1 do
			A_inv[j][i] := X[j];
	end;
	writeln('Inverse of A:');
	Print2DMatrix(A_inv);
	writeln();
	writeln('Multiplying A to A_inv...');
	writeln();
	Print2DMatrix(Multiply(A, A_inv));

	writeln('Eye (5): ');
	Print2DMatrix(Eye(5));
end.
