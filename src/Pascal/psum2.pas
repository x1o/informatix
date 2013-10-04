program PartSum2;

uses
	crt,
	Math,
	MathCustom;

var
	x: real;
	n: integer;

function Sn(x: real; n: integer): real;
var
	i: integer;
	accum: real = 0;
begin
	for i:=1 to n do
		accum := accum + (
			power((-1), (i+1))
		      * power(x, i)
		      / Factorial(i)
		);
	Sn := accum;
end;

begin
	write('x = ');
	read(x);
	write('n = ');
	read(n);

	writeln(Sn(x, n):0:2);
end.
