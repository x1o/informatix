program SumOffDiagonals;

uses
	Matrix2D,
	crt;

var
	M: Matrix;
	x, size, S_u, S_d: integer;

begin
	clrscr;

	write('n: ');
	readln(size);

	M := Gen2DMatrix(size);
	Print2DMatrix(M);
	writeln('');

	S_u := 0;
	S_d := 0;
	for x:=0 to size-1 do
	begin
		if (x <> 0) then
			Inc(S_d, SumArray(M[x][0..x-1]));
		if (x <> size-1) then
			Inc(S_u, SumArray(M[x][x+1..size-1]));
	end;

	writeln('S_u: ', S_u);
	writeln('S_d: ', S_d);
end.
