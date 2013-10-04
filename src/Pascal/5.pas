program SumRows;

uses
	crt,
	Matrix2D;

const
	N = 5;

var
	A: Matrix;
	i: integer;
	RSum: array of integer;

begin
	A := Gen2DMatrix(N);
	SetLength(RSum, N);
	Print2DMatrix(A);	
	for i:=Low(A) to High(A) do
		RSum[i] := SumArray(A[i]);
	PrintArray(RSum);
end.
