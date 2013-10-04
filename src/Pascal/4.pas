program FindPolynomRoots;

uses	crt,
	Variants;

var
	a, b, c: real;
	xs: variant;

function die(msg: string): integer;
begin
	writeln(msg);
	exit(1);
end;

function solve_polynomial_1deg(b, c: real): real;
begin
	solve_polynomial_1deg := (-c/b);
end;

function solve_polynomial_2deg(a, b, c: real): variant;
var
	D: real;
	V: variant;
begin
	D := (b*b - 4*a*c);
	if (D < 0) then
		die('The equation does not have roots in R.')
	else
		if (D = 0) then
			V := (-b) / (2*a)
		else
		begin
			V := VarArrayCreate([0, 1], varDouble);
			V[0] := (-b + sqrt(D)) / (2*a);
			V[1] := (-b - sqrt(D)) / (2*a);
		end;
	solve_polynomial_2deg := V;
end;

procedure Test();
begin
	xs := solve_polynomial_2deg(-2, 3, 2);
	writeln(VarType(xs));
	writeln(varArray);
	xs := solve_polynomial_2deg(2, 4, 2);
	writeln(VarType(xs));
end;

procedure Main();
begin
	a := 0;
	b := 0;
	c := 0;

	write('Input a list of space-separated coefficients a, b and c: ');
	read(a, b, c);

	if (a = 0) then
		if (b = 0) then
			die('Error: At leas one of the a or b coefficients have to be specified.')
		else
			writeln('x = ', solve_polynomial_1deg(b, c))
	else
	begin
		xs := solve_polynomial_2deg(a, b, c);
		{ if (VarType(xs) and varTypeMask) = varArray then }
		{ if (VarArrayDimCount(xs) = 1) then }
		if not (VarType(xs) = varDouble) then
			writeln('x_1 = ', xs[0], ', x_2 = ', xs[1])
			{ writeln('x_1 = ', VarArrayGet(xs, [0]), ', x_2 = ', VarArrayGet(xs, [1])); }
		else
			writeln('x = ', xs)
	end;
end;

begin
	clrscr;
	{ Test(); }
	Main();
end.
