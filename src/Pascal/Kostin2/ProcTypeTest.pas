type
	proc = procedure(var a, b: integer);
	func = function(angle: real): real;

var
	p2: proc;
	f1: func;

{$f+}
procedure swap(var a,b:integer);
var t: integer;
begin
	t:= a; a:= b; b:= t;
end;

function tan(angle: real): real;
begin
	tan:= sin(angle) / cos(angle);
end;
{$f-}

begin
	p2 := @swap;
	f1 := @tan;
	writeln(f1(Pi/4));
end.
