program RepeatedIntInColumn;

uses
	Matrix2D;

var
	M: Matrix;
	i, j, k: integer;

begin
	M := Gen2DMatrix(5);
	Print2DMatrix(M);
	for i:=Low(M[1]) to High(M[1]) do
		for j:=Low(M) to High(M) do
			for k:=(j+1) to (High(M)) do
				{ writeln(M[j][i], ' ? ', M[k][i]);	}
				if (M[j][i] = M[k][i]) then
					writeln('at column ', i, ': ', M[j][i], ' = ', M[k][i]);
end.