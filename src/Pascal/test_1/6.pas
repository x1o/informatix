program CountInRangeByRow;

uses
	Matrix2D;

const
	LOW_BOUND = -2;
	HIGH_BOUND = 10;

var
	M: Matrix;
	A: array[0..7] of integer;
	i, j: integer;

begin

	M := Gen2DMatrix(6, 8, 20);
	Print2DMatrix(M, ' ');
	
	for i:=Low(M) to High(M) do
	begin
		A[i] := 0;
		for j:=Low(M[i]) to High(M[i]) do
			if (M[i][j] > LOW_BOUND) and (M[i][j] < HIGH_BOUND) then
			Inc(A[i]);
	end;

	writeln();
	PrintArray(A, ' ');
end.
