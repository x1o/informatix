unit Matrix2D;

interface

uses
	SysUtils,
	Math,
	Strings;

type 
	Matrix = array of array of integer;
	TIntDynArray = array of integer;


procedure PrintArray(A: array of LongInt; sep: string = #10);
procedure PrintArray(A: TStringDynArray; sep: string = #10);
procedure Print2DMatrix(A: Matrix; sep: string = ' ');
function Gen2DMatrix(m: integer = 3; n: integer = 0; RMax: integer = 10): Matrix;
function SumArray(A: array of LongInt): integer;
function StringToIntArray(S: string; sep: char = ' '): TIntDynArray;
function Transpose(A: Matrix): Matrix;
function Multiply(A: Matrix; B: Matrix): Matrix;
function Multiply(A: Matrix; c: integer): Matrix;
procedure InitMatrix(var A: Matrix; m: integer; n: integer = 0);



implementation

uses
	crt;

procedure PrintArray(A: TStringDynArray; sep: string = #10); overload;
var
	i: integer;
begin
	for i:=Low(A) to High(A) do
		write(A[i], sep);
	writeln('');
end;

procedure PrintArray(A: array of LongInt; sep: string = #10); overload;
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

procedure Print2DMatrix(A: Matrix; sep: string = ' ');
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

procedure InitMatrix(var A: Matrix; m: integer; n: integer = 0);
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

function Multiply(A: Matrix; c: integer): Matrix;	overload;
var
	i, j: integer;
begin
	for i := 0 to (Length(A) - 1) do
		for j := 0 to (Length(A[0]) - 1) do
			A[i][j] := A[i][j] * c;

	Multiply := A;
end;


{ initialization }

{ finalization }

end.
