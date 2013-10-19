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
	SetLength(Mx, n);
	for i:=Low(Mx) to High(Mx) do
	begin
		SetLength(Mx[i], m);
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


{ initialization }

{ finalization }

end.
