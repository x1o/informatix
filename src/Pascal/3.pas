program SumDiag;

uses
	crt,
	Matrix2D;

var
	A: Matrix;

function SumDiag2DMatrix(A: Matrix): integer;
var
	DiagSum: integer = 0;
	i: integer;
begin
	for i:=Low(A) to High(A) do
		Inc(DiagSum, A[i, i]);
	
	SumDiag2DMatrix := DiagSum;
end;

begin
	clrscr;
	randomize;

	A := Gen2DMatrix();
	writeln('Finding the sum of diagonal elements of the matrix:');
	Print2DMatrix(A);
	writeln('---');
	writeln('It''s ', SumDiag2DMatrix(A));
end.
