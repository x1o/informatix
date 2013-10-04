program FlipMatrix;

uses
	Matrix2D,
	crt;

var
	M: Matrix;
	x, y, size, temp: integer;

begin
	write('n: ');
	readln(size);

	M := Gen2DMatrix(size);
	Print2DMatrix(M);
	writeln('');

	for x:=1 to size-1 do
		for y:=0 to (x-1) do
		begin
			temp := M[y][x];
			M[y][x] := M[x][y];
			M[x][y] := temp;
		end;

	Print2DMatrix(M);
end.
