program MatrixTest;

uses Matrix2D;

var
	A: Matrix;
	B: Matrix;
	m, n, c: integer;

begin
	write('m = ');
	read(m);
	write('n = ');
	read(n);
	A := Gen2DMatrix(m, n);
	Print2DMatrix(A);
	writeln();

	writeln('A^T:');
	Print2DMatrix(Transpose(A));
	writeln();

	B := Gen2DMatrix(n, m);
	Print2DMatrix(A);
	writeln('x');
	Print2DMatrix(B);
	writeln('---');
	Print2DMatrix(Multiply(A, B));
	writeln();

	write('c (in ZZ) = ');
	read(c);
	writeln(c);
	writeln('*');
	Print2DMatrix(A);
	writeln('---');
	Print2DMatrix(Multiply(A, c));
end.
