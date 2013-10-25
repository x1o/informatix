unit Matrix2D;

interface

uses
	SysUtils,
	Strings;

type 
	Matrix = array of array of integer;
	TIntDynArray = array of integer;


procedure PrintArray(A: array of LongInt; sep: string = #10);
procedure PrintArray(A: TStringDynArray; sep: string = #10);
procedure Print2DMatrix(A: Matrix; sep: string = ' ');
function Gen2DMatrix(n: integer = 3; RMax: integer = 10): Matrix;
function SumArray(A: array of LongInt): integer;
function StringToIntArray(S: string; sep: char = ' '): TIntDynArray;



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
	i: integer;
begin
	for i:=Low(A) to High(A) do
		write(A[i], sep);
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

function Gen2DMatrix(n: integer = 3; RMax: integer = 10): Matrix;
var
	M: Matrix;
	i, j: integer;
begin
	Randomize;
	SetLength(M, n);
	for i:=Low(M) to High(M) do
	begin
		SetLength(M[i], n);
		for j:=Low(M[0]) to High(M[0]) do
			M[i, j] := Random(RMax);
	end;
	Gen2DMatrix := M;
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


{ initialization }

{ finalization }

end.
