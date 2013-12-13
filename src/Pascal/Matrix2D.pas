unit Matrix2D;

interface

uses
	SysUtils,
	Math,
	Strings;

type 
	Matrix = array of array of integer;
	RealMatrix = array of array of real;
	TIntDynArray = array of integer;
	TRealDynArray = array of real;
	MatrixTuple = array [0..1] of RealMatrix;


procedure PrintArray(A: array of LongInt; sep: string = LineEnding);
procedure PrintArray(A: TStringDynArray; sep: string = LineEnding);
procedure PrintArray(A: array of real; sep: string = LineEnding);
procedure Print2DMatrix(A: Matrix; sep: string = ' ');
procedure Print2DMatrix(A: RealMatrix; sep: string = ' ');
function Gen2DMatrix(m: integer = 3; n: integer = 0; RMax: integer = 10): Matrix;
function SumArray(A: array of LongInt): integer;
function StringToIntArray(S: string; sep: char = ' '): TIntDynArray;
function Transpose(A: Matrix): Matrix;
function Multiply(A: Matrix; B: Matrix): Matrix;
function Multiply(A: Matrix; B: RealMatrix): RealMatrix;
function Multiply(A: Matrix; c: integer): Matrix;
procedure InitMatrix(var A: Matrix; m: integer; n: integer = 0);
procedure InitMatrix(var A: RealMatrix; m: integer; n: integer = 0);
function LUDecomposition(A: Matrix): MatrixTuple;
function Determinant(A: Matrix): real;
function ForwardBackwardSubst(L: RealMatrix; U: RealMatrix; B: TRealDynArray): TRealDynArray;
function Eye(n: integer): Matrix;
function ConcatMatrix(A: RealMatrix; B: RealMatrix): RealMatrix;
procedure ReduceRow(var A: RealMatrix; row: integer; by_row: integer; start: integer);
function GaussElimination(A: RealMatrix; B: RealMatrix): RealMatrix;



implementation

uses
	crt;

procedure PrintArray(A: TStringDynArray; sep: string = LineEnding); overload;
var
	i: integer;
begin
	for i:=Low(A) to High(A) do
		write(A[i], sep);
	{ writeln(''); }
end;

procedure PrintArray(A: array of LongInt; sep: string = LineEnding); overload;
var
	i, d: integer;
begin
	d := 1;
	for i:=Low(A) to High(A) do
		d := max(Length(IntToStr(A[i])), d);
	for i:=Low(A) to High(A) do
		write(A[i]:d, sep);
	writeln('');
end;

procedure PrintArray(A: array of real; sep: string = LineEnding); overload;
var
	i: integer;
begin
	for i:=Low(A) to High(A) do
		write(A[i]:0:2, sep);
	writeln('');
end;

procedure Print2DMatrix(A: Matrix; sep: string = ' ');
var
	i: integer;
begin
	for i:=Low(A) to High(A) do
	begin
		PrintArray(A[i], sep);
	end;
end;

procedure Print2DMatrix(A: RealMatrix; sep: string = ' '); overload;
var
	i: integer;
begin
	for i:=Low(A) to High(A) do
	begin
		PrintArray(A[i], sep);
	end;
end;

function Gen2DMatrix(m: integer = 3; n: integer = 0; RMax: integer = 10): Matrix;
var
	Mx: Matrix;
	i, j: integer;
begin
	if n = 0 then
		n := m;
	Randomize;
	SetLength(Mx, m);
	for i:=Low(Mx) to High(Mx) do
	begin
		SetLength(Mx[i], n);
		for j:=Low(Mx[0]) to High(Mx[0]) do
			Mx[i, j] := Random(RMax);
	end;
	Gen2DMatrix := Mx;
end;

function SumArray(A: array of LongInt): integer;
var
	Accum: integer = 0;
	i: integer;
begin
	for i:=Low(A) to High(A) do
		Inc(Accum, A[i]);
	SumArray := Accum;
end;

function StringToIntArray(S: string; sep: char = ' '): TIntDynArray;
var
	Sx: TStringDynArray;
	Res: TIntDynArray;
	i: integer;
begin
	Sx := Split(S, sep);
	SetLength(Res, Length(Sx));
	for i:=0 to Length(Sx)-1 do
		Res[i] := StrToInt(Sx[i]);
	StringToIntArray := Res;
end;

procedure InitMatrix(var A: Matrix; m: integer; n: integer = 0); overload;
var
	i: integer;
begin
	SetLength(A, m);
	for i:=0 to (m-1) do
		if n = 0 then
			SetLength(A[i], m)
		else
			SetLength(A[i], n);
end;

procedure InitMatrix(var A: RealMatrix; m: integer; n: integer = 0); overload;
var
	i: integer;
begin
	SetLength(A, m);
	for i:=0 to (m-1) do
		if n = 0 then
			SetLength(A[i], m)
		else
			SetLength(A[i], n);
end;


function Transpose(A: Matrix): Matrix;
var
	B: Matrix;
	m, n, i, j: integer;
begin
	m := Length(A);
	n := Length(A[0]);
	InitMatrix(B, n, m);

	for i := 0 to (m - 1) do
	begin
		for j := 0 to (n - 1) do
			B[j, i] := A[i, j];
	end;

	Transpose := B;
end;

function Multiply(A: Matrix; B: Matrix): Matrix;	overload;
var
	C: Matrix;
	m_A, m_B, n_A, n_B, i, j, k: integer;
begin
	m_A := Length(A); 
	m_B := Length(B); 
	n_A := Length(A[0]); 
	n_B := Length(B[0]); 

	if (m_A <> n_B) or (n_A <> m_B) then
	begin
		writeln('Can''t multiply matrices [', m_A, ' x ', n_A, '] and [', m_B, ' x ', n_B, ']');
		halt();
	end;

	InitMatrix(C, m_A);

	for i := 0 to (m_A - 1) do
		for j := 0 to (n_B - 1) do
			for k := 0 to (n_A - 1) do
				C[i][j] := C[i][j] + A[i][k] * B[k][j];

	Multiply := C;
end;

function Multiply(A: Matrix; B: RealMatrix): RealMatrix;	overload;
var
	C: RealMatrix;
	m_A, m_B, n_A, n_B, i, j, k: integer;
begin
	m_A := Length(A); 
	m_B := Length(B); 
	n_A := Length(A[0]); 
	n_B := Length(B[0]); 

	if (m_A <> n_B) or (n_A <> m_B) then
	begin
		writeln('Can''t multiply matrices [', m_A, ' x ', n_A, '] and [', m_B, ' x ', n_B, ']');
		halt();
	end;

	InitMatrix(C, m_A);

	for i := 0 to (m_A - 1) do
		for j := 0 to (n_B - 1) do
			for k := 0 to (n_A - 1) do
				C[i][j] := C[i][j] + A[i][k] * B[k][j];

	Multiply := C;
end;

function Multiply(A: Matrix; c: integer): Matrix;	overload;
var
	i, j: integer;
begin
	for i := 0 to (Length(A) - 1) do
		for j := 0 to (Length(A[0]) - 1) do
			A[i][j] := A[i][j] * c;

	Multiply := A;
end;

function LUDecomposition(A: Matrix): MatrixTuple;
{ Make sure the matrix is square and non-singular }
{ Basically, following the algorithm from http://ru.math.wikia.com/wiki/LU-разложение }
var
	L, U: RealMatrix;
	LU: MatrixTuple;
	i, j, k, n: integer;
	acc: real;
begin
	n := Length(A);
	InitMatrix(L, n);
	InitMatrix(U, n);

	if A[0, 0] = 0 then
	begin
		writeln('a_11 is zero, cannot decompose');
		exit;
	end;

	for i := 0 to n-1 do
		for j := 0 to n-1 do
		begin
			U[0, i] := A[0, i];
			L[i, 0] := A[i, 0] / U[0, 0];
			acc := 0;
			for k := 0 to i-1 do
				acc := acc + L[i, k] * U[k, j];
			U[i, j] := A[i, j] - acc;
			if i > j then
				L[j, i] := 0
			else
			begin
				acc := 0;
				for k := 0 to i-1 do
					acc += L[j, k] * U[k, i];
				L[j, i] := (A[j, i] - acc) / U[i, i];
			end;
		end;

	LU[0] := L;
	LU[1] := U;

	LUDecomposition := LU;
end;

{ function LUDecomposition(A: Matrix): RealMatrix; }
{ [> Make sure the matrix is square and non-singular <] }
{ [> Following http://ru.wikipedia.org/wiki/LU-разложение, but this algorithm doesn't seem to work <] }
{ var }
	{ LU: RealMatrix; }
	{ i, j, k, n: integer; }
	{ acc: real; }
{ begin }
	{ n := Length(A); }
	{ InitMatrix(LU, n); }

	{ for j := 0 to n-1 do }
	{ begin }
		{ LU[0, j] := A[0, j]; }
		{ LU[j, 0] := A[j, 0] / LU[0, 0]; }
	{ end; }

	{ for i := 1 to n-1 do }
	{ begin }
		{ for j := i to n-1 do }
		{ begin }
			{ acc := 0; }
			{ for k := 0 to (i-2) do }
				{ acc := acc + LU[i, k] * LU[k, j]; }
			{ LU[i, j] := A[i, j] - acc; }
		{ end; }

		{ for j := i to n-1 do }
		{ begin }
			{ acc := 0; }
			{ for k := 0 to (i-2) do }
				{ acc := acc + LU[j, k] * LU[k, i]; }
			{ LU[j, i] := 1/LU[i, i] * (LU[j, i] - acc); }
		{ end; }
	{ end; }

	{ LUDecomposition := LU; }
{ end; }

function Determinant(A: Matrix): real;
var
	LU: MatrixTuple;
	det: real;
	i: integer;
begin
	LU := LUDecomposition(A);
	det := 1;
	for i := 0 to Length(LU[1])-1 do
	begin
		det := det * LU[1][i, i];
	end;

	Determinant := det;
end;

function ForwardBackwardSubst(L: RealMatrix; U: RealMatrix; B: TRealDynArray): TRealDynArray;
{ Following http://en.wikipedia.org/wiki/Triangular_matrix#Forward_and_back_substitution }
var
	i, j, n: integer;
	X, Y: TRealDynArray;
begin
	{ Ax = b -> LUx = b. Then y is defined to be Ux }
	i := 0;
	j := 0;
	n := Length(b);
	SetLength(X, n);
	SetLength(Y, n);
	{ Forward solve Ly = b }
	for i := 0 to n-1 do
	begin
		Y[i] := B[i];
		for  j := 0 to i-1 do
			Y[i] := Y[i] - L[i, j] * Y[j];
		Y[i] := Y[i] / L[i, i];
	end;
	{ Backward solve Ux = y }
	for i := n-1 downto 0 do
	begin
		X[i] := Y[i];
		for  j := i + 1 to n-1 do
			X[i] := X[i] - U[i, j] * X[j];
		X[i] := X[i] / U[i, i];
	end;

	ForwardBackwardSubst := X;
end;

function Eye(n: integer): Matrix;
var
	j, k: integer;
	I: Matrix;
begin
	SetLength(I, n);
	for j := 0 to n-1 do
	begin
		SetLength(I[j], n);
		for k := 0 to n-1 do
			if j = k then
				I[j, k] := 1
			else
				I[j, k] := 0;
	end;
	Eye := I;
end;

function ConcatMatrix(A: RealMatrix; B: RealMatrix): RealMatrix;
var
	S: RealMatrix;
	i, j, m, n: integer;
begin
	m := Length(A);
	n := Length(A[0]);
	InitMatrix(S, Length(A), Length(A[0]) + Length(B[0]));
	for i:=0 to m-1 do
	begin
		for j:=0 to n-1 do
			S[i][j] := A[i][j];
		for j:=0 to Length(B[0])-1 do
			S[i][n+j] := B[i][j]
	end;
	ConcatMatrix := S;
end;

procedure ReduceRow(var A: RealMatrix; row: integer; by_row: integer; start: integer);
var
	i: integer;
	x: real;
begin
	x := -1 * A[row][start] / A[by_row][start];
	for i:=start to Length(A[0])-1 do
		A[row][i] := x * A[by_row][i] + A[row][i];
end;

function GaussElimination(A: RealMatrix; B: RealMatrix): RealMatrix;
var
	S: RealMatrix;	{ matrix A augmented with B }
	i, j, k, m, n: integer;
	free_sum: real;
begin
	S := ConcatMatrix(A, B);
	m := Length(A);
	n := Length(A[0]);

	{ Forward phase }

	for i:=m-1 downto 1 do
	begin
		for j:=0 to n-1-(m-i) do
		begin
			if S[i][j] <> 0 then
				ReduceRow(S, i, i-1, j);
			if j < n-1-(m-i) then
				ReduceRow(S, i-1, i-2, j);
		end;
	end;

	{ Backward phase }

	for i:=m-1 downto 0 do
	begin
		k := n-(m-i);
		free_sum := 0;
		for j := k+1 to n-1 do
			free_sum := free_sum + S[j][Length(S[0])-1] * S[i][j];
		S[i][Length(S[0])-1] := (S[i][Length(S[0])-1] - free_sum) / S[i][k];
	end;

	for i:=0 to Length(B)-1 do
		B[i][0] := S[i][Length(S[0])-1];

	GaussElimination := B;
end;



{ initialization }

{ finalization }

end.
