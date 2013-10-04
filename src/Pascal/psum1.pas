program PartSum1;

uses
	crt,
	Math;

var
	x: real;
	n: integer;

function Sn(x: real; n: integer): real;
var
	accum: real = 0;
	i: integer;
begin
	for i:=0 to n do
		accum := accum + power((x+i), 2);
	Sn := accum;
end;

begin
	write('x = ');
	read(x);
	write('n = ');
	read(n);

	writeln(Sn(x, n):0:0);
end.


